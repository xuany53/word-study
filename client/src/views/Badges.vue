<template>
  <div class="badges-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="nav-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <div class="page-title">
          <h1>徽章画廊</h1>
          <p class="subtitle">收集徽章，记录你的学习成就</p>
        </div>
      </div>

      <!-- 统计概览 -->
      <div class="stats-overview card">
        <div class="stat">
          <span class="stat-value">{{ unlockedCount }}</span>
          <span class="stat-label">已解锁</span>
        </div>
        <div class="stat">
          <span class="stat-value">{{ totalCount }}</span>
          <span class="stat-label">总徽章</span>
        </div>
        <div class="stat">
          <span class="stat-value">{{ Math.round(progress * 100) }}%</span>
          <span class="stat-label">完成度</span>
        </div>
      </div>

      <!-- 进度条 -->
      <div class="progress-section">
        <div class="progress-bar">
          <div class="progress" :style="{ width: (progress * 100) + '%' }"></div>
        </div>
      </div>

      <!-- 筛选标签 -->
      <div class="filter-tabs">
        <button
          v-for="rarity in rarities"
          :key="rarity.value"
          class="filter-btn"
          :class="{ active: selectedRarity === rarity.value }"
          @click="selectedRarity = rarity.value"
        >
          {{ rarity.label }}
        </button>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading">
        <div class="spinner"></div>
      </div>

      <!-- 徽章网格 -->
      <div v-else class="badges-grid">
        <div
          v-for="badge in filteredBadges"
          :key="badge.id"
          class="badge-card"
          :class="[badge.rarity, { locked: !badge.isUnlocked }]"
          @click="showBadgeDetail(badge)"
        >
          <div class="badge-icon">{{ badge.icon }}</div>
          <div class="badge-name">{{ badge.name }}</div>
          <div class="badge-rarity" :class="badge.rarity">
            {{ rarityLabels[badge.rarity] }}
          </div>
          <div v-if="!badge.isUnlocked" class="lock-overlay">
            <span class="lock-icon">🔒</span>
          </div>
          <div v-else class="unlock-badge">✓</div>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-if="!loading && filteredBadges.length === 0" class="empty-state">
        <p>暂无徽章</p>
      </div>
    </div>

    <!-- 徽章详情弹窗 -->
    <Teleport to="body">
      <Transition name="fade">
        <div v-if="selectedBadge" class="modal-overlay" @click="selectedBadge = null">
          <div class="modal-content badge-detail" @click.stop>
            <button class="close-btn" @click="selectedBadge = null">×</button>

            <div class="detail-icon" :class="selectedBadge.rarity">
              {{ selectedBadge.icon }}
            </div>

            <h2>{{ selectedBadge.name }}</h2>
            <p class="detail-rarity" :class="selectedBadge.rarity">
              {{ rarityLabels[selectedBadge.rarity] }}
            </p>
            <p class="detail-description">{{ selectedBadge.description }}</p>

            <div v-if="selectedBadge.isUnlocked" class="unlock-info">
              <p>✓ 已解锁</p>
              <p class="unlock-date">解锁时间: {{ formatDate(selectedBadge.unlockedAt) }}</p>
            </div>
            <div v-else class="lock-info">
              <p class="lock-text">🔒 尚未解锁</p>
              <p class="unlock-hint">
                {{ getUnlockHint(selectedBadge) }}
              </p>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useGamificationStore, useAuthStore } from '@/stores'
import type { Badge } from '@/types/gamification'

const router = useRouter()
const gamificationStore = useGamificationStore()
const authStore = useAuthStore()

const loading = ref(true)
const selectedBadge = ref<Badge | null>(null)
const selectedRarity = ref<string>('all')

const rarities = [
  { value: 'all', label: '全部' },
  { value: 'common', label: '普通' },
  { value: 'rare', label: '稀有' },
  { value: 'epic', label: '史诗' },
  { value: 'legendary', label: '传说' }
]

const rarityLabels: Record<string, string> = {
  common: '普通',
  rare: '稀有',
  epic: '史诗',
  legendary: '传说'
}

const badges = computed(() => gamificationStore.badges)
const unlockedCount = computed(() => badges.value.filter(b => b.isUnlocked).length)
const totalCount = computed(() => badges.value.length)
const progress = computed(() => totalCount.value > 0 ? unlockedCount.value / totalCount.value : 0)

const filteredBadges = computed(() => {
  if (selectedRarity.value === 'all') {
    return badges.value
  }
  return badges.value.filter(b => b.rarity === selectedRarity.value)
})

onMounted(async () => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  await gamificationStore.fetchAllBadges()
  loading.value = false
})

const showBadgeDetail = (badge: Badge) => {
  selectedBadge.value = badge
}

