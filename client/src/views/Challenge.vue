<template>
  <div class="challenge-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="nav-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <div class="page-title">
          <h1>🎮 闯关模式</h1>
          <p class="subtitle">挑战自己，赢取丰厚奖励！</p>
        </div>
      </div>

      <!-- 进度统计 -->
      <div class="progress-overview card">
        <div class="progress-stat">
          <span class="progress-value">{{ completedLevels }}</span>
          <span class="progress-label">已完成</span>
        </div>
        <div class="progress-stat">
          <span class="progress-value">{{ totalStars }}</span>
          <span class="progress-label">总星数</span>
        </div>
        <div class="progress-stat">
          <span class="progress-value">{{ totalXpEarned }}</span>
          <span class="progress-label">获得 XP</span>
        </div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading">
        <div class="spinner"></div>
        <p>正在加载关卡...</p>
      </div>

      <!-- 关卡列表 -->
      <div v-else class="levels-container">
        <!-- 难度分组 -->
        <div
          v-for="group in levelGroups"
          :key="group.difficulty"
          class="difficulty-section"
        >
          <h2 class="difficulty-title" :class="group.difficulty">
            {{ difficultyLabels[group.difficulty] }}
          </h2>

          <div class="levels-grid">
            <div
              v-for="level in group.levels"
              :key="level.id"
              class="level-card"
              :class="[
                group.difficulty,
                { locked: !level.isUnlocked, passed: level.isPassed }
              ]"
              @click="startLevel(level)"
            >
              <!-- 锁定遮罩 -->
              <div v-if="!level.isUnlocked" class="lock-overlay">
                <span class="lock-icon">🔒</span>
                <span class="lock-text">完成前置关卡解锁</span>
              </div>

              <!-- 关卡内容 -->
              <div v-else class="level-content">
                <!-- 星级 -->
                <div class="stars">
                  <span
                    v-for="i in 3"
                    :key="i"
                    class="star"
                    :class="{ filled: i <= level.starRating }"
                  >⭐</span>
                </div>

                <!-- 关卡名称 -->
                <h3 class="level-name">{{ level.name }}</h3>

                <!-- 关卡信息 -->
                <div class="level-details">
                  <span class="detail">
                    <span class="icon">📝</span>
                    {{ level.wordCount }} 词
                  </span>
                  <span v-if="level.timeLimit" class="detail">
                    <span class="icon">⏱️</span>
                    {{ level.timeLimit }}s
                  </span>
                  <span class="detail">
                    <span class="icon">❌</span>
                    {{ level.maxErrors }} 次机会
                  </span>
                </div>

                <!-- XP 奖励 -->
                <div class="xp-reward">
                  <span class="xp-icon">✨</span>
                  <span class="xp-value">{{ level.xpReward }} XP</span>
                </div>

                <!-- 最佳时间 -->
                <div v-if="level.bestTime" class="best-time">
                  最佳: {{ formatTime(level.bestTime) }}
                </div>

                <!-- 通过标记 -->
                <div v-if="level.isPassed" class="passed-badge">
                  ✓ 已通过
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-if="!loading && levels.length === 0" class="empty-state">
        <p>暂无闯关关卡</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useChallengeStore, useAuthStore } from '@/stores'
import type { ChallengeLevel } from '@/types/challenge'

const router = useRouter()
const challengeStore = useChallengeStore()
const authStore = useAuthStore()

const loading = ref(true)

const levels = computed(() => challengeStore.levels)

const difficultyLabels: Record<string, string> = {
  easy: '简单',
  medium: '中等',
  hard: '困难',
  expert: '专家',
  legendary: '传说'
}

const difficultyOrder = ['easy', 'medium', 'hard', 'expert', 'legendary']

// 按难度分组关卡
const levelGroups = computed(() => {
  const groups: Record<string, ChallengeLevel[]> = {}

  for (const level of levels.value) {
    const diff = level.difficulty || 'easy'
    if (!groups[diff]) {
      groups[diff] = []
    }
    groups[diff].push(level)
  }

  return difficultyOrder
    .filter(diff => groups[diff]?.length > 0)
    .map(difficulty => ({
      difficulty,
      levels: groups[difficulty] || []
    }))
})

