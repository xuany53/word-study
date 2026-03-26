<template>
  <div class="farm-page">
    <div class="container">
      <!-- 顶部导航 -->
      <div class="nav-header">
        <button class="back-btn" @click="$router.push('/')">
          <span>←</span>
          <span>返回</span>
        </button>
        <div class="page-title">
          <h1>🌱 单词农场</h1>
          <p class="subtitle">种下种子，收获单词！</p>
        </div>
      </div>

      <!-- 资源栏 -->
      <div class="resources-bar card">
        <div class="resource-item">
          <span class="resource-icon">💰</span>
          <span class="resource-value">{{ coins }}</span>
          <span class="resource-label">金币</span>
        </div>
        <div class="resource-item">
          <span class="resource-icon">🌰</span>
          <span class="resource-value">{{ seeds }}</span>
          <span class="resource-label">种子</span>
        </div>
        <div class="resource-item">
          <span class="resource-icon">🎁</span>
          <span class="resource-value">{{ maturePlants }}</span>
          <span class="resource-label">可收获</span>
        </div>
      </div>

      <!-- 农场网格 -->
      <div class="farm-section">
        <FarmGrid
          :grid="grid"
          :seeds="seeds"
          @plant="handlePlant"
          @water="handleWater"
          @harvest="handleHarvest"
        />
      </div>

      <!-- 操作提示 -->
      <div class="tips-card card">
        <h4>操作提示</h4>
        <ul>
          <li>点击空格种植种子</li>
          <li>点击植物浇水加速生长</li>
          <li>成熟后点击收获获得 XP</li>
        </ul>
      </div>

      <!-- 商店 -->
      <div class="shop-section card">
        <h3>🏪 商店</h3>
        <div class="shop-items">
          <div class="shop-item" @click="buySeeds(1)">
            <span class="item-icon">🌰</span>
            <span class="item-name">种子 x1</span>
            <span class="item-price">💰 20</span>
          </div>
          <div class="shop-item" @click="buySeeds(5)">
            <span class="item-icon">🌰</span>
            <span class="item-name">种子 x5</span>
            <span class="item-price">💰 80</span>
          </div>
        </div>
      </div>

      <!-- 统计 -->
      <div class="stats-section card">
        <h3>农场统计</h3>
        <div class="stats-grid">
          <div class="stat-item">
            <span class="stat-value">{{ totalHarvested }}</span>
            <span class="stat-label">总收获</span>
          </div>
          <div class="stat-item">
            <span class="stat-value">{{ availableSlots }}</span>
            <span class="stat-label">空位</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 收获弹窗 -->
    <Teleport to="body">
      <Transition name="pop">
        <div v-if="showHarvestModal" class="modal-overlay" @click="showHarvestModal = false">
          <div class="modal-content harvest" @click.stop>
            <div class="harvest-icon">🎉</div>
            <h2>收获成功！</h2>
            <div class="harvest-reward">
              <span class="xp">+{{ lastHarvestXp }} XP</span>
              <span class="coins">+10 💰</span>
            </div>
            <button class="close-btn" @click="showHarvestModal = false">太棒了！</button>
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
import { useFarmStore } from '@/stores/farm'
import FarmGrid from '@/components/farm/FarmGrid.vue'

const router = useRouter()
const authStore = useAuthStore()
const farmStore = useFarmStore()

const showHarvestModal = ref(false)
const lastHarvestXp = ref(0)

// 计算属性
const grid = computed(() => farmStore.grid)
const coins = computed(() => farmStore.coins)
const seeds = computed(() => farmStore.seeds)
const maturePlants = computed(() => farmStore.maturePlants)
const totalHarvested = computed(() => farmStore.totalHarvested)
const availableSlots = computed(() => farmStore.availableSlots)

onMounted(() => {
  if (!authStore.isAuthenticated) {
    router.push('/login')
    return
  }

  farmStore.loadFarm()
})

// 种植
const handlePlant = (plantId: string, x: number, y: number) => {
  farmStore.plantSeed(plantId, x, y)
}

// 浇水
const handleWater = (x: number, y: number) => {
  farmStore.waterPlant(x, y)
}

// 收获
const handleHarvest = (x: number, y: number) => {
  const result = farmStore.harvest(x, y)
  if (result) {
    lastHarvestXp.value = result.xp
    showHarvestModal.value = true
  }
}

// 购买种子
const buySeeds = (count: number) => {
  if (farmStore.buySeeds(count)) {
    // 购买成功
  } else {
    alert('金币不足！')
  }
}
</script>

<style scoped>
.farm-page {
  min-height: 100vh;
  padding: 20px 0;
  background: linear-gradient(180deg, #87ceeb 0%, #e8f5e9 100%);
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

.resources-bar {
  display: flex;
  justify-content: space-around;
  margin-bottom: 24px;
  background: white;
}

.resource-item {
  text-align: center;
}

.resource-icon {
  font-size: 24px;
  display: block;
  margin-bottom: 4px;
}

.resource-value {
  font-size: 24px;
  font-weight: bold;
  color: #4caf50;
}

.resource-label {
  font-size: 12px;
  color: var(--text-secondary);
}

.farm-section {
  margin-bottom: 24px;
}

.tips-card {
  background: white;
  margin-bottom: 16px;
  padding: 16px;
}

.tips-card h4 {
  font-size: 14px;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.tips-card ul {
  margin: 0;
  padding-left: 20px;
}

.tips-card li {
  font-size: 14px;
  color: #555;
  margin-bottom: 4px;
}

.shop-section {
  background: white;
  margin-bottom: 16px;
}

.shop-section h3 {
  font-size: 18px;
  margin-bottom: 16px;
}

.shop-items {
  display: flex;
  gap: 12px;
}

.shop-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px;
  background: #f5f5f5;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.shop-item:hover {
  background: #e8f5e9;
  transform: translateY(-2px);
}

.item-icon {
  font-size: 32px;
  margin-bottom: 8px;
}

.item-name {
  font-weight: 500;
  margin-bottom: 4px;
}

.item-price {
  font-size: 14px;
  color: #ff9800;
}

.stats-section {
  background: white;
}

.stats-section h3 {
  font-size: 16px;
  margin-bottom: 16px;
  color: var(--text-secondary);
}

.stats-grid {
  display: flex;
  justify-content: space-around;
}

.stat-item {
  text-align: center;
}

.stat-value {
  display: block;
  font-size: 28px;
  font-weight: bold;
  color: #4caf50;
}

.stat-label {
  font-size: 12px;
  color: var(--text-secondary);
}

/* 收获弹窗 */
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

.modal-content.harvest {
  background: white;
  border-radius: 24px;
  padding: 32px;
  text-align: center;
  max-width: 280px;
  width: 100%;
}

.harvest-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.modal-content.harvest h2 {
  font-size: 24px;
  color: #4caf50;
  margin-bottom: 24px;
}

.harvest-reward {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 24px;
}

.harvest-reward .xp {
  font-size: 24px;
  font-weight: bold;
  color: #ff9800;
}

.harvest-reward .coins {
  font-size: 18px;
  color: #ffd700;
}

.close-btn {
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