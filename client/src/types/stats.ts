/**
 * User statistics interface
 */
export interface UserStats {
  level: number
  xp: number
  streak: number
  longestStreak: number
  totalWords: number
  masteredWords: number
  correctRate: number
}

/**
 * Daily statistics interface
 */
export interface DailyStats {
  newWordsCount: number
  reviewWordsCount: number
  correctCount: number
  wrongCount: number
  correctRate: number
}

/**
 * Check-in record interface
 */
export interface CheckInRecord {
  id: string
  userId: string
  date: Date
  xpGained: number
}

/**
 * Statistics API response
 */
export interface StatsResponse {
  success: boolean
  data?: UserStats
  message?: string
}

/**
 * Daily stats API response
 */
export interface DailyStatsResponse {
  success: boolean
  data?: DailyStats
  message?: string
}

/**
 * Check-in API response
 */
export interface CheckInResponse {
  success: boolean
  data?: {
    streak: number
    longestStreak: number
    xpGained: number
  }
  message?: string
}