// 统计数据
const completedLevels = computed(() =>
  levels.value.filter(l => l.isPassed).length
)

const totalStars = computed(() =>
  levels.value.reduce((sum, l) => sum + (l.starRating || 0), 0)
)

const totalXpEarned = computed(() =>
  levels.value
    .filter(l => l.isPassed)
    .reduce((sum, l) => sum + (l.xpReward || 0), 0)
)

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  await challengeStore.fetchLevels()
  loading.value = false
})

const startLevel = (level: ChallengeLevel) => {
  if (!level.isUnlocked) return
  router.push(`/challenge/${level.id}`)
}

const formatTime = (seconds: number): string => {
  const mins = Math.floor(seconds / 60)
  const secs = seconds % 60
  return `${mins}:${secs.toString().padStart(2, '0')}`
}
</script>

<style scoped>
.challenge-page {
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

.progress-overview {
  display: flex;
  justify-content: space-around;
  text-align: center;
  margin-bottom: 32px;
}

.progress-stat {
  padding: 12px;
}

.progress-value {
  display: block;
  font-size: 32px;
  font-weight: bold;
  color: var(--primary-color);
}

.progress-label {
  color: var(--text-secondary);
  font-size: 14px;
}

.difficulty-section {
  margin-bottom: 32px;
}

.difficulty-title {
  font-size: 20px;
  margin-bottom: 16px;
  padding-bottom: 8px;
  border-bottom: 2px solid;
}

.difficulty-title.easy { border-color: #4caf50; color: #4caf50; }
.difficulty-title.medium { border-color: #ff9800; color: #ff9800; }
.difficulty-title.hard { border-color: #f44336; color: #f44336; }
.difficulty-title.expert { border-color: #9c27b0; color: #9c27b0; }
.difficulty-title.legendary { border-color: #ffd700; color: #ffd700; }

.levels-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

.level-card {
  position: relative;
  background: var(--bg-primary);
  border-radius: 16px;
  padding: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
}

.level-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
}

.level-card.easy::before { background: #4caf50; }
.level-card.medium::before { background: #ff9800; }
.level-card.hard::before { background: #f44336; }
.level-card.expert::before { background: #9c27b0; }
.level-card.legendary::before { background: linear-gradient(90deg, #ffd700, #ff9800); }

.level-card:hover:not(.locked) {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
}

.level-card.locked {
  opacity: 0.7;
  cursor: not-allowed;
}

.lock-overlay {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  min-height: 150px;
}

.lock-icon {
  font-size: 40px;
  margin-bottom: 8px;
}

.lock-text {
  font-size: 12px;
  color: var(--text-secondary);
}

.level-content {
  position: relative;
}

.stars {
  margin-bottom: 12px;
}

.star {
  font-size: 20px;
  opacity: 0.3;
  margin-right: 2px;
}

.star.filled {
  opacity: 1;
  filter: drop-shadow(0 0 4px gold);
}

.level-name {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 12px;
}

.level-details {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.detail {
  font-size: 13px;
  color: var(--text-secondary);
  background: var(--bg-secondary);
  padding: 4px 8px;
  border-radius: 12px;
}

.detail .icon {
  margin-right: 4px;
}

.xp-reward {
  display: inline-flex;
  align-items: center;
  background: linear-gradient(135deg, #ffd700 0%, #ff9800 100%);
  padding: 6px 12px;
  border-radius: 20px;
  margin-bottom: 12px;
}

.xp-icon {
  margin-right: 4px;
}

.xp-value {
  font-weight: bold;
  color: #fff;
}

.best-time {
  font-size: 12px;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.passed-badge {
  position: absolute;
  top: 0;
  right: 0;
  background: #4caf50;
  color: #fff;
  font-size: 12px;
  padding: 4px 8px;
  border-radius: 0 0 0 8px;
}

.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: var(--text-secondary);
}
</style>