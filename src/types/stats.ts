/**
 * Stats Types - 统计相关类型定义
 * @module types/stats
 */

/**
 * 每日统计
 */
export interface DailyStats {
  /** 日期 */
  date: Date
  /** 新词数量 */
  newWordsCount: number
  /** 复习数量 */
  reviewWordsCount: number
  /** 正确数量 */
  correctCount: number
  /** 错误数量 */
  wrongCount: number
  /** 正确率 */
  correctRate: number
  /** 是否完成当日任务 */
  isCompleted: boolean
}

/**
 * 打卡记录
 */
export interface CheckInRecord {
  /** 日期 */
  date: Date
  /** 是否打卡 */
  isCheckIn: boolean
}

/**
 * 用户统计
 */
export interface UserStats {
  /** 累计学习天数 */
  totalDays: number
  /** 总学习词汇数 */
  totalWords: number
  /** 已掌握词汇数 */
  masteredWords: number
  /** 总体正确率 */
  correctRate: number
  /** 连续打卡天数 */
  streak: number
  /** 今日统计 */
  todayStats: DailyStats
  /** 打卡日历 */
  checkInCalendar: CheckInRecord[]
  /** 总学习时间(分钟) */
  totalStudyTime: number
  /** 最长连续打卡 */
  longestStreak: number
}

/**
 * 统计时间范围
 */
export type StatsTimeRange = 'today' | 'week' | 'month' | 'year' | 'all'

/**
 * 统计趋势数据
 */
export interface StatsTrend {
  /** 日期 */
  date: Date
  /** 数值 */
  value: number
}

/**
 * 统计概览
 */
export interface StatsOverview {
  /** 今日新词 */
  todayNewWords: number
  /** 今日复习 */
  todayReview: number
  /** 今日正确率 */
  todayAccuracy: number
  /** 本周学习天数 */
  weekStudyDays: number
  /** 本月学习天数 */
  monthStudyDays: number
  /** 累计掌握 */
  totalMastered: number
}