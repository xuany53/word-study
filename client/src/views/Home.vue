<template>
  <div class="home-page">
    <div class="container">
      <!-- 头部欢迎 -->
      <header class="header">
        <h1>单词学习</h1>
        <p class="subtitle">让背单词不再枯燥！</p>
      </header>

      <!-- 用户信息 -->
      <div v-if="authStore.user" class="user-info card">
        <div class="user-level">
          <span class="level-badge">Lv.{{ authStore.user.level }}</span>
          <span class="username">{{ authStore.user.username }}</span>
        </div>
        <div class="streak-info" v-if="authStore.user.streak > 0">
          <span class="fire">🔥</span>
          <span>连续 {{ authStore.user.streak }} 天</span>
        </div>
      </div>

      <!-- 今日进度 -->
      <div class="today-progress card">
        <h2>今日学习</h2>
        <div class="progress-stats">
          <div class="stat-item">
            <span class="stat-value">{{ todayReview }}</span>
            <span class="stat-label">待复习</span>
          </div>
          <div class="stat-item">
            <span class="stat-value">{{ todayNew }}</span>
            <span class="stat-label">新词</span>
          </div>
        </div>
      </div>

      <!-- 快捷操作 -->
      <div class="quick-actions">
        <button class="action-btn primary" @click="startLearning">
          <span class="icon">📚</span>
          <span>开始学习</span>
        </button>
        <button class="action-btn" @click="goToChallenge">
          <span class="icon">🎮</span>
          <span>闯关模式</span>
        </button>
      </div>

      <!-- 导航卡片 -->
      <div class="nav-cards">
        <div class="nav-card card" @click="$router.push('/stats')">
          <span class="icon">📊</span>
          <span>学习统计</span>
        </div>
        <div class="nav-card card" @click="$router.push('/badges')">
          <span class="icon">🏆</span>
          <span>徽章画廊</span>
        </div>
        <div class="nav-card card highlight" @click="$router.push('/games')">
          <span class="icon">🎮</span>
          <span>小游戏</span>
        </div>
        <div class="nav-card card" @click="$router.push('/settings')">
          <span class="icon">⚙️</span>
          <span>设置</span>
        </div>
      </div>

      <!-- 未登录提示 -->
      <div v-if="!authStore.isAuthenticated" class="login-prompt card">
        <p>登录后可以保存学习进度</p>
        <div class="auth-buttons">
          <button class="btn btn-primary" @click="$router.push('/login')">登录</button>
          <button class="btn btn-secondary" @click="$router.push('/register')">注册</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore, useLearningStore, useStatsStore } from '@/stores'

const router = useRouter()
const authStore = useAuthStore()
const learningStore = useLearningStore()
const statsStore = useStatsStore()

const todayReview = ref(0)
const todayNew = ref(0)

onMounted(async () => {
  if (authStore.isAuthenticated) {
    await authStore.fetchProfile()
    await learningStore.fetchTodayWords()
    await statsStore.fetchStats()

    todayReview.value = learningStore.todayWords.reviewWords
    todayNew.value = learningStore.todayWords.newWords
  }
})

const startLearning = () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }
  router.push('/learning')
}

const goToChallenge = () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }
  router.push('/challenge')
}
</script>

<style scoped>
.home-page {
  min-height: 100vh;
  padding: 20px 0;
}

.header {
  text-align: center;
  margin-bottom: 24px;
}

.header h1 {
  font-size: 32px;
  color: var(--primary-color);
  margin-bottom: 8px;
}

.subtitle {
  color: var(--text-secondary);
}

.user-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.level-badge {
  background: var(--primary-color);
  color: white;
  padding: 4px 12px;
  border-radius: 16px;
  font-size: 14px;
  margin-right: 8px;
}

.streak-info {
  display: flex;
  align-items: center;
  gap: 4px;
  color: var(--warning-color);
  font-weight: 500;
}

.today-progress {
  margin-bottom: 24px;
}

.today-progress h2 {
  font-size: 18px;
  margin-bottom: 16px;
}

.progress-stats {
  display: flex;
  justify-content: space-around;
}

.stat-item {
  text-align: center;
}

.stat-value {
  display: block;
  font-size: 36px;
  font-weight: bold;
  color: var(--primary-color);
}

.stat-label {
  color: var(--text-secondary);
  font-size: 14px;
}

.quick-actions {
  display: flex;
  gap: 12px;
  margin-bottom: 24px;
}

.action-btn {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 24px 16px;
  border: none;
  border-radius: var(--border-radius);
  background: var(--bg-primary);
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.action-btn:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.action-btn.primary {
  background: var(--primary-color);
  color: white;
}

.action-btn .icon {
  font-size: 32px;
}

.nav-cards {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.nav-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 16px;
  cursor: pointer;
  transition: all var(--transition-fast);
}

.nav-card:hover {
  background: var(--bg-secondary);
}

.nav-card.highlight {
  background: linear-gradient(135deg, var(--primary-light), var(--primary-color));
  color: white;
}

.nav-card.highlight:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.nav-card .icon {
  font-size: 24px;
}

.login-prompt {
  text-align: center;
  padding: 24px;
}

.auth-buttons {
  display: flex;
  gap: 12px;
  justify-content: center;
  margin-top: 16px;
}
</style>