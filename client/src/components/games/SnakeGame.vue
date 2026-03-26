<template>
  <div class="snake-game">
    <!-- 游戏信息栏 -->
    <div class="game-header">
      <div class="score-board">
        <div class="score-item">
          <span class="label">分数</span>
          <span class="value">{{ score }}</span>
        </div>
        <div class="score-item combo" :class="{ active: combo > 1 }">
          <span class="label">连击</span>
          <span class="value">x{{ combo }}</span>
        </div>
        <div class="score-item">
          <span class="label">生命</span>
          <span class="value">{{ lives }}</span>
        </div>
      </div>
      <div class="question-area" v-if="currentFood">
        <span class="question-label">吃掉：</span>
        <span class="question-word">{{ currentFood.meaning }}</span>
      </div>
    </div>

    <!-- 游戏画布 -->
    <div class="game-canvas" ref="canvasContainer">
      <canvas ref="canvas" :width="canvasSize" :height="canvasSize"></canvas>

      <!-- 游戏遮罩层 -->
      <div v-if="gameStatus === 'idle'" class="game-overlay">
        <div class="overlay-content">
          <h2>单词贪吃蛇</h2>
          <p>吃掉正确的单词！</p>
          <button class="start-btn" @click="startGame">开始游戏</button>
        </div>
      </div>

      <div v-if="gameStatus === 'paused'" class="game-overlay">
        <div class="overlay-content">
          <h2>游戏暂停</h2>
          <button class="start-btn" @click="resumeGame">继续游戏</button>
        </div>
      </div>

      <div v-if="gameStatus === 'ended'" class="game-overlay">
        <div class="overlay-content result">
          <h2>{{ score >= 100 ? '太棒了！' : score >= 50 ? '不错！' : '继续加油！' }}</h2>
          <div class="result-stats">
            <div class="stat">
              <span class="stat-value">{{ score }}</span>
              <span class="stat-label">总分</span>
            </div>
            <div class="stat">
              <span class="stat-value">{{ maxCombo }}</span>
              <span class="stat-label">最大连击</span>
            </div>
            <div class="stat">
              <span class="stat-value">{{ correctCount }}</span>
              <span class="stat-label">正确</span>
            </div>
          </div>
          <div class="reward" v-if="xpEarned > 0">
            <span class="xp">+{{ xpEarned }} XP</span>
          </div>
          <div class="result-actions">
            <button class="retry-btn" @click="restartGame">再来一局</button>
            <button class="exit-btn" @click="exitGame">退出</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 移动端控制 -->
    <div class="mobile-controls">
      <button class="control-btn" @click="changeDirection('up')">▲</button>
      <div class="horizontal-controls">
        <button class="control-btn" @click="changeDirection('left')">◀</button>
        <button class="control-btn" @click="changeDirection('right')">▶</button>
      </div>
      <button class="control-btn" @click="changeDirection('down')">▼</button>
    </div>

    <!-- 操作提示 -->
    <div class="game-tips">
      <p>使用方向键或点击按钮控制蛇的方向</p>
      <p>吃掉显示的中文对应的英文单词</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, watch, nextTick } from 'vue'
import type { SnakeDirection, FoodItem, Word } from '@/types/game'

// Props
interface Props {
  words?: Word[]
  canvasSize?: number
  gridSize?: number
}

const props = withDefaults(defineProps<Props>(), {
  words: () => [],
  canvasSize: 400,
  gridSize: 20
})

// Emits
const emit = defineEmits<{
  (e: 'gameEnd', result: { score: number; combo: number; correctCount: number; xpEarned: number }): void
  (e: 'exit'): void
}>()

// 游戏状态
const canvas = ref<HTMLCanvasElement | null>(null)
const canvasContainer = ref<HTMLDivElement | null>(null)
const ctx = ref<CanvasRenderingContext2D | null>(null)

const gameStatus = ref<'idle' | 'playing' | 'paused' | 'ended'>('idle')
const snake = ref<Array<{ x: number; y: number }>>([])
const direction = ref<SnakeDirection>('right')
const nextDirection = ref<SnakeDirection>('right')
const foods = ref<FoodItem[]>([])
const currentFood = ref<FoodItem | null>(null)
const score = ref(0)
const combo = ref(0)
const maxCombo = ref(0)
const lives = ref(3)
const correctCount = ref(0)
const xpEarned = ref(0)
const speed = ref(150)

let gameLoop: ReturnType<typeof setInterval> | null = null
let wordIndex = 0

// 计算属性
const cellSize = computed(() => props.canvasSize / props.gridSize)

