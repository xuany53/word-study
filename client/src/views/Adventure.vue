<template>
  <div class="adventure-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="nav-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <div class="page-title">
          <h1>🗺️ 单词大冒险</h1>
          <p class="subtitle">每天打卡，探索单词世界！</p>
        </div>
      </div>

      <!-- 进度概览 -->
      <div class="progress-overview card">
        <div class="progress-info">
          <div class="current-location" v-if="currentLocation">
            <span class="location-icon">{{ currentLocation.icon }}</span>
            <div class="location-details">
              <span class="location-name">{{ currentLocation.name }}</span>
              <span class="location-type">{{ getTypeLabel(currentLocation.type) }}</span>
            </div>
          </div>
          <div class="total-steps">
            <span class="steps-value">{{ totalSteps }}</span>
            <span class="steps-label">总步数</span>
          </div>
        </div>
        <div class="progress-bar-container">
          <div class="progress-bar">
            <div class="progress" :style="{ width: totalProgress + '%' }"></div>
          </div>
          <span class="progress-text">探险进度 {{ totalProgress }}%</span>
        </div>
      </div>

      <!-- 今日打卡 -->
      <div class="checkin-section card" v-if="!hasCheckedInToday">
        <div class="checkin-info">
          <span class="checkin-icon">🚶</span>
          <div class="checkin-text">
            <h3>今日打卡</h3>
            <p>完成学习任务，前进一步！</p>
          </div>
        </div>
        <button class="checkin-btn" @click="doCheckIn" :disabled="checkingIn">
          {{ checkingIn ? '打卡中...' : '立即打卡' }}
        </button>
      </div>
      <div class="checkin-section card checked-in" v-else>
        <span class="checkin-icon">✅</span>
        <span class="checkin-text">今日已打卡，明天继续探险！</span>
      </div>

      <!-- 地图 -->
      <div class="map-section">
        <h3>探险地图</h3>
        <AdventureMap :locations-with-status="locationsWithStatus" />
      </div>

      <!-- 下一个目标 -->
      <div class="next-target card" v-if="nextTarget">
        <h3>下一个目标</h3>
        <div class="target-info">
          <span class="target-icon">{{ nextTarget.icon }}</span>
          <div class="target-details">
            <span class="target-name">{{ nextTarget.name }}</span>
            <span class="target-requirement">还需 {{ nextTarget.daysRequired - totalSteps }} 步</span>
          </div>
        </div>
        <p class="target-desc">{{ nextTarget.description }}</p>
      </div>

      <!-- 已获得奖励 -->
      <div class="rewards-section card">
        <h3>探险奖励</h3>
        <div class="rewards-list" v-if="completedLocations.length > 0">
          <div
            v-for="location in completedLocations"
            :key="location.id"
            class="reward-item"
            :class="location.type"
          >
            <span class="reward-icon">{{ location.icon }}</span>
            <span class="reward-name">{{ location.name }}</span>
            <span class="reward-xp">+{{ location.rewards.xp }} XP</span>
          </div>
        </div>
        <div class="no-rewards" v-else>
          <p>还没有获得奖励，继续探险吧！</p>
        </div>
      </div>

      <!-- 已解锁主题单词 -->
      <div class="themes-section card">
        <h3>📚 已解锁主题单词</h3>
        <p class="themes-hint">学习页面可筛选主题单词</p>
        <div class="themes-grid" v-if="unlockedThemes.length > 0">
          <div
            v-for="theme in unlockedThemes"
            :key="theme.id"
            class="theme-card"
            :style="{ borderColor: theme.color }"
            @click="goToLearningWithTheme(theme.id)"
          >
            <span class="theme-icon">{{ theme.icon }}</span>
            <span class="theme-name">{{ theme.name }}</span>
            <span class="theme-count">{{ theme.words.length }} 词</span>
          </div>
        </div>
        <div class="no-themes" v-else>
          <p>打卡解锁主题单词包！</p>
        </div>
      </div>
    </div>

    <!-- 到达新地点弹窗 -->
    <Teleport to="body">
      <Transition name="pop">
        <div v-if="showNewLocationModal" class="modal-overlay" @click="closeNewLocationModal">
          <div class="modal-content celebration" @click.stop>
            <div class="celebration-icon">🎉</div>
            <h2>到达新地点！</h2>
            <div class="new-location" v-if="newLocationReached">
              <span class="location-icon">{{ newLocationReached.icon }}</span>
              <span class="location-name">{{ newLocationReached.name }}</span>
            </div>
            <p class="location-story" v-if="newLocationReached?.story">
              {{ newLocationReached.story }}
            </p>
            <div class="rewards-earned">
              <span class="xp">+{{ newLocationReached?.rewards.xp || 0 }} XP</span>
              <span v-if="unlockedThemeName" class="theme-badge">
                📚 解锁「{{ unlockedThemeName }}」主题单词！
              </span>
            </div>
            <button class="close-modal-btn" @click="closeNewLocationModal">继续探险</button>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores'
