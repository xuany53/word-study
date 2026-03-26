<template>
  <div class="adventure-map">
    <!-- 地图背景 -->
    <div class="map-background" :style="{ background: currentBgGradient }">
      <!-- 路径线 -->
      <svg class="map-path" viewBox="0 0 300 600">
        <path
          :d="pathD"
          fill="none"
          stroke="rgba(255,255,255,0.3)"
          stroke-width="4"
          stroke-dasharray="8,4"
        />
        <!-- 已完成的路径 -->
        <path
          :d="completedPathD"
          fill="none"
          stroke="#ffd700"
          stroke-width="4"
          stroke-linecap="round"
        />
      </svg>

      <!-- 地点节点 -->
      <div
        v-for="(location, index) in locationsWithStatus"
        :key="location.id"
        class="location-node"
        :class="[location.status, location.type]"
        :style="getNodeStyle(index)"
        @click="selectLocation(location)"
      >
        <!-- 节点图标 -->
        <div class="node-icon">
          <span v-if="location.status === 'locked'">🔒</span>
          <span v-else-if="location.status === 'completed'">✓</span>
          <span v-else>{{ location.icon }}</span>
        </div>

        <!-- 节点光环 -->
        <div v-if="location.status === 'current'" class="node-glow"></div>

        <!-- 节点名称 -->
        <div class="node-name">{{ location.name }}</div>

        <!-- 进度条 -->
        <div v-if="location.status === 'current'" class="node-progress">
          <div class="progress-bar">
            <div class="progress" :style="{ width: location.progress + '%' }"></div>
          </div>
          <span class="progress-text">{{ location.progress }}%</span>
        </div>
      </div>
    </div>

    <!-- 地点详情弹窗 -->
    <Teleport to="body">
      <Transition name="fade">
        <div v-if="selectedLocation" class="location-modal" @click="selectedLocation = null">
          <div class="modal-content" @click.stop>
            <button class="close-btn" @click="selectedLocation = null">×</button>

            <div class="location-header" :class="selectedLocation.type">
              <span class="location-icon">{{ selectedLocation.icon }}</span>
              <h2>{{ selectedLocation.name }}</h2>
              <span class="status-badge" :class="selectedLocation.status">
                {{ statusLabels[selectedLocation.status] }}
              </span>
            </div>

            <p class="location-desc">{{ selectedLocation.description }}</p>

            <!-- 剧情展示 -->
            <div v-if="selectedLocation.story" class="location-story">
              <p>{{ selectedLocation.story }}</p>
            </div>

            <!-- 奖励展示 -->
            <div class="location-rewards">
              <h4>奖励</h4>
              <div class="rewards-list">
                <span class="reward-item">
                  <span class="icon">✨</span>
                  {{ selectedLocation.rewards.xp }} XP
                </span>
                <span v-if="selectedLocation.rewards.badge" class="reward-item">
                  <span class="icon">🏆</span>
                  特殊徽章
                </span>
                <span v-if="selectedLocation.rewards.theme" class="reward-item">
                  <span class="icon">📖</span>
                  主题单词包
                </span>
              </div>
            </div>

            <!-- 解锁条件 -->
            <div v-if="selectedLocation.status === 'locked'" class="unlock-hint">
              <p>🔒 需要 {{ selectedLocation.daysRequired }} 天打卡解锁</p>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { LocationWithStatus, LocationType } from '@/types/adventure'
import { locationColors } from '@/types/adventure'

interface Props {
  locationsWithStatus: LocationWithStatus[]
}

const props = defineProps<Props>()

const selectedLocation = ref<LocationWithStatus | null>(null)

const statusLabels: Record<string, string> = {
  locked: '🔒 未解锁',
  current: '📍 进行中',
  completed: '✅ 已完成'
}

// 当前地点类型
const currentLocationType = computed<LocationType>(() => {
  const current = props.locationsWithStatus.find(l => l.status === 'current')
  return current?.type || 'forest'
})

// 背景渐变
const currentBgGradient = computed(() => {
  const colors = locationColors[currentLocationType.value]
  return `linear-gradient(180deg, ${colors.bg} 0%, ${colors.primary}22 100%)`
})

// 节点位置样式
const getNodeStyle = (index: number) => {
  const positions = [
    { left: '50%', top: '5%' },   // 起点
    { left: '30%', top: '15%' },
    { left: '70%', top: '25%' },
    { left: '25%', top: '38%' },
    { left: '65%', top: '50%' },
    { left: '35%', top: '62%' },
    { left: '70%', top: '75%' },
    { left: '40%', top: '88%' },
    { left: '50%', top: '98%' }   // 终点
  ]

  const pos = positions[index] || { left: '50%', top: '50%' }

  return {
    left: pos.left,
    top: pos.top,
    transform: 'translate(-50%, -50%)'
  }
}

// SVG 路径
const pathD = computed(() => {
  const positions = [
    [150, 30],   // 5% of 600
    [90, 90],    // 15%
    [210, 150],  // 25%
    [75, 228],   // 38%
    [195, 300],  // 50%
    [105, 372],  // 62%
    [210, 450],  // 75%
    [120, 528],  // 88%
    [150, 588]   // 98%
  ]

  let d = `M ${positions[0][0]} ${positions[0][1]}`
  for (let i = 1; i < positions.length; i++) {
    const prev = positions[i - 1]
    const curr = positions[i]
    const cp1x = prev[0] + (curr[0] - prev[0]) * 0.5
    const cp1y = prev[1] + 20
    const cp2x = curr[0] - (curr[0] - prev[0]) * 0.5
    const cp2y = curr[1] - 20
    d += ` C ${cp1x} ${cp1y}, ${cp2x} ${cp2y}, ${curr[0]} ${curr[1]}`
  }

  return d
})