// 初始化画布
onMounted(() => {
  if (canvas.value) {
    ctx.value = canvas.value.getContext('2d')
  }
})

// 键盘控制
const handleKeydown = (e: KeyboardEvent) => {
  if (gameStatus.value !== 'playing') return

  const keyMap: Record<string, SnakeDirection> = {
    ArrowUp: 'up',
    ArrowDown: 'down',
    ArrowLeft: 'left',
    ArrowRight: 'right',
    w: 'up',
    s: 'down',
    a: 'left',
    d: 'right',
    W: 'up',
    S: 'down',
    A: 'left',
    D: 'right'
  }

  const newDir = keyMap[e.key]
  if (newDir) {
    changeDirection(newDir)
    e.preventDefault()
  }
}

onMounted(() => {
  window.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  window.removeEventListener('keydown', handleKeydown)
  stopGameLoop()
})

// 改变方向
const changeDirection = (newDir: SnakeDirection) => {
  const opposites: Record<SnakeDirection, SnakeDirection> = {
    up: 'down',
    down: 'up',
    left: 'right',
    right: 'left'
  }

  // 不能反向
  if (opposites[newDir] !== direction.value) {
    nextDirection.value = newDir
  }
}

// 开始游戏
const startGame = () => {
  resetGame()
  gameStatus.value = 'playing'
  spawnFoods()
  startGameLoop()
}

// 暂停游戏
const pauseGame = () => {
  if (gameStatus.value === 'playing') {
    gameStatus.value = 'paused'
    stopGameLoop()
  }
}

// 继续游戏
const resumeGame = () => {
  gameStatus.value = 'playing'
  startGameLoop()
}

// 重置游戏
const resetGame = () => {
  // 初始化蛇（从中间开始）
  const centerX = Math.floor(props.gridSize / 2)
  const centerY = Math.floor(props.gridSize / 2)
  snake.value = [
    { x: centerX, y: centerY },
    { x: centerX - 1, y: centerY },
    { x: centerX - 2, y: centerY }
  ]

  direction.value = 'right'
  nextDirection.value = 'right'
  foods.value = []
  currentFood.value = null
  score.value = 0
  combo.value = 0
  maxCombo.value = 0
  lives.value = 3
  correctCount.value = 0
  xpEarned.value = 0
  speed.value = 150
  wordIndex = 0
}

// 生成食物
const spawnFoods = () => {
  if (props.words.length === 0) return

  // 选择当前单词
  const correctWord = props.words[wordIndex % props.words.length]
  wordIndex++

  // 获取错误选项
  const wrongWords = props.words.filter(w => w.id !== correctWord.id)
  const shuffledWrong = wrongWords.sort(() => Math.random() - 0.5).slice(0, 3)

  // 生成食物位置
  const positions = getRandomPositions(4)

  // 创建正确食物
  foods.value = [{
    position: positions[0],
    word: correctWord.word,
    meaning: (correctWord as any).meaning || (correctWord as any).meanings?.[0]?.translation || '',
    isCorrect: true
  }]

  // 创建错误食物
  shuffledWrong.forEach((word, i) => {
    foods.value.push({
      position: positions[i + 1],
      word: word.word,
      meaning: (word as any).meaning || (word as any).meanings?.[0]?.translation || '',
      isCorrect: false
    })
  })

  // 设置当前问题
  currentFood.value = foods.value.find(f => f.isCorrect) || null
}

// 获取随机位置
const getRandomPositions = (count: number): Array<{ x: number; y: number }> => {
  const positions: Array<{ x: number; y: number }> = []
  const occupied = new Set<string>()

  // 标记蛇的位置
  snake.value.forEach(s => occupied.add(`${s.x},${s.y}`))

  while (positions.length < count) {
    const x = Math.floor(Math.random() * (props.gridSize - 2)) + 1
    const y = Math.floor(Math.random() * (props.gridSize - 2)) + 1

    if (!occupied.has(`${x},${y}`)) {
      positions.push({ x, y })
      occupied.add(`${x},${y}`)
    }
  }

  return positions
}

// 游戏主循环
const startGameLoop = () => {
  if (gameLoop) return

  gameLoop = setInterval(() => {
    update()
    draw()
  }, speed.value)
}

const stopGameLoop = () => {
  if (gameLoop) {
    clearInterval(gameLoop)
    gameLoop = null
  }
}

