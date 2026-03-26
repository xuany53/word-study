<template>
  <div class="level-progress">
    <!-- 当前等级显示 -->
    <div class="level-badge" :class="levelClass">
      <span class="level-number">{{ level }}</span>
      <span class="level-label">LV</span>
    </div>

    <!-- 进度条 -->
    <div class="progress-container">
      <div class="progress-info">
        <span class="current-xp">{{ xp }} XP</span>
        <span class="next-level">→ {{ nextLevelXp }} XP</span>
      </div>
      <div class="progress-bar">
        <div
          class="progress-fill"
          :style="{ width: progressPercent + '%' }"
        >
          <span v-if="progressPercent > 20" class="progress-text">
            {{ Math.round(progressPercent) }}%
          </span>
        </div>
      </div>
      <p class="xp-to-next">
        距离下一级还需 <strong>{{ xpToNextLevel }}</strong> XP
      </p>
    </div>

    <!-- 等级奖励预览 -->
    <div v-if="showRewards" class="level-rewards">
      <h4>下一级奖励</h4>
      <div class="reward-items">
        <div class="reward-item">
          <span class="reward-icon">🏆</span>
          <span class="reward-text">称号升级</span>
        </div>
        <div class="reward-item">
          <span class="reward-icon">⭐</span>
          <span class="reward-text">新徽章机会</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  level: number
  xp: number
  showRewards?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  showRewards: false
})

// Calculate XP needed for each level
const getXpForLevel = (level: number): number => {
  return level * 100
}

const nextLevelXp = computed(() => getXpForLevel(props.level + 1))
const currentLevelXp = computed(() => getXpForLevel(props.level))
const xpInCurrentLevel = computed(() => props.xp - currentLevelXp.value)
const xpNeededForNext = computed(() => nextLevelXp.value - currentLevelXp.value)

const progressPercent = computed(() => {
  if (props.level >= 50) return 100 // Max level
  return Math.min(100, (xpInCurrentLevel.value / xpNeededForNext.value) * 100)
})

const xpToNextLevel = computed(() => {
  if (props.level >= 50) return 0 // Max level
  return nextLevelXp.value - props.xp
})

const levelClass = computed(() => {
  if (props.level >= 50) return 'legendary'
  if (props.level >= 25) return 'expert'
  if (props.level >= 10) return 'advanced'
  if (props.level >= 5) return 'intermediate'
  return 'beginner'
})
</script>

<style scoped>
.level-progress {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background: var(--bg-primary);
  border-radius: 16px;
  box-shadow: var(--shadow-sm);
}

.level-badge {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 64px;
  height: 64px;
  border-radius: 16px;
  flex-shrink: 0;
}

.level-badge.beginner {
  background: linear-gradient(135deg, #90a4ae 0%, #607d8b 100%);
}

.level-badge.intermediate {
  background: linear-gradient(135deg, #4caf50 0%, #2e7d32 100%);
}

.level-badge.advanced {
  background: linear-gradient(135deg, #2196f3 0%, #1565c0 100%);
}

.level-badge.expert {
  background: linear-gradient(135deg, #9c27b0 0%, #6a1b9a 100%);
}

.level-badge.legendary {
  background: linear-gradient(135deg, #ffd700 0%, #ff9800 100%);
}

.level-number {
  font-size: 24px;
  font-weight: bold;
  color: #fff;
  line-height: 1;
}

.level-label {
  font-size: 10px;
  color: rgba(255, 255, 255, 0.8);
  text-transform: uppercase;
}

.progress-container {
  flex: 1;
}

.progress-info {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 14px;
}

.current-xp {
  font-weight: bold;
  color: var(--primary-color);
}

.next-level {
  color: var(--text-secondary);
}

.progress-bar {
  height: 12px;
  background: var(--bg-dark);
  border-radius: 6px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--primary-color), #ffd700);
  border-radius: 6px;
  transition: width 0.5s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.progress-text {
  font-size: 10px;
  color: #fff;
  font-weight: bold;
}

.xp-to-next {
  font-size: 12px;
  color: var(--text-secondary);
  margin-top: 4px;
}

.xp-to-next strong {
  color: var(--primary-color);
}

.level-rewards {
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--border-color);
}

.level-rewards h4 {
  font-size: 14px;
  margin-bottom: 8px;
  color: var(--text-secondary);
}

.reward-items {
  display: flex;
  gap: 16px;
}

.reward-item {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
}

.reward-icon {
  font-size: 16px;
}

.reward-text {
  color: var(--text-secondary);
}

/* Responsive */
@media (max-width: 480px) {
  .level-progress {
    flex-direction: column;
    text-align: center;
  }

  .progress-info {
    justify-content: center;
    gap: 16px;
  }

  .reward-items {
    justify-content: center;
  }
}
</style>