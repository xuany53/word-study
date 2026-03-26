export type BadgeRarity = 'common' | 'rare' | 'epic' | 'legendary'

export interface Badge {
  id: string
  name: string
  icon: string
  description: string
  rarity: BadgeRarity
  unlockCondition: BadgeCondition
  createdAt: Date
  // User-specific fields
  isUnlocked: boolean
  unlockedAt?: Date | null
}

export interface BadgeCondition {
  type: 'streak' | 'words_learned' | 'words_mastered' | 'accuracy' | 'level' | 'challenge_complete' | 'perfect_score'
  value: number
}

export interface UserLevel {
  currentLevel: number
  currentTitle: string
  xp: number
  xpToNext: number
  levelProgress: number
}

export interface CheckInResult {
  streak: number
  longestStreak: number
  xpGained: number
}

// Level titles based on level number
export const levelTitles: Record<number, string> = {
  1: '初学者',
  5: '入门学徒',
  10: '学习达人',
  15: '词汇新秀',
  20: '单词能手',
  25: '学习专家',
  30: '词汇大师',
  35: '记忆天才',
  40: '单词王者',
  45: '传奇学者',
  50: '不朽传奇'
}

export function getLevelTitle(level: number): string {
  const thresholds = Object.keys(levelTitles)
    .map(Number)
    .sort((a, b) => b - a)

  for (const threshold of thresholds) {
    if (level >= threshold) {
      return levelTitles[threshold]
    }
  }

  return '初学者'
}