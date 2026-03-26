/**
 * Word Type - 单词类型定义
 */

export interface WordMeaning {
  partOfSpeech: string      // 词性 (noun, verb, adj, etc.)
  definition: string        // 英文定义
  translation: string       // 中文翻译
}

export interface WordExample {
  sentence: string          // 例句
  translation: string       // 翻译
}

export interface Word {
  id: string
  word: string
  phonetic: string
  pronunciation?: string    // 音频URL (可选)
  meanings: WordMeaning[]
  examples: WordExample[]
  image?: string           // 图片URL (可选)
  category?: string        // 分类/级别 (如 RAZ等级)
  difficulty?: number      // 难度等级 1-5
  createdAt?: Date
}

/**
 * 用于创建/更新单词的DTO
 */
export interface WordInput {
  word: string
  phonetic: string
  pronunciation?: string
  meanings: WordMeaning[]
  examples: WordExample[]
  image?: string
  category?: string
  difficulty?: number
}

/**
 * 单词学习记录
 */
export interface WordProgress {
  wordId: string
  mastery: number          // 掌握度 0-100
  nextReview: Date         // 下次复习时间
  lastReview?: Date        // 上次复习时间
  reviewCount: number      // 复习次数
  correctCount: number     // 正确次数
  wrongCount: number       // 错误次数
}

/**
 * 单词统计
 */
export interface WordStats {
  totalWords: number
  masteredWords: number    // mastery >= 80
  learningWords: number    // 20 <= mastery < 80
  newWords: number         // mastery < 20
}