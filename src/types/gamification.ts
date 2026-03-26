/**
 * Gamification Types - 游戏化相关类型定义
 * @module types/gamification
 */

/**
 * 徽章稀有度
 */
export type BadgeRarity = 'common' | 'rare' | 'epic' | 'legendary'

/**
 * 徽章解锁条件类型
 */
export type BadgeConditionType = 'streak' | 'words' | 'accuracy' | 'challenge' | 'special'

/**
 * 徽章解锁条件
 */
export interface BadgeUnlockCondition {
  /** 条件类型 */
  type: BadgeConditionType
  /** 条件值 */
  value: number
  /** 额外参数 (如关卡ID) */
  params?: Record<string, unknown>
}

/**
 * 徽章
 */
export interface Badge {
  /** 唯一标识 */
  id: string
  /** 徽章名称 */
  name: string
  /** 徽章图标 */
  icon: string
  /** 徽章描述 */
  description: string
  /** 稀有度 */
  rarity: BadgeRarity
  /** 解锁条件 */
  unlockCondition: BadgeUnlockCondition
  /** 是否已解锁 */
  isUnlocked: boolean
  /** 解锁时间 */
  unlockedAt?: Date
}

/**
 * 用户等级
 */
export interface UserLevel {
  /** 当前等级 */
  currentLevel: number
  /** 当前称号 */
  currentTitle: string
  /** 当前经验值 */
  xp: number
  /** 下一级所需经验 */
  xpToNext: number
  /** 进度百分比 (0-100) */
  levelProgress: number
}

/**
 * 等级称号配置
 */
export interface LevelTitle {
  /** 等级 */
  level: number
  /** 称号 */
  title: string
  /** 所需总经验 */
  xpRequired: number
}

/**
 * 连续打卡状态
 */
export interface StreakInfo {
  /** 当前连续天数 */
  current: number
  /** 最长连续天数 */
  longest: number
  /** 今日是否已打卡 */
  todayChecked: boolean
  /** 昨日是否已打卡 */
  yesterdayChecked: boolean
}

/**
 * 经验值奖励配置
 */
export interface XpReward {
  /** 学习新词 */
  learnNewWord: number
  /** 复习旧词 */
  reviewWord: number
  /** 答对 */
  correctAnswer: number
  /** 完成每日任务 */
  completeDaily: number
  /** 完成关卡 */
  completeLevel: number
  /** 连续打卡奖励基数 */
  streakBonus: number
}

/**
 * 默认经验值奖励
 */
export const DEFAULT_XP_REWARD: XpReward = {
  learnNewWord: 10,
  reviewWord: 5,
  correctAnswer: 2,
  completeDaily: 50,
  completeLevel: 100,
  streakBonus: 10
} as const

/**
 * 等级称号列表
 */
export const LEVEL_TITLES: LevelTitle[] = [
  { level: 1, title: '初学者', xpRequired: 0 },
  { level: 2, title: '学徒', xpRequired: 100 },
  { level: 3, title: '学习者', xpRequired: 300 },
  { level: 5, title: '勤奋者', xpRequired: 600 },
  { level: 8, title: '单词达人', xpRequired: 1200 },
  { level: 12, title: '单词专家', xpRequired: 2400 },
  { level: 18, title: '单词大师', xpRequired: 4800 },
  { level: 25, title: '词汇专家', xpRequired: 8000 },
  { level: 35, title: '传奇人物', xpRequired: 15000 },
  { level: 50, title: '词汇之神', xpRequired: 30000 }
] as const