// 更新游戏状态
const update = () => {
  // 更新方向
  direction.value = nextDirection.value

  // 计算新头部位置
  const head = snake.value[0]
  let newHead = { ...head }

  switch (direction.value) {
    case 'up':
      newHead.y -= 1
      break
    case 'down':
      newHead.y += 1
      break
    case 'left':
      newHead.x -= 1
      break
    case 'right':
      newHead.x += 1
      break
  }

  // 检查撞墙
  if (newHead.x < 0 || newHead.x >= props.gridSize ||
      newHead.y < 0 || newHead.y >= props.gridSize) {
    handleCollision('wall')
    return
  }

  // 检查撞自己
  if (snake.value.some(s => s.x === newHead.x && s.y === newHead.y)) {
    handleCollision('self')
    return
  }

  // 移动蛇
  snake.value.unshift(newHead)

  // 检查是否吃到食物
  const eatenFood = foods.value.find(f =>
    f.position.x === newHead.x && f.position.y === newHead.y
  )

  if (eatenFood) {
    if (eatenFood.isCorrect) {
      // 吃对了
      combo.value++
      maxCombo.value = Math.max(maxCombo.value, combo.value)
      correctCount.value++
      score.value += 10 * combo.value

      // 加速
      if (speed.value > 80) {
        speed.value -= 2
        stopGameLoop()
        startGameLoop()
      }
    } else {
      // 吃错了
      combo.value = 0
      lives.value--

      // 缩短蛇（移除尾部）
      snake.value.pop()

      if (lives.value <= 0) {
        endGame()
        return
      }
    }

    // 生成新食物
    spawnFoods()
  } else {
    // 没吃到食物，移除尾部
    snake.value.pop()
  }
}

// 处理碰撞
const handleCollision = (type: 'wall' | 'self') => {
  lives.value--
  combo.value = 0

  if (lives.value <= 0) {
    endGame()
  } else {
    // 重置蛇的位置
    const centerX = Math.floor(props.gridSize / 2)
    const centerY = Math.floor(props.gridSize / 2)
    snake.value = [
      { x: centerX, y: centerY },
      { x: centerX - 1, y: centerY },
      { x: centerX - 2, y: centerY }
    ]
    direction.value = 'right'
    nextDirection.value = 'right'
    spawnFoods()
  }
}

// 结束游戏
const endGame = () => {
  gameStatus.value = 'ended'
  stopGameLoop()

  // 计算XP奖励
  xpEarned.value = Math.floor(score.value / 2)

  emit('gameEnd', {
    score: score.value,
    combo: maxCombo.value,
    correctCount: correctCount.value,
    xpEarned: xpEarned.value
  })
}

// 重新开始
const restartGame = () => {
  startGame()
}

// 退出游戏
const exitGame = () => {
  stopGameLoop()
  emit('exit')
}

// 绘制游戏
const draw = () => {
  if (!ctx.value) return

  const ctx2 = ctx.value
  const size = cellSize.value

  // 清空画布
  ctx2.fillStyle = '#1a1a2e'
  ctx2.fillRect(0, 0, props.canvasSize, props.canvasSize)

  // 绘制网格
  ctx2.strokeStyle = '#16213e'
  ctx2.lineWidth = 0.5
  for (let i = 0; i <= props.gridSize; i++) {
    ctx2.beginPath()
    ctx2.moveTo(i * size, 0)
    ctx2.lineTo(i * size, props.canvasSize)
    ctx2.stroke()
    ctx2.beginPath()
    ctx2.moveTo(0, i * size)
    ctx2.lineTo(props.canvasSize, i * size)
    ctx2.stroke()
  }

  // 绘制食物
  foods.value.forEach(food => {
    const x = food.position.x * size
    const y = food.position.y * size

    // 食物背景
    ctx2.fillStyle = food.isCorrect ? '#4caf50' : '#f44336'
    ctx2.beginPath()
    ctx2.arc(x + size / 2, y + size / 2, size * 0.4, 0, Math.PI * 2)
    ctx2.fill()

    // 单词
    ctx2.fillStyle = '#fff'
    ctx2.font = `bold ${size * 0.38}px Arial`
    ctx2.textAlign = 'center'
    ctx2.textBaseline = 'middle'
    ctx2.fillText(food.word.slice(0, 4), x + size / 2, y + size / 2)
  })

  // 绘制蛇
  snake.value.forEach((segment, index) => {
    const x = segment.x * size
    const y = segment.y * size

    // 蛇身渐变
    const gradient = ctx2.createLinearGradient(x, y, x + size, y + size)
    if (index === 0) {
      // 蛇头
      gradient.addColorStop(0, '#ffd700')
      gradient.addColorStop(1, '#ff9800')
    } else {
      // 蛇身
      const alpha = 1 - (index / snake.value.length) * 0.5
      gradient.addColorStop(0, `rgba(76, 175, 80, ${alpha})`)
      gradient.addColorStop(1, `rgba(56, 142, 60, ${alpha})`)
    }

    ctx2.fillStyle = gradient
    ctx2.beginPath()
    ctx2.roundRect(x + 1, y + 1, size - 2, size - 2, 4)
    ctx2.fill()

    // 蛇头眼睛
    if (index === 0) {
      ctx2.fillStyle = '#000'
      const eyeSize = size * 0.15
      const eyeOffset = size * 0.25

      // 根据方向调整眼睛位置
      let eye1X = x + size / 2 - eyeOffset
      let eye1Y = y + size / 2 - eyeOffset
      let eye2X = x + size / 2 + eyeOffset
      let eye2Y = y + size / 2 - eyeOffset

      ctx2.beginPath()
      ctx2.arc(eye1X, eye1Y, eyeSize, 0, Math.PI * 2)
      ctx2.fill()
      ctx2.beginPath()
      ctx2.arc(eye2X, eye2Y, eyeSize, 0, Math.PI * 2)
      ctx2.fill()
    }
  })
}
</script>

