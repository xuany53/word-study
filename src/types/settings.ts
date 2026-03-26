/**
 * Settings Types - 设置相关类型定义
 * @module types/settings
 */

/**
 * 用户设置
 */
export interface UserSettings {
  /** 每日新词数量 */
  dailyNewWords: number
  /** 学习模式 */
  learningMode: LearningMode
  /** 音效开关 */
  soundEnabled: boolean
  /** 自动播放发音 */
  autoPlayAudio: boolean
  /** 主题 */
  theme: ThemeMode
  /** 提醒时间 (HH:mm 格式) */
  reminderTime?: string
  /** 提醒开关 */
  reminderEnabled: boolean
}

/**
 * 学习模式
 */
export type LearningMode = 'choice' | 'spelling' | 'mixed'

/**
 * 主题模式
 */
export type ThemeMode = 'light' | 'dark' | 'auto'

/**
 * 默认设置
 */
export const DEFAULT_SETTINGS: UserSettings = {
  dailyNewWords: 20,
  learningMode: 'choice',
  soundEnabled: true,
  autoPlayAudio: true,
  theme: 'auto',
  reminderTime: '09:00',
  reminderEnabled: false
} as const

/**
 * 设置变更记录
 */
export interface SettingsChange<K extends keyof UserSettings = keyof UserSettings> {
  /** 设置键 */
  key: K
  /** 旧值 */
  oldValue: UserSettings[K]
  /** 新值 */
  newValue: UserSettings[K]
  /** 变更时间 */
  changedAt: Date
}