import { useAdventureStore } from '@/stores/adventure'
import AdventureMap from '@/components/adventure/AdventureMap.vue'
import type { AdventureLocation, LocationType } from '@/types/adventure'
import { wordThemes, getThemeById } from '@/data/wordThemes'

const router = useRouter()
const authStore = useAuthStore()
const adventureStore = useAdventureStore()

const checkingIn = ref(false)
const hasCheckedInToday = ref(false)
const showNewLocationModal = ref(false)
const newLocationReached = ref<AdventureLocation | null>(null)
const unlockedThemeName = ref('')

// 计算属性
const currentLocation = computed(() => adventureStore.currentLocation)
const locationsWithStatus = computed(() => adventureStore.locationsWithStatus)
const totalProgress = computed(() => adventureStore.totalProgress)
const totalSteps = computed(() => adventureStore.progress?.totalSteps || 0)
const nextTarget = computed(() => adventureStore.nextTargetLocation)
const completedLocations = computed(() =>
  adventureStore.locations.filter(l =>
    adventureStore.progress?.completedLocations.includes(l.id)
  )
)

// 已解锁的主题
const unlockedThemes = computed(() => {
  return adventureStore.unlockedThemes
    .map(themeId => getThemeById(themeId))
    .filter(Boolean)
})

// 地点类型标签
const getTypeLabel = (type: LocationType): string => {
  const labels: Record<LocationType, string> = {
    forest: '森林',
    desert: '沙漠',
    snow: '雪山',
    castle: '城堡',
    sky: '天空'
  }
  return labels[type] || type
}

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  // 初始化冒险进度
  adventureStore.loadProgress()

  if (!adventureStore.progress) {
    const streak = authStore.user?.streak || 0
    adventureStore.initProgress(streak)
  }

  // 检查今日是否已打卡
  checkTodayCheckIn()
})

// 检查今日打卡
const checkTodayCheckIn = () => {
  const today = new Date().toDateString()
  const lastCheckIn = adventureStore.progress?.lastCheckInAt
  if (lastCheckIn) {
    hasCheckedInToday.value = new Date(lastCheckIn).toDateString() === today
  }
}

// 打卡
const doCheckIn = async () => {
  if (checkingIn.value || hasCheckedInToday.value) return

  checkingIn.value = true

  try {
    const result = adventureStore.checkIn()

    if (result?.isNewLocation && result.location) {
      newLocationReached.value = result.location
      unlockedThemeName.value = result.unlockedTheme || ''
      showNewLocationModal.value = true
    }

    hasCheckedInToday.value = true
  } catch (error) {
    console.error('Check-in failed:', error)
  } finally {
    checkingIn.value = false
  }
}

// 关闭新地点弹窗
const closeNewLocationModal = () => {
  showNewLocationModal.value = false
  newLocationReached.value = null
  unlockedThemeName.value = ''
}

// 跳转到学习页面（带主题筛选）
const goToLearningWithTheme = (themeId: string) => {
  router.push(`/learning?theme=${themeId}`)
}
}
</script>

