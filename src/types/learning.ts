/**
 * Learning Types - 学习相关类型定义
 * @module types/learning
 */

/**
 * 学习状态
 */
export type LearningStatus = 'new' | 'learning' | 'reviewing' | 'mastered'

/**
 * 掌握度等级 (0-5)
 * - 0: 未学习
 * - 1: 刚接触
 * - 2: 有印象
 * - 3: 基本掌握
 * - 4: 较熟悉
 * - 5: 完全掌握
 */
export type MasteryLevel = 0 | 1 | 2 | 3 | 4 | 5

/**
 * 学习记录
 */
export interface LearningRecord {
  /** 唯一标识 */
  id: string
  /** 单词ID */
  wordId: string
  /** 学习状态 */
  status: LearningStatus
  /** 掌握度 (0-5) */
  masteryLevel: MasteryLevel
  /** 正确次数 */
  correctCount: number
  /** 错误次数 */
  wrongCount: number
  /** 下次复习时间 */
  nextReviewAt: Date
  /** 上次复习时间 */
  lastReviewAt: Date
  /** 创建时间 */
  createdAt: Date
}

/**
 * 学习会话
 */
export interface LearningSession {
  /** 会话ID */
  id: string
  /** 开始时间 */
  startTime: Date
  /** 结束时间 */
  endTime?: Date
  /** 学习的单词ID列表 */
  wordIds: string[]
  /** 当前索引 */
  currentIndex: number
  /** 正确数量 */
  correctCount: number
  /** 错误数量 */
  wrongCount: number
  /** 学习模式 */
  mode: LearningMode
  /** 是否完成 */
  isCompleted: boolean
}

/**
 * 学习模式
 */
export type LearningMode = 'choice' | 'spelling' | 'mixed'

/**
 * 学习结果
 */
export interface LearningResult {
  /** 单词ID */
  wordId: string
  /** 是否正确 */
  isCorrect: boolean
  /** 用户答案 */
  userAnswer: string
  /** 正确答案 */
  correctAnswer: string
  /** 答题时间(ms) */
  responseTime: number
  /** 时间戳 */
  timestamp: Date
}

/**
 * 复习间隔配置 (艾宾浩斯遗忘曲线)
 */
export const REVIEW_INTERVALS = {
  /** 掌握度0 → 1天后复习 */
  0: 1,
  /** 掌握度1 → 2天后复习 */
  1: 2,
  /** 掌握度2 → 4天后复习 */
  2: 4,
  /** 掌握度3 → 7天后复习 */
  3: 7,
  /** 掌握度4 → 15天后复习 */
  4: 15,
  /** 掌握度5 → 30天后复习 */
  5: 30
} as const

/**
 * 获取复习间隔天数
 */
export type ReviewIntervals = typeof REVIEW_INTERVALS