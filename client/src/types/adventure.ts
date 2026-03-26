/**
 * Adventure Types - 单词大冒险类型定义
 */

// 地点类型
export type LocationType = 'forest' | 'desert' | 'snow' | 'castle' | 'sky'

// 地点状态
export type LocationStatus = 'locked' | 'current' | 'completed'

// 地点定义
export interface AdventureLocation {
  id: string
  name: string
  type: LocationType
  description: string
  icon: string
  daysRequired: number  // 到达此地需要的天数
  rewards: AdventureReward
  themeWords?: string[]  // 主题单词分类
  story?: string  // 小剧情
}

// 冒险奖励
export interface AdventureReward {
  xp: number
  badge?: string
  theme?: string
}

// 用户冒险进度
export interface UserAdventureProgress {
  currentLocationId: string
  totalSteps: number
  currentStepInLocation: number
  completedLocations: string[]
  startedAt: Date
  lastCheckInAt: Date | null
}

// 地点状态
export interface LocationWithStatus extends AdventureLocation {
  status: LocationStatus
  progress: number  // 0-100
}

// 地图配置
export interface MapConfig {
  gridSize: number
  locations: AdventureLocation[]
}

// 地点主题色
export const locationColors: Record<LocationType, { primary: string; secondary: string; bg: string }> = {
  forest: { primary: '#4caf50', secondary: '#2e7d32', bg: '#e8f5e9' },
  desert: { primary: '#ff9800', secondary: '#f57c00', bg: '#fff3e0' },
  snow: { primary: '#03a9f4', secondary: '#0288d1', bg: '#e1f5fe' },
  castle: { primary: '#9c27b0', secondary: '#7b1fa2', bg: '#f3e5f5' },
  sky: { primary: '#ffd700', secondary: '#ff9800', bg: '#fff8e1' }
}

// 地点图标
export const locationIcons: Record<LocationType, string> = {
  forest: '🌲',
  desert: '🏜️',
  snow: '❄️',
  castle: '🏰',
  sky: '☁️'
}