<style scoped>
.snake-game {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
  border-radius: 16px;
  max-width: 600px;
  margin: 0 auto;
}

.game-header {
  width: 100%;
  margin-bottom: 16px;
}

.score-board {
  display: flex;
  justify-content: space-around;
  margin-bottom: 12px;
}

.score-item {
  text-align: center;
  background: rgba(255, 255, 255, 0.1);
  padding: 8px 16px;
  border-radius: 12px;
}

.score-item .label {
  display: block;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.7);
}

.score-item .value {
  display: block;
  font-size: 24px;
  font-weight: bold;
  color: #fff;
}

.score-item.combo.active .value {
  color: #ffd700;
  animation: pulse 0.5s infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.1); }
}

.question-area {
  background: rgba(255, 255, 255, 0.1);
  padding: 12px 20px;
  border-radius: 12px;
  text-align: center;
}

.question-label {
  color: rgba(255, 255, 255, 0.7);
  font-size: 14px;
}

.question-word {
  color: #ffd700;
  font-size: 20px;
  font-weight: bold;
  margin-left: 8px;
}

.game-canvas {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.game-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.85);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 10;
}

.overlay-content {
  text-align: center;
  color: #fff;
  padding: 24px;
}

.overlay-content h2 {
  font-size: 28px;
  margin-bottom: 16px;
  color: #ffd700;
}

.overlay-content p {
  color: rgba(255, 255, 255, 0.8);
  margin-bottom: 24px;
}

.start-btn, .retry-btn {
  background: linear-gradient(135deg, #4caf50, #2e7d32);
  color: #fff;
  border: none;
  padding: 12px 32px;
  font-size: 18px;
  font-weight: bold;
  border-radius: 24px;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.start-btn:hover, .retry-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
}

.result-stats {
  display: flex;
  justify-content: center;
  gap: 24px;
  margin: 24px 0;
}

.result-stats .stat {
  text-align: center;
}

.result-stats .stat-value {
  display: block;
  font-size: 32px;
  font-weight: bold;
  color: #ffd700;
}

.result-stats .stat-label {
  font-size: 14px;
  color: rgba(255, 255, 255, 0.7);
}

.reward {
  margin: 16px 0;
}

.reward .xp {
  font-size: 24px;
  font-weight: bold;
  color: #ffd700;
  background: linear-gradient(135deg, rgba(255, 215, 0, 0.2), rgba(255, 152, 0, 0.2));
  padding: 8px 24px;
  border-radius: 20px;
}

.result-actions {
  display: flex;
  gap: 12px;
  justify-content: center;
  margin-top: 24px;
}

.exit-btn {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
  border: 1px solid rgba(255, 255, 255, 0.3);
  padding: 12px 32px;
  font-size: 16px;
  border-radius: 24px;
  cursor: pointer;
  transition: background 0.2s;
}

.exit-btn:hover {
  background: rgba(255, 255, 255, 0.2);
}

.mobile-controls {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  margin-top: 16px;
}

.horizontal-controls {
  display: flex;
  gap: 60px;
}

.control-btn {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 12px;
  color: #fff;
  font-size: 20px;
  cursor: pointer;
  transition: all 0.2s;
}

.control-btn:hover, .control-btn:active {
  background: rgba(255, 255, 255, 0.2);
  border-color: #ffd700;
}

.game-tips {
  margin-top: 16px;
  text-align: center;
}

.game-tips p {
  color: rgba(255, 255, 255, 0.5);
  font-size: 12px;
  margin: 4px 0;
}

@media (min-width: 768px) {
  .mobile-controls {
    display: none;
  }
}
</style>