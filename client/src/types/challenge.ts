export interface ChallengeLevel {
  id: string
  name: string
  description: string
  wordCount: number
  timeLimit: number | null
  maxErrors: number
  difficulty: 'easy' | 'medium' | 'hard' | 'expert' | 'legendary'
  xpReward: number
  prerequisiteLevelId: string | null
  createdAt: Date
  // User-specific fields
  isUnlocked: boolean
  starRating: number
  bestTime: number | null
  isPassed: boolean
}

export interface ChallengeSession {
  id: string
  userId: string
  levelId: string
  words: ChallengeWord[]
  currentIndex: number
  correctCount: number
  wrongCount: number
  startTime: Date
  timeLimit: number | null
  maxErrors: number
}

export interface ChallengeWord {
  id: string
  word: string
  phonetic: string
  meaning: string
}

export interface ChallengeResult {
  id: string
  userId: string
  levelId: string
  correctCount: number
  wrongCount: number
  timeTaken: number
  starRating: number
  xpEarned: number
  isPassed: boolean
  completedAt: Date
  level?: ChallengeLevel
}