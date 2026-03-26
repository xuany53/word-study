<template>
  <div class="farm-grid">
    <!-- 农场背景 -->
    <div class="farm-background">
      <!-- 4x4 网格 -->
      <div class="grid-container">
        <div
          v-for="(row, y) in grid"
          :key="y"
          class="grid-row"
        >
          <div
            v-for="(cell, x) in row"
            :key="x"
            class="grid-cell"
            :class="{ 'has-plant': cell, 'mature': cell?.status === 'mature' }"
            @click="handleCellClick(cell, x, y)"
          >
            <!-- 空格子 -->
            <div v-if="!cell" class="empty-cell">
              <span class="plus-icon">+</span>
            </div>

            <!-- 植物 -->
            <div v-else class="plant-container">
              <div class="plant-icon" :class="cell.status">
                {{ getPlantIcon(cell) }}
              </div>
              <div class="growth-bar" v-if="cell.status !== 'mature'">
                <div class="growth-progress" :style="{ width: cell.growthProgress + '%' }"></div>
              </div>
              <div class="harvest-badge" v-if="cell.status === 'mature'">
                收获
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 种植选择弹窗 -->
    <Teleport to="body">
      <Transition name="fade">
        <div v-if="showPlantModal" class="plant-modal" @click="showPlantModal = false">
          <div class="modal-content" @click.stop>
            <h3>选择种子</h3>
            <div class="seed-list">
              <div
                v-for="plant in availablePlants"
                :key="plant.id"
                class="seed-item"
                @click="selectPlant(plant.id)"
              >
                <span class="seed-icon">{{ plant.icon }}</span>
                <span class="seed-name">{{ plant.name }}</span>
                <span class="seed-time">{{ plant.growthDays }}天</span>
              </div>
            </div>
            <button class="cancel-btn" @click="showPlantModal = false">取消</button>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { UserPlant } from '@/types/farm'
import { plants, getCurrentStage } from '@/data/plants'

interface Props {
  grid: (UserPlant | null)[][]
  seeds: number
}

const props = defineProps<Props>()

const emit = defineEmits<{
  (e: 'plant', plantId: string, x: number, y: number): void
  (e: 'water', x: number, y: number): void
  (e: 'harvest', x: number, y: number): void
}>()

const showPlantModal = ref(false)
const selectedCell = ref<{ x: number; y: number } | null>(null)

// 可种植的植物
const availablePlants = computed(() => plants.slice(0, 5))

// 获取植物图标
const getPlantIcon = (cell: UserPlant): string => {
  const plant = plants.find(p => p.id === cell.plantId)
  if (!plant) return '🌱'

  const stage = getCurrentStage(plant, cell.growthProgress)
  return stage.icon
}

// 处理格子点击
const handleCellClick = (cell: UserPlant | null, x: number, y: number) => {
  if (!cell) {
    // 空格子 - 种植
    if (props.seeds > 0) {
      selectedCell.value = { x, y }
      showPlantModal.value = true
    }
  } else if (cell.status === 'mature') {
    // 成熟 - 收获
    emit('harvest', x, y)
  } else {
    // 成长中 - 浇水
    emit('water', x, y)
  }
}

// 选择植物
const selectPlant = (plantId: string) => {
  if (selectedCell.value) {
    emit('plant', plantId, selectedCell.value.x, selectedCell.value.y)
    showPlantModal.value = false
    selectedCell.value = null
  }
}
</script>

<style scoped>
.farm-grid {
  position: relative;
}

.farm-background {
  background: linear-gradient(180deg, #87ceeb 0%, #98d4a1 30%, #6b8e4e 100%);
  border-radius: 16px;
  padding: 20px;
  position: relative;
  overflow: hidden;
}

.farm-background::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Cpath d='M30 5 L35 15 L30 10 L25 15 Z' fill='%23fff' opacity='0.1'/%3E%3C/svg%3E");
  pointer-events: none;
}

.grid-container {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.grid-row {
  display: flex;
  gap: 8px;
}

.grid-cell {
  flex: 1;
  aspect-ratio: 1;
  background: rgba(139, 90, 43, 0.6);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.grid-cell:hover {
  transform: scale(1.05);
  background: rgba(139, 90, 43, 0.8);
}

.grid-cell.has-plant {
  background: rgba(139, 90, 43, 0.9);
}

.grid-cell.mature {
  animation: glow 1s infinite alternate;
}

@keyframes glow {
  from { box-shadow: 0 0 5px rgba(255, 215, 0, 0.5); }
  to { box-shadow: 0 0 15px rgba(255, 215, 0, 0.8); }
}

.empty-cell {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.plus-icon {
  font-size: 32px;
  color: rgba(255, 255, 255, 0.5);
}

.plant-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  padding: 8px;
}

.plant-icon {
  font-size: 36px;
  margin-bottom: 4px;
}

.plant-icon.seed {
  font-size: 24px;
}

.plant-icon.growing {
  animation: grow 0.5s ease;
}

@keyframes grow {
  from { transform: scale(0.8); }
  to { transform: scale(1); }
}

.growth-bar {
  width: 100%;
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  overflow: hidden;
}

.growth-progress {
  height: 100%;
  background: linear-gradient(90deg, #4caf50, #8bc34a);
  transition: width 0.3s ease;
}

.harvest-badge {
  background: linear-gradient(135deg, #ffd700, #ff9800);
  color: white;
  font-size: 10px;
  padding: 2px 8px;
  border-radius: 8px;
  margin-top: 4px;
}

/* 种植弹窗 */
.plant-modal {
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
  width: 100%;
  max-width: 320px;
}

.modal-content h3 {
  text-align: center;
  margin-bottom: 16px;
  color: #4caf50;
}

.seed-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 16px;
}

.seed-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: #f5f5f5;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.seed-item:hover {
  background: #e8f5e9;
  transform: translateX(4px);
}

.seed-icon {
  font-size: 28px;
}

.seed-name {
  flex: 1;
  font-weight: 500;
}

.seed-time {
  font-size: 12px;
  color: #999;
}

.cancel-btn {
  width: 100%;
  padding: 12px;
  background: #f5f5f5;
  border: none;
  border-radius: 12px;
  font-size: 16px;
  cursor: pointer;
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