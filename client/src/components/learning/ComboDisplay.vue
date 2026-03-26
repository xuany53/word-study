<template>
  <Transition name="combo">
    <div v-if="visible && combo > 1" class="combo-display" :class="comboClass">
      <div class="combo-icon">{{ comboIcon }}</div>
      <div class="combo-info">
        <span class="combo-count">{{ combo }}</span>
        <span class="combo-label">连击!</span>
      </div>
      <div class="combo-multiplier">x{{ multiplier.toFixed(1) }}</div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  visible: boolean
  combo: number
}

const props = defineProps<Props>()

// 计算倍率
const multiplier = computed(() => {
  if (props.combo >= 10) return 2.0
  if (props.combo >= 5) return 1.5
  if (props.combo >= 2) return 1.2
  return 1.0
})

// 连击图标
const comboIcon = computed(() => {
  if (props.combo >= 10) return '🔥'
  if (props.combo >= 5) return '⚡'
  if (props.combo >= 3) return '✨'
  return '💫'
})

// 样式类
const comboClass = computed(() => {
  if (props.combo >= 10) return 'legendary'
  if (props.combo >= 5) return 'epic'
  if (props.combo >= 3) return 'rare'
  return 'common'
})
</script>

<style scoped>
.combo-display {
  position: fixed;
  top: 20%;
  right: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px 24px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.95);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  z-index: 100;
  animation: comboEnter 0.3s ease;
}

@keyframes comboEnter {
  from {
    opacity: 0;
    transform: translateX(50px) scale(0.8);
  }
  to {
    opacity: 1;
    transform: translateX(0) scale(1);
  }
}

.combo-display.common {
  border-left: 4px solid #9e9e9e;
}

.combo-display.rare {
  border-left: 4px solid #2196f3;
}

.combo-display.epic {
  border-left: 4px solid #9c27b0;
  animation: comboEnter 0.3s ease, glow 1s infinite alternate;
}

.combo-display.legendary {
  border-left: 4px solid #ffd700;
  background: linear-gradient(135deg, #fff8e1 0%, #ffffff 100%);
  animation: comboEnter 0.3s ease, legendaryGlow 0.5s infinite alternate;
}

@keyframes glow {
  from { box-shadow: 0 4px 20px rgba(156, 39, 176, 0.3); }
  to { box-shadow: 0 4px 30px rgba(156, 39, 176, 0.6); }
}

@keyframes legendaryGlow {
  from { box-shadow: 0 4px 20px rgba(255, 215, 0, 0.5); }
  to { box-shadow: 0 4px 40px rgba(255, 215, 0, 0.8); }
}

.combo-icon {
  font-size: 32px;
  margin-bottom: 8px;
}

.combo-display.legendary .combo-icon {
  animation: bounce 0.5s ease infinite;
}

@keyframes bounce {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.2); }
}

.combo-info {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.combo-count {
  font-size: 36px;
  font-weight: bold;
  line-height: 1;
}

.combo-display.common .combo-count { color: #9e9e9e; }
.combo-display.rare .combo-count { color: #2196f3; }
.combo-display.epic .combo-count { color: #9c27b0; }
.combo-display.legendary .combo-count {
  background: linear-gradient(135deg, #ffd700, #ff9800);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.combo-label {
  font-size: 14px;
  color: #666;
}

.combo-multiplier {
  margin-top: 8px;
  padding: 4px 12px;
  background: #fff8e1;
  color: #f57f17;
  border-radius: 12px;
  font-weight: bold;
  font-size: 14px;
}

.combo-display.legendary .combo-multiplier {
  background: linear-gradient(135deg, #ffd700, #ff9800);
  color: white;
}

/* Transitions */
.combo-enter-active {
  animation: comboEnter 0.3s ease;
}

.combo-leave-active {
  transition: all 0.3s ease;
}

.combo-enter-from,
.combo-leave-to {
  opacity: 0;
  transform: translateX(50px) scale(0.8);
}
</style>