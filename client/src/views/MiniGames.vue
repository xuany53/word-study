<template>
  <div class="mini-games-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="nav-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <div class="page-title">
          <h1>🎮 小游戏中心</h1>
          <p class="subtitle">学习累了？玩个游戏放松一下！</p>
        </div>
      </div>

      <!-- 游戏机会显示 -->
      <div class="tickets-overview card">
        <div class="ticket-stat">
          <span class="ticket-icon">🐍</span>
          <span class="ticket-count">{{ snakeTickets }}</span>
          <span class="ticket-label">贪吃蛇机会</span>
        </div>
        <div class="ticket-stat">
          <span class="ticket-icon">🧩</span>
          <span class="ticket-count">{{ matchTickets }}</span>
          <span class="ticket-label">消消乐机会</span>
        </div>
      </div>

      <!-- 获取更多机会提示 -->
      <div class="earn-tips card">
        <h3>如何获得更多游戏机会？</h3>
        <ul>
          <li>✅ 完成一关闯关 → +1 次贪吃蛇</li>
          <li>✅ 每日打卡 → +1 次消消乐</li>
          <li>✅ 学习10个单词 → +1 次贪吃蛇</li>
        </ul>
      </div>

      <!-- 游戏列表 -->
      <div class="games-grid">
        <!-- 贪吃蛇 -->
        <div class="game-card card" @click="playSnake">
          <div class="game-icon">🐍</div>
          <h3 class="game-name">单词贪吃蛇</h3>
          <p class="game-desc">吃掉正确的单词，避开错误选项！</p>
          <div class="game-meta">
            <span class="meta-item">
              <span class="icon">🎫</span>
              {{ snakeTickets }} 次机会
            </span>
            <span class="meta-item difficulty easy">简单</span>
          </div>
          <button class="play-btn" :disabled="snakeTickets <= 0">
            {{ snakeTickets > 0 ? '开始游戏' : '机会不足' }}
          </button>
        </div>

        <!-- 消消乐 -->
        <div class="game-card card" @click="playMatch">
          <div class="game-icon">🧩</div>
          <h3 class="game-name">单词消消乐</h3>
          <p class="game-desc">配对单词和释义，轻松解压！</p>
          <div class="game-meta">
            <span class="meta-item">
              <span class="icon">🎫</span>
              {{ matchTickets }} 次机会
            </span>
            <span class="meta-item difficulty medium">中等</span>
          </div>
          <button class="play-btn" :disabled="matchTickets <= 0">
            {{ matchTickets > 0 ? '开始游戏' : '机会不足' }}
          </button>
        </div>

        <!-- 敬请期待 -->
        <div class="game-card card" @click="$router.push('/adventure')">
          <div class="game-icon">🗺️</div>
          <h3 class="game-name">单词大冒险</h3>
          <p class="game-desc">探索单词世界，收集成就！</p>
          <div class="game-meta">
            <span class="meta-item">
              <span class="icon">🚶</span>
              打卡探险
            </span>
            <span class="meta-item difficulty hard">冒险</span>
          </div>
          <button class="play-btn">开始冒险</button>
        </div>

        <div class="game-card card" @click="$router.push('/farm')">
          <div class="game-icon">🌱</div>
          <h3 class="game-name">单词农场</h3>
          <p class="game-desc">养成你的单词花园！</p>
          <div class="game-meta">
            <span class="meta-item">
              <span class="icon">🌾</span>
              种植收获
            </span>
            <span class="meta-item difficulty medium">养成</span>
          </div>
          <button class="play-btn">进入农场</button>
        </div>
      </div>
    </div>

    <!-- 贪吃蛇游戏弹窗 -->
    <Teleport to="body">
      <Transition name="fade">
        <div v-if="showSnakeGame" class="game-modal">
          <div class="game-modal-content">
            <SnakeGame
              :words="words"
              :canvas-size="480"
              :grid-size="15"
              @game-end="handleSnakeEnd"
              @exit="closeSnakeGame"
            />
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- 消消乐游戏弹窗 -->
    <Teleport to="body">
      <Transition name="fade">
        <div v-if="showMatchGame" class="game-modal">
          <div class="game-modal-content">
            <MatchGame
              :words="words"
              @game-end="handleMatchEnd"
              @exit="closeMatchGame"
            />
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore, useWordStore, useGamificationStore } from '@/stores'
import SnakeGame from '@/components/games/SnakeGame.vue'
import MatchGame from '@/components/games/MatchGame.vue'
import type { Word } from '@/types/word'

const router = useRouter()
const authStore = useAuthStore()
const wordStore = useWordStore()
const gamificationStore = useGamificationStore()

// 游戏机会
const snakeTickets = ref(3)
const matchTickets = ref(3)

// 游戏弹窗
const showSnakeGame = ref(false)
const showMatchGame = ref(false)

// 单词列表
const words = computed(() => wordStore.words as Word[])

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  // 获取单词
  if (wordStore.words.length === 0) {
    await wordStore.fetchWords(1)
  }

  // 从 localStorage 获取游戏机会
  loadTickets()
})