// 已完成路径
const completedPathD = computed(() => {
  const completedCount = props.locationsWithStatus.filter(l => l.status === 'completed').length
  if (completedCount === 0) return ''

  const positions = [
    [150, 30],
    [90, 90],
    [210, 150],
    [75, 228],
    [195, 300],
    [105, 372],
    [210, 450],
    [120, 528],
    [150, 588]
  ]

  let d = `M ${positions[0][0]} ${positions[0][1]}`
  for (let i = 1; i <= completedCount && i < positions.length; i++) {
    const prev = positions[i - 1]
    const curr = positions[i]
    const cp1x = prev[0] + (curr[0] - prev[0]) * 0.5
    const cp1y = prev[1] + 20
    const cp2x = curr[0] - (curr[0] - prev[0]) * 0.5
    const cp2y = curr[1] - 20
    d += ` C ${cp1x} ${cp1y}, ${cp2x} ${cp2y}, ${curr[0]} ${curr[1]}`
  }

  return d
})

// 选择地点
const selectLocation = (location: LocationWithStatus) => {
  selectedLocation.value = location
}
</script>

<style scoped>
.adventure-map {
  position: relative;
  border-radius: 16px;
  overflow: hidden;
}

.map-background {
  position: relative;
  width: 100%;
  height: 600px;
  padding: 20px;
}

.map-path {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.location-node {
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  transition: transform 0.3s ease;
  z-index: 1;
}

.location-node:hover {
  transform: translate(-50%, -50%) scale(1.1);
}

.node-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  position: relative;
}

.location-node.locked .node-icon {
  background: #e0e0e0;
  color: #9e9e9e;
}

.location-node.completed .node-icon {
  background: #4caf50;
  color: white;
}

.location-node.current .node-icon {
  background: linear-gradient(135deg, #ffd700, #ff9800);
  color: white;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { box-shadow: 0 0 0 0 rgba(255, 215, 0, 0.5); }
  50% { box-shadow: 0 0 0 15px rgba(255, 215, 0, 0); }
}

.node-glow {
  position: absolute;
  width: 70px;
  height: 70px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(255, 215, 0, 0.3) 0%, transparent 70%);
  animation: glow 2s infinite;
}

@keyframes glow {
  0%, 100% { transform: scale(1); opacity: 1; }
  50% { transform: scale(1.3); opacity: 0.5; }
}

.node-name {
  margin-top: 8px;
  font-size: 12px;
  font-weight: 600;
  color: #333;
  text-shadow: 0 1px 2px rgba(255, 255, 255, 0.8);
  white-space: nowrap;
}

.node-progress {
  margin-top: 4px;
  text-align: center;
}

.progress-bar {
  width: 60px;
  height: 4px;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 2px;
  overflow: hidden;
}

.progress-bar .progress {
  height: 100%;
  background: linear-gradient(90deg, #4caf50, #8bc34a);
  transition: width 0.5s ease;
}

.progress-text {
  font-size: 10px;
  color: #666;
}

/* 地点类型颜色 */
.location-node.forest .node-icon { border: 3px solid #4caf50; }
.location-node.desert .node-icon { border: 3px solid #ff9800; }
.location-node.snow .node-icon { border: 3px solid #03a9f4; }
.location-node.castle .node-icon { border: 3px solid #9c27b0; }
.location-node.sky .node-icon { border: 3px solid #ffd700; }

/* 弹窗 */
.location-modal {
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
  background: white;
  border-radius: 20px;
  padding: 24px;
  max-width: 360px;
  width: 100%;
  position: relative;
}

.close-btn {
  position: absolute;
  top: 12px;
  right: 12px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #999;
}

.location-header {
  text-align: center;
  margin-bottom: 16px;
}

.location-header.forest { color: #4caf50; }
.location-header.desert { color: #ff9800; }
.location-header.snow { color: #03a9f4; }
.location-header.castle { color: #9c27b0; }
.location-header.sky { color: #ffa000; }

.location-icon {
  font-size: 48px;
  display: block;
  margin-bottom: 8px;
}

.location-header h2 {
  font-size: 20px;
  margin: 0 0 8px 0;
}

.status-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 12px;
  background: #f5f5f5;
}

.status-badge.current {
  background: #fff8e1;
  color: #f57f17;
}

.status-badge.completed {
  background: #e8f5e9;
  color: #2e7d32;
}

.location-desc {
  color: #666;
  font-size: 14px;
  text-align: center;
  margin-bottom: 16px;
}

.location-story {
  background: #f5f5f5;
  padding: 12px;
  border-radius: 8px;
  margin-bottom: 16px;
  font-size: 13px;
  color: #555;
  line-height: 1.6;
}

.location-rewards h4 {
  font-size: 14px;
  color: #999;
  margin-bottom: 8px;
}

.rewards-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.reward-item {
  display: flex;
  align-items: center;
  gap: 4px;
  background: #fff8e1;
  padding: 6px 12px;
  border-radius: 16px;
  font-size: 13px;
  color: #f57f17;
}

.unlock-hint {
  text-align: center;
  padding: 16px;
  background: #fafafa;
  border-radius: 8px;
  color: #999;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>