/**
 * Learning Types - 学习相关类型定义
 */

import type { Word } from './word'

// 学习模式
export type LearningMode = 'choice' | 'spelling' | 'listening'

// 答题结果
export interface AnswerResult {
  wordId: string
  isCorrect: boolean
  timestamp: Date
  xpEarned: number
}

// 学习会话
export interface LearningSession {
  id: string
  words: Word[]
  currentIndex: number
  mode: LearningMode
  startTime: Date
  results: AnswerResult[]
  totalXp: number
}

// 今日学习数据
export interface TodayLearning {
  newWords: number
  reviewWords: number
  newWordList: Word[]
  reviewRecords: ReviewRecord[]
}

// 复习记录
export interface ReviewRecord {
  word: Word
  nextReview: Date
  lastReview: Date | null
  mastery: number
}

// 学习统计
export interface LearningStats {
  totalWords: number
  masteredWords: number
  learningWords: number
  newWords: number
  todayStudied: number
  todayXp: number
}