<template>
  <div class="stats-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="page-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <h1>学习统计</h1>
      </div>

      <div v-if="loading" class="loading">
        <div class="spinner"></div>
      </div>

      <template v-else>
        <!-- 今日统计 -->
        <div class="card today-stats">
          <h2>今日学习</h2>
          <div class="stats-grid">
            <div class="stat-item">
              <span class="stat-value">{{ todayStats.newWords }}</span>
              <span class="stat-label">新词</span>
            </div>
            <div class="stat-item">
              <span class="stat-value">{{ todayStats.review }}</span>
              <span class="stat-label">复习</span>
            </div>
            <div class="stat-item">
              <span class="stat-value">{{ todayStats.accuracy }}%</span>
              <span class="stat-label">正确率</span>
            </div>
          </div>
        </div>

        <!-- 总体统计 -->
        <div class="card total-stats">
          <h2>总体统计</h2>
          <div class="stats-grid">
            <div class="stat-item">
              <span class="stat-value">{{ userStats.totalWords }}</span>
              <span class="stat-label">总词汇</span>
            </div>
            <div class="stat-item">
              <span class="stat-value">{{ userStats.masteredWords }}</span>
              <span class="stat-label">已掌握</span>
            </div>
            <div class="stat-item">
              <span class="stat-value">{{ userStats.correctRate }}%</span>
              <span class="stat-label">正确率</span>
            </div>
            <div class="stat-item">
              <span class="stat-value">{{ userStats.totalDays }}</span>
              <span class="stat-label">学习天数</span>
            </div>
          </div>
        </div>

        <!-- 连续打卡 -->
        <div class="card streak-card">
          <div class="streak-header">
            <span class="fire">🔥</span>
            <span class="streak-value">{{ userStats.streak }}</span>
            <span>天连续打卡</span>
          </div>
          <p class="streak-tip">最长连续: {{ userStats.longestStreak }} 天</p>
          <button
            class="btn btn-primary"
            @click="handleCheckIn"
            :disabled="checkInLoading || hasCheckedIn || !canCheckIn"
            :title="checkInButtonTitle"
          >
            {{ checkInButtonText }}
          </button>
          <p v-if="checkInHint" class="checkin-hint">{{ checkInHint }}</p>
        </div>
      </template>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, reactive, computed } from 'vue'
import { useStatsStore, useAuthStore } from '@/stores'

const statsStore = useStatsStore()
const authStore = useAuthStore()

const loading = ref(true)
const checkInLoading = ref(false)
const hasCheckedIn = ref(false) // 今日是否已打卡

const todayStats = reactive({
  newWords: 0,
  review: 0,
  accuracy: 0
})

const userStats = reactive({
  totalWords: 0,
  masteredWords: 0,
  correctRate: 0,
  totalDays: 0,
  streak: 0,
  longestStreak: 0,
  lastCheckIn: null as Date | null
})

// 每日学习目标
const dailyGoal = computed(() => {
  const savedSettings = localStorage.getItem('wordStudySettings')
  if (savedSettings) {
    const settings = JSON.parse(savedSettings)
    return settings.dailyNewWords || 20
  }
  return 20 // 默认每天20个单词
})

// 今日已学单词数
const todayLearnedWords = computed(() => todayStats.newWords + todayStats.review)

// 是否达到打卡条件
const hasReachedGoal = computed(() => {
  return todayLearnedWords.value >= dailyGoal.value
})

// 是否可以手动打卡（未打卡且达到目标）
const canCheckIn = computed(() => {
  return !hasCheckedIn.value && hasReachedGoal.value
})

// 打卡按钮文字
const checkInButtonText = computed(() => {
  if (checkInLoading.value) return '打卡中...'
  if (hasCheckedIn.value) return '今日已打卡'
  return '今日打卡'
})

// 打卡按钮提示
const checkInButtonTitle = computed(() => {
  if (hasCheckedIn.value) return '今日已打卡'
  if (!hasReachedGoal.value) return '请完成今日学习任务'
  return ''
})

// 打卡提示信息
const checkInHint = computed(() => {
  if (hasCheckedIn.value) return ''
  if (!hasReachedGoal.value) return '请完成今日学习任务'
  return ''
})

// 检查是否今天已打卡
const checkIfCheckedInToday = (lastCheckIn: Date | null) => {
  if (!lastCheckIn) return false

  const today = new Date()
  today.setHours(0, 0, 0, 0)

  const checkInDate = new Date(lastCheckIn)
  checkInDate.setHours(0, 0, 0, 0)

  return checkInDate.getTime() === today.getTime()
}

onMounted(async () => {
  await statsStore.fetchStats()
  await statsStore.fetchDailyStats()

  if (statsStore.userStats) {
    Object.assign(userStats, statsStore.userStats)

    // 检查今天是否已打卡
    if (userStats.lastCheckIn) {
      hasCheckedIn.value = checkIfCheckedInToday(new Date(userStats.lastCheckIn))
    }
  }

  if (statsStore.dailyStats) {
    todayStats.newWords = statsStore.dailyStats.newWordsCount
    todayStats.review = statsStore.dailyStats.reviewWordsCount
    todayStats.accuracy = Math.round(statsStore.dailyStats.correctRate)
  }

  loading.value = false
})

const handleCheckIn = async () => {
  checkInLoading.value = true
  try {
    await statsStore.checkIn()
    userStats.streak = statsStore.streak
    hasCheckedIn.value = true // 打卡成功
  } catch (error: any) {
    // 如果返回 "Already checked in today"，说明已打卡
    if (error?.message?.includes('Already checked in')) {
      hasCheckedIn.value = true
    }
    console.error('Check in failed:', error)
  } finally {
    checkInLoading.value = false
  }
}
</script>

<style scoped>
.stats-page {
  min-height: 100vh;
  padding: 20px 0;
}

.page-header {
  display: flex;
  align-items: center;
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

.page-header h1 {
  flex: 1;
  text-align: center;
  margin: 0;
  padding-right: 80px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
  gap: 16px;
}

.stat-item {
  text-align: center;
  padding: 16px;
  background: var(--bg-secondary);
  border-radius: var(--border-radius);
}

.stat-value {
  display: block;
  font-size: 28px;
  font-weight: bold;
  color: var(--primary-color);
}

.stat-label {
  color: var(--text-secondary);
  font-size: 14px;
}

.today-stats, .total-stats {
  margin-bottom: 16px;
}

.streak-card {
  text-align: center;
  padding: 32px;
}

.streak-header {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-bottom: 8px;
}

.streak-value {
  font-size: 48px;
  font-weight: bold;
  color: var(--warning-color);
}

.streak-tip {
  color: var(--text-secondary);
  margin-bottom: 16px;
}

.checkin-hint {
  color: var(--text-secondary);
  font-size: 14px;
  margin-top: 12px;
  padding: 8px 12px;
  background: var(--bg-secondary);
  border-radius: var(--border-radius);
}
</style>