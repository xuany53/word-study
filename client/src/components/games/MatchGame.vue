<template>
  <div class="match-game">
    <!-- 游戏信息栏 -->
    <div class="game-header">
      <div class="game-stats">
        <div class="stat">
          <span class="label">配对</span>
          <span class="value">{{ matchedPairs }}/{{ totalPairs }}</span>
        </div>
        <div class="stat combo" :class="{ active: combo > 1 }">
          <span class="label">连击</span>
          <span class="value">x{{ combo }}</span>
        </div>
        <div class="stat">
          <span class="label">分数</span>
          <span class="value">{{ score }}</span>
        </div>
      </div>
      <div class="timer" :class="{ warning: timeLeft <= 10 }">
        <span class="timer-icon">⏱️</span>
        <span class="timer-value">{{ timeLeft }}s</span>
      </div>
    </div>

    <!-- 游戏区域 -->
    <div class="game-board">
      <div
        v-for="card in cards"
        :key="card.id"
        class="match-card"
        :class="{
          flipped: card.isFlipped || card.isMatched,
          matched: card.isMatched,
          wrong: wrongCardId === card.id
        }"
        @click="flipCard(card)"
      >
        <div class="card-inner">
          <div class="card-front">?</div>
          <div class="card-back" :class="card.type">
            {{ card.content }}
          </div>
        </div>
      </div>
    </div>

    <!-- 游戏结束弹窗 -->
    <div v-if="gameStatus === 'ended'" class="game-overlay">
      <div class="overlay-content result">
        <h2>{{ matchedPairs === totalPairs ? '完美通关！🎉' : '时间到！' }}</h2>
        <div class="result-stats">
          <div class="stat">
            <span class="stat-value">{{ matchedPairs }}</span>
            <span class="stat-label">配对成功</span>
          </div>
          <div class="stat">
            <span class="stat-value">{{ score }}</span>
            <span class="stat-label">总分</span>
          </div>
          <div class="stat">
            <span class="stat-value">{{ maxCombo }}</span>
            <span class="stat-label">最大连击</span>
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
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import type { MatchCard, Word } from '@/types/game'

// Props
interface Props {
  words?: Word[]
  timeLimit?: number
}

const props = withDefaults(defineProps<Props>(), {
  words: () => [],
  timeLimit: 60
})

// Emits
const emit = defineEmits<{
  (e: 'gameEnd', result: { score: number; matchedPairs: number; xpEarned: number }): void
  (e: 'exit'): void
}>()

// 游戏状态
const cards = ref<MatchCard[]>([])
const flippedCards = ref<MatchCard[]>([])
const matchedPairs = ref(0)
const totalPairs = ref(0)
const score = ref(0)
const combo = ref(0)
const maxCombo = ref(0)
const timeLeft = ref(props.timeLimit)
const gameStatus = ref<'playing' | 'ended'>('playing')
const xpEarned = ref(0)
const wrongCardId = ref<string | null>(null)

let timer: ReturnType<typeof setInterval> | null = null
let wrongTimer: ReturnType<typeof setTimeout> | null = null

// 初始化游戏
onMounted(() => {
  initGame()
  startTimer()
})

onUnmounted(() => {
  stopTimer()
})

// 初始化游戏
const initGame = () => {
  // 从单词列表中选择单词
  const selectedWords = [...props.words]
    .sort(() => Math.random() - 0.5)
    .slice(0, 6)

  totalPairs.value = selectedWords.length

  // 创建卡片
  const cardList: MatchCard[] = []
  selectedWords.forEach((word, index) => {
    const id = `word-${index}`
    const meaning = (word as any).meaning || (word as any).meanings?.[0]?.translation || ''

    // 单词卡片
    cardList.push({
      id: `card-${id}-word`,
      content: word.word,
      type: 'word',
      pairId: id,
      isFlipped: false,
      isMatched: false
    })

    // 释义卡片
    cardList.push({
      id: `card-${id}-meaning`,
      content: meaning,
      type: 'meaning',
      pairId: id,
      isFlipped: false,
      isMatched: false
    })
  })

  // 随机排列
  cards.value = cardList.sort(() => Math.random() - 0.5)
}

// 开始计时
const startTimer = () => {
  timer = setInterval(() => {
    timeLeft.value--
    if (timeLeft.value <= 0) {
      endGame()
    }
  }, 1000)
}

// 停止计时
const stopTimer = () => {
  if (timer) {
    clearInterval(timer)
    timer = null
  }
}

// 翻转卡片
const flipCard = (card: MatchCard) => {
  if (
    gameStatus.value === 'ended' ||
    card.isFlipped ||
    card.isMatched ||
    flippedCards.value.length >= 2
  ) {
    return
  }

  card.isFlipped = true
  flippedCards.value.push(card)

  if (flippedCards.value.length === 2) {
    checkMatch()
  }
}