// 加载游戏机会
const loadTickets = () => {
  const saved = localStorage.getItem('gameTickets')
  if (saved) {
    const data = JSON.parse(saved)
    const today = new Date().toDateString()

    // 检查是否是新的一天
    if (data.date === today) {
      snakeTickets.value = data.snake || 3
      matchTickets.value = data.match || 3
    } else {
      // 新的一天，重置机会
      resetTickets()
    }
  } else {
    resetTickets()
  }
}

// 重置机会
const resetTickets = () => {
  snakeTickets.value = 3
  matchTickets.value = 3
  saveTickets()
}

// 保存机会
const saveTickets = () => {
  localStorage.setItem('gameTickets', JSON.stringify({
    date: new Date().toDateString(),
    snake: snakeTickets.value,
    match: matchTickets.value
  }))
}

// 玩贪吃蛇
const playSnake = () => {
  if (snakeTickets.value <= 0) return

  snakeTickets.value--
  saveTickets()
  showSnakeGame.value = true
}

// 关闭贪吃蛇
const closeSnakeGame = () => {
  showSnakeGame.value = false
}

// 贪吃蛇结束
const handleSnakeEnd = async (result: { score: number; combo: number; correctCount: number; xpEarned: number }) => {
  // 这里可以调用 API 保存游戏记录和获得 XP
  console.log('Snake game ended:', result)

  // 检查徽章
  await gamificationStore.checkBadges()
}

// 玩消消乐
const playMatch = () => {
  if (matchTickets.value <= 0) return

  matchTickets.value--
  saveTickets()
  showMatchGame.value = true
}

// 关闭消消乐
const closeMatchGame = () => {
  showMatchGame.value = false
}

// 消消乐结束
const handleMatchEnd = async (result: { score: number; xpEarned: number }) => {
  console.log('Match game ended:', result)

  // 检查徽章
  await gamificationStore.checkBadges()
}
</script>

<style scoped>
.mini-games-page {
  min-height: 100vh;
  padding: 20px 0;
}

.nav-header {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  margin-bottom: 24px;
}

.back-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  background: var(--bg-secondary);
  border: none;
  padding: 8px 16px;
  border-radius: var(--border-radius);
  cursor: pointer;
  font-size: 16px;
  color: var(--text-primary);
  transition: all var(--transition-fast);
}

.back-btn:hover {
  background: var(--primary-light);
  color: var(--primary-color);
}

.page-title {
  flex: 1;
}

.page-title h1 {
  font-size: 28px;
  margin-bottom: 8px;
}

.subtitle {
  color: var(--text-secondary);
}

.tickets-overview {
  display: flex;
  justify-content: space-around;
  margin-bottom: 16px;
}

.ticket-stat {
  text-align: center;
}

.ticket-icon {
  font-size: 32px;
  display: block;
  margin-bottom: 8px;
}

.ticket-count {
  font-size: 28px;
  font-weight: bold;
  color: var(--primary-color);
  display: block;
}

.ticket-label {
  font-size: 14px;
  color: var(--text-secondary);
}

.earn-tips {
  margin-bottom: 24px;
  padding: 16px;
}

.earn-tips h3 {
  font-size: 16px;
  margin-bottom: 12px;
  color: var(--primary-color);
}

.earn-tips ul {
  list-style: none;
  padding: 0;
}

.earn-tips li {
  padding: 8px 0;
  color: var(--text-secondary);
  border-bottom: 1px solid var(--bg-dark);
}

.earn-tips li:last-child {
  border-bottom: none;
}

.games-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 16px;
}

.game-card {
  position: relative;
  padding: 24px;
  text-align: center;
  transition: all 0.3s ease;
  cursor: pointer;
}

.game-card:hover:not(.coming-soon) {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}

.game-card.coming-soon {
  opacity: 0.7;
  cursor: default;
}

.game-icon {
  font-size: 48px;
  margin-bottom: 16px;
}

.game-name {
  font-size: 20px;
  margin-bottom: 8px;
}

.game-desc {
  color: var(--text-secondary);
  font-size: 14px;
  margin-bottom: 16px;
}

.game-meta {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-bottom: 16px;
}

.meta-item {
  font-size: 14px;
  color: var(--text-secondary);
}

.meta-item .icon {
  margin-right: 4px;
}

.meta-item.difficulty {
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 12px;
}

.meta-item.difficulty.easy {
  background: #e8f5e9;
  color: #2e7d32;
}

.meta-item.difficulty.medium {
  background: #fff3e0;
  color: #f57c00;
}

.play-btn {
  width: 100%;
  padding: 12px;
  background: var(--primary-color);
  color: white;
  border: none;
  border-radius: var(--border-radius);
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.play-btn:hover:not(:disabled) {
  background: var(--primary-dark);
}

.play-btn:disabled {
  background: var(--bg-dark);
  color: var(--text-secondary);
  cursor: not-allowed;
}

.coming-soon-badge {
  position: absolute;
  top: 16px;
  right: 16px;
  background: var(--primary-color);
  color: white;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 12px;
}

/* Game Modal */
.game-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 16px;
}

.game-modal-content {
  max-width: 100%;
  max-height: 100%;
  overflow: auto;
}

/* Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>