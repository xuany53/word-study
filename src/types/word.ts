/**
 * Word Types - 单词相关类型定义
 * @module types/word
 */

/**
 * 词性释义
 */
export interface Meaning {
  /** 词性 (noun, verb, adjective, etc.) */
  partOfSpeech: string
  /** 英文定义 */
  definition: string
  /** 中文翻译 */
  translation: string
}

/**
 * 例句
 */
export interface Example {
  /** 英文例句 */
  sentence: string
  /** 中文翻译 */
  translation: string
}

/**
 * 单词
 */
export interface Word {
  /** 唯一标识 */
  id: string
  /** 单词 */
  word: string
  /** 音标 */
  phonetic: string
  /** 发音音频URL */
  pronunciation: string
  /** 释义列表 */
  meanings: Meaning[]
  /** 例句列表 */
  examples: Example[]
  /** 关联图片URL (可选) */
  image?: string
  /** 分类标签 (可选) */
  category?: string
  /** 难度等级 (1-5) */
  difficulty: 1 | 2 | 3 | 4 | 5
}

/**
 * 单词分类
 */
export type WordCategory =
  | 'animals'
  | 'food'
  | 'technology'
  | 'daily-life'
  | 'business'
  | 'academic'
  | 'travel'
  | 'sports'
  | 'nature'
  | 'other'

/**
 * 单词筛选条件
 */
export interface WordFilter {
  /** 分类 */
  category?: WordCategory
  /** 难度范围 */
  difficulty?: {
    min: number
    max: number
  }
  /** 搜索关键词 */
  keyword?: string
}