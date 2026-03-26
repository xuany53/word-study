import { defineStore } from 'pinia'
import type { FarmState, UserPlant, PlantStatus } from '@/types/farm'

export const useFarmStore = defineStore('farm', {
  state: (): FarmState & { loading: boolean } => ({
    grid: createEmptyGrid(),
    coins: 100,
    seeds: 5,
    totalHarvested: 0,
    loading: false
  }),

  getters: {
    // 获取格子上的植物
    getPlantAt: (state) => (x: number, y: number): UserPlant | null => {
      if (x < 0 || x >= 4 || y < 0 || y >= 4) return null
      return state.grid[y][x]
    },

    // 可种植的格子数量
    availableSlots: (state): number => {
      let count = 0
      for (let y = 0; y < 4; y++) {
        for (let x = 0; x < 4; x++) {
          if (!state.grid[y][x]) count++
        }
      }
      return count
    },

    // 成熟的植物数量
    maturePlants: (state): number => {
      let count = 0
      for (let y = 0; y < 4; y++) {
        for (let x = 0; x < 4; x++) {
          if (state.grid[y][x]?.status === 'mature') count++
        }
      }
      return count
    }
  },

  actions: {
    // 种植植物
    plantSeed(plantId: string, x: number, y: number): boolean {
      if (this.seeds <= 0) return false
      if (x < 0 || x >= 4 || y < 0 || y >= 4) return false
      if (this.grid[y][x]) return false

      this.grid[y][x] = {
        id: `plant-${Date.now()}`,
        plantId,
        position: { x, y },
        plantedAt: new Date(),
        lastWateredAt: null,
        growthProgress: 0,
        status: 'seed'
      }

      this.seeds--
      this.saveFarm()
      return true
    },

    // 浇水
    waterPlant(x: number, y: number): boolean {
      const plant = this.grid[y]?.[x]
      if (!plant || plant.status === 'mature') return false

      plant.lastWateredAt = new Date()
      plant.growthProgress = Math.min(100, plant.growthProgress + 20)

      // 更新状态
      if (plant.growthProgress >= 100) {
        plant.status = 'mature'
      } else if (plant.growthProgress > 0) {
        plant.status = 'growing'
      }

      this.saveFarm()
      return true
    },

    // 收获
    harvest(x: number, y: number): { xp: number } | null {
      const plant = this.grid[y]?.[x]
      if (!plant || plant.status !== 'mature') return null

      // 获取植物奖励
      const xp = this.getPlantXpReward(plant.plantId)

      // 移除植物
      this.grid[y][x] = null
      this.totalHarvested++
      this.coins += 10

      this.saveFarm()
      return { xp }
    },

    // 获取植物XP奖励
    getPlantXpReward(plantId: string): number {
      const rewards: Record<string, number> = {
        'sunflower': 30,
        'rose': 50,
        'cherry-tree': 100,
        'carrot': 20,
        'tomato': 40,
        'house': 200,
        'fountain': 150
      }
      return rewards[plantId] || 20
    },

    // 每日生长
    dailyGrowth() {
      for (let y = 0; y < 4; y++) {
        for (let x = 0; x < 4; x++) {
          const plant = this.grid[y][x]
          if (plant && plant.status !== 'mature') {
            plant.growthProgress = Math.min(100, plant.growthProgress + (100 / 7)) // 7天成熟

            if (plant.growthProgress >= 100) {
              plant.status = 'mature'
            } else {
              plant.status = 'growing'
            }
          }
        }
      }
      this.saveFarm()
    },

    // 购买种子
    buySeeds(count: number): boolean {
      const cost = count * 20
      if (this.coins < cost) return false

      this.coins -= cost
      this.seeds += count
      this.saveFarm()
      return true
    },

    // 保存农场
    saveFarm() {
      localStorage.setItem('farmState', JSON.stringify({
        grid: this.grid,
        coins: this.coins,
        seeds: this.seeds,
        totalHarvested: this.totalHarvested,
        savedAt: new Date().toDateString()
      }))
    },

    // 加载农场
    loadFarm() {
      const saved = localStorage.getItem('farmState')
      if (saved) {
        const data = JSON.parse(saved)
        const today = new Date().toDateString()

        this.grid = data.grid || createEmptyGrid()
        this.coins = data.coins || 100
        this.seeds = data.seeds || 5
        this.totalHarvested = data.totalHarvested || 0

        // 如果是新的一天，植物生长
        if (data.savedAt !== today) {
          this.dailyGrowth()
          // 每日赠送种子
          this.seeds += 1
        }
      }
    }
  }
})

// 创建空网格
function createEmptyGrid(): (UserPlant | null)[][] {
  return Array(4).fill(null).map(() => Array(4).fill(null))
}