<style scoped>
.adventure-page {
  min-height: 100vh;
  padding: 20px 0;
  background: linear-gradient(180deg, #e8f5e9 0%, #fff8e1 100%);
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
  background: white;
  border: none;
  padding: 8px 16px;
  border-radius: var(--border-radius);
  cursor: pointer;
  font-size: 16px;
  color: var(--text-primary);
  transition: all var(--transition-fast);
  box-shadow: var(--shadow-sm);
}

.back-btn:hover {
  background: var(--primary-light);
  color: var(--primary-color);
}

.page-title h1 {
  font-size: 28px;
  margin-bottom: 8px;
  color: #2e7d32;
}

.subtitle {
  color: var(--text-secondary);
}

.progress-overview {
  margin-bottom: 16px;
}

.progress-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.current-location {
  display: flex;
  align-items: center;
  gap: 12px;
}

.current-location .location-icon {
  font-size: 32px;
}

.location-details {
  display: flex;
  flex-direction: column;
}

.location-name {
  font-weight: 600;
  font-size: 16px;
}

.location-type {
  font-size: 12px;
  color: var(--text-secondary);
}

.total-steps {
  text-align: right;
}

.steps-value {
  display: block;
  font-size: 28px;
  font-weight: bold;
  color: #4caf50;
}

.steps-label {
  font-size: 12px;
  color: var(--text-secondary);
}

.progress-bar-container {
  text-align: center;
}

.progress-bar {
  height: 8px;
  background: #e0e0e0;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 8px;
}

.progress-bar .progress {
  height: 100%;
  background: linear-gradient(90deg, #4caf50, #8bc34a);
  transition: width 0.5s ease;
}

.progress-text {
  font-size: 12px;
  color: var(--text-secondary);
}

.checkin-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  background: white;
}

.checkin-section.checked-in {
  background: #e8f5e9;
  text-align: center;
  justify-content: center;
  gap: 12px;
}

.checkin-info {
  display: flex;
  align-items: center;
  gap: 16px;
}

.checkin-icon {
  font-size: 40px;
}

.checkin-text h3 {
  margin: 0 0 4px 0;
  font-size: 18px;
}

.checkin-text p {
  margin: 0;
  font-size: 14px;
  color: var(--text-secondary);
}

.checkin-btn {
  background: linear-gradient(135deg, #4caf50, #2e7d32);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 24px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.checkin-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
}

.checkin-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.map-section {
  margin-bottom: 24px;
}

.map-section h3 {
  font-size: 18px;
  margin-bottom: 12px;
  color: #333;
}

.next-target {
  margin-bottom: 24px;
}

.next-target h3 {
  font-size: 16px;
  margin-bottom: 12px;
  color: var(--text-secondary);
}

.target-info {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
}

.target-icon {
  font-size: 32px;
}

.target-details {
  display: flex;
  flex-direction: column;
}

.target-name {
  font-weight: 600;
  font-size: 18px;
}

.target-requirement {
  font-size: 14px;
  color: #ff9800;
}

.target-desc {
  color: var(--text-secondary);
  font-size: 14px;
}

.rewards-section h3 {
  font-size: 16px;
  margin-bottom: 16px;
  color: var(--text-secondary);
}

.rewards-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.reward-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: #f5f5f5;
  border-radius: 8px;
}

.reward-item.forest { border-left: 4px solid #4caf50; }
.reward-item.desert { border-left: 4px solid #ff9800; }
.reward-item.snow { border-left: 4px solid #03a9f4; }
.reward-item.castle { border-left: 4px solid #9c27b0; }
.reward-item.sky { border-left: 4px solid #ffd700; }

.reward-icon {
  font-size: 24px;
}

.reward-name {
  flex: 1;
  font-weight: 500;
}

.reward-xp {
  color: #ff9800;
  font-weight: 600;
}

.no-rewards {
  text-align: center;
  color: var(--text-secondary);
  padding: 20px;
}

/* 主题单词部分 */
.themes-section {
  background: white;
  margin-top: 16px;
}

.themes-section h3 {
  font-size: 16px;
  margin-bottom: 4px;
}

.themes-hint {
  font-size: 12px;
  color: var(--text-secondary);
  margin-bottom: 16px;
}

.themes-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
  gap: 12px;
}

.theme-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px;
  background: #f5f5f5;
  border-radius: 12px;
  border: 2px solid;
  cursor: pointer;
  transition: all 0.2s;
}

.theme-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.theme-icon {
  font-size: 28px;
  margin-bottom: 8px;
}

.theme-name {
  font-weight: 600;
  font-size: 14px;
  margin-bottom: 4px;
}

.theme-count {
  font-size: 12px;
  color: var(--text-secondary);
}

.no-themes {
  text-align: center;
  color: var(--text-secondary);
  padding: 20px;
}

/* Modal */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}

.modal-content.celebration {
  background: white;
  border-radius: 24px;
  padding: 32px;
  text-align: center;
  max-width: 360px;
  width: 100%;
}

.celebration-icon {
  font-size: 64px;
  margin-bottom: 16px;
  animation: bounce 0.5s ease infinite alternate;
}

@keyframes bounce {
  from { transform: translateY(0); }
  to { transform: translateY(-10px); }
}

.modal-content.celebration h2 {
  font-size: 24px;
  color: #4caf50;
  margin-bottom: 24px;
}

.new-location {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
}

.new-location .location-icon {
  font-size: 48px;
}

.new-location .location-name {
  font-size: 20px;
  font-weight: 600;
}

.location-story {
  background: #f5f5f5;
  padding: 16px;
  border-radius: 12px;
  font-size: 14px;
  color: #555;
  line-height: 1.6;
  margin-bottom: 16px;
}

.rewards-earned {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
}

.rewards-earned .xp {
  font-size: 24px;
  font-weight: bold;
  color: #ff9800;
  background: #fff8e1;
  padding: 8px 24px;
  border-radius: 20px;
}

.rewards-earned .theme-badge {
  font-size: 16px;
  font-weight: 600;
  color: #4caf50;
  background: #e8f5e9;
  padding: 8px 16px;
  border-radius: 12px;
}

.close-modal-btn {
  background: #4caf50;
  color: white;
  border: none;
  padding: 12px 32px;
  border-radius: 24px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
}

.pop-enter-active {
  animation: popIn 0.3s ease;
}

.pop-leave-active {
  animation: popOut 0.3s ease;
}

@keyframes popIn {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

@keyframes popOut {
  from {
    opacity: 1;
    transform: scale(1);
  }
  to {
    opacity: 0;
    transform: scale(0.8);
  }
}
</style>