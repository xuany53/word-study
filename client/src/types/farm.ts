/**
 * Farm Types - 单词农场类型定义
 */

// 植物状态
export type PlantStatus = 'seed' | 'growing' | 'mature' | 'withered'

// 植物类型
export type PlantType = 'flower' | 'tree' | 'vegetable' | 'building'

// 植物定义
export interface PlantDefinition {
  id: string
  name: string
  type: PlantType
  icon: string
  growthDays: number  // 成熟所需天数
  xpReward: number
  stages: PlantStage[]
}

// 植物生长阶段
export interface PlantStage {
  day: number
  icon: string
  description: string
}

// 用户植物
export interface UserPlant {
  id: string
  plantId: string
  position: { x: number; y: number }
  plantedAt: Date
  lastWateredAt: Date | null
  growthProgress: number  // 0-100
  status: PlantStatus
}

// 农场状态
export interface FarmState {
  grid: (UserPlant | null)[][]
  coins: number
  seeds: number
  totalHarvested: number
}

// 植物图标映射
export const plantIcons: Record<PlantStatus, string> = {
  seed: '🌱',
  growing: '🌿',
  mature: '🌸',
  withered: '🥀'
}

// 类型颜色
export const plantColors: Record<PlantType, string> = {
  flower: '#e91e63',
  tree: '#4caf50',
  vegetable: '#ff9800',
  building: '#9c27b0'
}