// 检查匹配
const checkMatch = async () => {
  const [card1, card2] = flippedCards.value

  if (card1.pairId === card2.pairId && card1.type !== card2.type) {
    // 匹配成功
    card1.isMatched = true
    card2.isMatched = true
    matchedPairs.value++
    combo.value++
    maxCombo.value = Math.max(maxCombo.value, combo.value)
    score.value += 10 * combo.value

    // 检查是否完成
    if (matchedPairs.value === totalPairs.value) {
      // 奖励时间
      score.value += timeLeft.value * 2
      endGame()
    }
  } else {
    // 匹配失败
    combo.value = 0

    // 显示错误效果
    wrongCardId.value = card1.id
    setTimeout(() => {
      wrongCardId.value = card2.id
    }, 200)

    // 延迟翻回
    await new Promise(resolve => setTimeout(resolve, 800))
    card1.isFlipped = false
    card2.isFlipped = false
  }

  wrongCardId.value = null
  flippedCards.value = []
}

// 结束游戏
const endGame = () => {
  gameStatus.value = 'ended'
  stopTimer()

  // 计算XP
  xpEarned.value = Math.floor(score.value / 3)

  emit('gameEnd', {
    score: score.value,
    matchedPairs: matchedPairs.value,
    xpEarned: xpEarned.value
  })
}

// 重新开始
const restartGame = () => {
  matchedPairs.value = 0
  score.value = 0
  combo.value = 0
  maxCombo.value = 0
  timeLeft.value = props.timeLimit
  gameStatus.value = 'playing'
  xpEarned.value = 0
  flippedCards.value = []

  initGame()
  startTimer()
}

// 退出游戏
const exitGame = () => {
  stopTimer()
  emit('exit')
}
</script>

<style scoped>
.match-game {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
  border-radius: 16px;
  padding: 16px;
  max-width: 500px;
  margin: 0 auto;
}

.game-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.game-stats {
  display: flex;
  gap: 16px;
}

.game-stats .stat {
  text-align: center;
  background: rgba(255, 255, 255, 0.1);
  padding: 8px 12px;
  border-radius: 8px;
}

.game-stats .label {
  display: block;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.7);
}

.game-stats .value {
  display: block;
  font-size: 18px;
  font-weight: bold;
  color: #fff;
}

.game-stats .combo.active .value {
  color: #ffd700;
}

.timer {
  display: flex;
  align-items: center;
  gap: 4px;
  background: rgba(255, 255, 255, 0.1);
  padding: 8px 16px;
  border-radius: 20px;
}

.timer.warning {
  background: rgba(244, 67, 54, 0.3);
  animation: pulse 1s infinite;
}

.timer-icon {
  font-size: 20px;
}

.timer-value {
  font-size: 18px;
  font-weight: bold;
  color: #fff;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

.game-board {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 8px;
  margin-bottom: 16px;
}

.match-card {
  aspect-ratio: 1;
  perspective: 1000px;
  cursor: pointer;
}

.card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transition: transform 0.4s;
  transform-style: preserve-3d;
}

.match-card.flipped .card-inner {
  transform: rotateY(180deg);
}

.match-card.matched .card-inner {
  animation: matchSuccess 0.5s ease;
}

.match-card.wrong .card-inner {
  animation: shake 0.3s ease;
}

@keyframes matchSuccess {
  0% { transform: rotateY(180deg) scale(1); }
  50% { transform: rotateY(180deg) scale(1.1); }
  100% { transform: rotateY(180deg) scale(1); }
}

@keyframes shake {
  0%, 100% { transform: rotateY(180deg) translateX(0); }
  25% { transform: rotateY(180deg) translateX(-5px); }
  75% { transform: rotateY(180deg) translateX(5px); }
}

.card-front, .card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  padding: 8px;
  text-align: center;
  word-break: break-word;
}

.card-front {
  background: linear-gradient(135deg, #2196f3, #1976d2);
  color: #fff;
  font-size: 24px;
}

.card-back {
  transform: rotateY(180deg);
  font-size: 14px;
}

.card-back.word {
  background: linear-gradient(135deg, #4caf50, #2e7d32);
  color: #fff;
}

.card-back.meaning {
  background: linear-gradient(135deg, #ff9800, #f57c00);
  color: #fff;
}

.match-card.matched .card-back {
  box-shadow: 0 0 20px rgba(76, 175, 80, 0.5);
}

/* 游戏结束弹窗 */
.game-overlay {
  position: fixed;
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

.overlay-content.result {
  text-align: center;
  color: #fff;
  padding: 32px;
  background: var(--bg-primary);
  border-radius: 20px;
  max-width: 320px;
}

.overlay-content.result h2 {
  font-size: 24px;
  margin-bottom: 24px;
  color: #ffd700;
}

.result-stats {
  display: flex;
  justify-content: center;
  gap: 24px;
  margin-bottom: 24px;
}

.result-stats .stat {
  text-align: center;
}

.result-stats .stat-value {
  display: block;
  font-size: 28px;
  font-weight: bold;
  color: #ffd700;
}

.result-stats .stat-label {
  font-size: 12px;
  color: var(--text-secondary);
}

.reward {
  margin-bottom: 24px;
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
}

.retry-btn {
  flex: 1;
  background: linear-gradient(135deg, #4caf50, #2e7d32);
  color: #fff;
  border: none;
  padding: 12px;
  font-size: 16px;
  font-weight: bold;
  border-radius: 24px;
  cursor: pointer;
}

.exit-btn {
  flex: 1;
  background: var(--bg-secondary);
  color: var(--text-primary);
  border: none;
  padding: 12px;
  font-size: 16px;
  border-radius: 24px;
  cursor: pointer;
}
</style>