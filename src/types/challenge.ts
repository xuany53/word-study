/**
 * Challenge Types - 闯关相关类型定义
 * @module types/challenge
 */

/**
 * 关卡难度
 */
export type ChallengeDifficulty = 'easy' | 'medium' | 'hard' | 'extreme'

/**
 * 星级评价 (0-3星)
 */
export type StarRating = 0 | 1 | 2 | 3

/**
 * 闯关关卡
 */
export interface ChallengeLevel {
  /** 唯一标识 */
  id: string
  /** 关卡名称 */
  name: string
  /** 关卡描述 */
  description: string
  /** 单词数量 */
  wordCount: number
  /** 时间限制(秒), 无限制则 undefined */
  timeLimit?: number
  /** 最大错误次数 */
  maxErrors: number
  /** 难度 */
  difficulty: ChallengeDifficulty
  /** 星级评价 */
  starRating: StarRating
  /** 是否已解锁 */
  isUnlocked: boolean
  /** 解锁所需等级 */
  requiredLevel?: number
  /** 完成奖励经验 */
  xpReward: number
  /** 前置关卡ID */
  prerequisiteLevelId?: string
}

/**
 * 闯关会话
 */
export interface ChallengeSession {
  /** 会话ID */
  id: string
  /** 关卡ID */
  levelId: string
  /** 单词ID列表 */
  wordIds: string[]
  /** 当前索引 */
  currentIndex: number
  /** 开始时间 */
  startTime: Date
  /** 结束时间 */
  endTime?: Date
  /** 正确数量 */
  correctCount: number
  /** 错误数量 */
  wrongCount: number
  /** 剩余时间(秒) */
  timeRemaining?: number
  /** 是否完成 */
  isCompleted: boolean
  /** 是否失败 */
  isFailed: boolean
  /** 最终星级 */
  finalStars?: StarRating
}

/**
 * 闯关结果
 */
export interface ChallengeResult {
  /** 关卡ID */
  levelId: string
  /** 是否通过 */
  isPassed: boolean
  /** 星级评价 */
  starRating: StarRating
  /** 正确数量 */
  correctCount: number
  /** 错误数量 */
  wrongCount: number
  /** 用时(秒) */
  timeTaken: number
  /** 获得经验 */
  xpEarned: number
  /** 是否新纪录 */
  isNewRecord: boolean
  /** 完成时间 */
  completedAt: Date
}

/**
 * 关卡进度
 */
export interface LevelProgress {
  /** 关卡ID */
  levelId: string
  /** 最高星级 */
  bestStars: StarRating
  /** 完成次数 */
  completionCount: number
  /** 最佳时间(秒) */
  bestTime?: number
  /** 最后完成时间 */
  lastCompletedAt?: Date
}

/**
 * 星级评价标准
 */
export const STAR_RATING_CRITERIA = {
  /** 3星: 正确率 >= 90% */
  threeStars: 90,
  /** 2星: 正确率 >= 70% */
  twoStars: 70,
  /** 1星: 正确率 >= 50% */
  oneStar: 50
} as const

/**
 * 计算星级评价
 * @param correctCount 正确数量
 * @param totalCount 总数量
 * @returns 星级评价
 */
export function calculateStarRating(correctCount: number, totalCount: number): StarRating {
  if (totalCount === 0) return 0
  const accuracy = (correctCount / totalCount) * 100
  if (accuracy >= STAR_RATING_CRITERIA.threeStars) return 3
  if (accuracy >= STAR_RATING_CRITERIA.twoStars) return 2
  if (accuracy >= STAR_RATING_CRITERIA.oneStar) return 1
  return 0
}