const formatDate = (date: Date | string) => {
  if (!date) return ''
  const d = new Date(date)
  return d.toLocaleDateString('zh-CN')
}

const getUnlockHint = (badge: Badge) => {
  const condition = badge.unlockCondition as any
  if (!condition) return ''

  const hints: Record<string, (v: number) => string> = {
    streak: (v) => `连续打卡 ${v} 天`,
    words_learned: (v) => `学习 ${v} 个单词`,
    words_mastered: (v) => `掌握 ${v} 个单词`,
    accuracy: (v) => `正确率达到 ${v}%`,
    level: (v) => `达到等级 ${v}`,
    challenge_complete: (v) => `完成 ${v} 个关卡`,
    perfect_score: (v) => `获得 ${v} 个三星评价`
  }

  return hints[condition.type]?.(condition.value) || ''
}
</script>

<style scoped>
.badges-page {
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

.stats-overview {
  display: flex;
  justify-content: space-around;
  text-align: center;
  margin-bottom: 16px;
}

.stats-overview .stat-value {
  display: block;
  font-size: 32px;
  font-weight: bold;
  color: var(--primary-color);
}

.stats-overview .stat-label {
  color: var(--text-secondary);
  font-size: 14px;
}

.progress-section {
  margin-bottom: 24px;
}

.progress-bar {
  height: 8px;
  background: var(--bg-dark);
  border-radius: 4px;
  overflow: hidden;
}

.progress {
  height: 100%;
  background: linear-gradient(90deg, var(--primary-color), #FFD700);
  transition: width 0.5s ease;
}

.filter-tabs {
  display: flex;
  gap: 8px;
  margin-bottom: 24px;
  overflow-x: auto;
  padding-bottom: 8px;
}

.filter-btn {
  padding: 8px 16px;
  border: 1px solid var(--bg-dark);
  background: var(--bg-primary);
  border-radius: 20px;
  cursor: pointer;
  white-space: nowrap;
  transition: all var(--transition-fast);
}

.filter-btn.active {
  background: var(--primary-color);
  border-color: var(--primary-color);
  color: white;
}

.badges-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
  gap: 16px;
}

.badge-card {
  position: relative;
  padding: 20px 16px;
  text-align: center;
  background: var(--bg-primary);
  border-radius: 12px;
  box-shadow: var(--shadow-sm);
  cursor: pointer;
  transition: all var(--transition-fast);
  overflow: hidden;
}

.badge-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
}

.badge-card.locked {
  opacity: 0.7;
}

.badge-card.locked:hover {
  opacity: 0.9;
}

/* Rarity colors */
.badge-card.common { border-top: 3px solid #9e9e9e; }
.badge-card.rare { border-top: 3px solid #2196F3; }
.badge-card.epic { border-top: 3px solid #9C27B0; }
.badge-card.legendary { border-top: 3px solid #FFD700; }

.badge-icon {
  font-size: 48px;
  margin-bottom: 12px;
}

.badge-name {
  font-weight: 600;
  margin-bottom: 4px;
  font-size: 14px;
}

.badge-rarity {
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 10px;
  display: inline-block;
}

.badge-rarity.common { background: #f5f5f5; color: #666; }
.badge-rarity.rare { background: #E3F2FD; color: #1976D2; }
.badge-rarity.epic { background: #F3E5F5; color: #7B1FA2; }
.badge-rarity.legendary { background: #FFF8E1; color: #F57F17; }

.lock-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
}

.lock-icon {
  font-size: 32px;
}

.unlock-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  background: var(--success-color);
  color: white;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
}

/* Modal */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}

.modal-content {
  background: var(--bg-primary);
  border-radius: 16px;
  padding: 32px;
  max-width: 400px;
  width: 100%;
  position: relative;
  text-align: center;
}

.close-btn {
  position: absolute;
  top: 16px;
  right: 16px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: var(--text-secondary);
}

.detail-icon {
  font-size: 80px;
  margin-bottom: 16px;
}

.detail-icon.common { color: #9e9e9e; }
.detail-icon.rare { color: #2196F3; }
.detail-icon.epic { color: #9C27B0; }
.detail-icon.legendary { color: #FFD700; }

.detail-description {
  color: var(--text-secondary);
  margin: 16px 0;
}

.unlock-info {
  background: var(--bg-secondary);
  padding: 12px;
  border-radius: 8px;
  font-size: 14px;
}

.unlock-date {
  color: var(--text-secondary);
  font-size: 12px;
  margin-top: 8px;
}

.lock-info {
  background: var(--bg-secondary);
  padding: 16px;
  border-radius: 8px;
}

.lock-text {
  font-size: 18px;
  margin-bottom: 8px;
}

.unlock-hint {
  color: var(--primary-color);
  font-size: 14px;
}

.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: var(--text-secondary);
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