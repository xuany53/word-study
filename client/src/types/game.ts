/**
 * Game Types - 游戏相关类型定义
 */

// 游戏类型
export type GameType = 'snake' | 'match' | 'adventure' | 'farm'

// 游戏状态
export type GameState = 'idle' | 'playing' | 'paused' | 'ended'

// 贪吃蛇方向
export type SnakeDirection = 'up' | 'down' | 'left' | 'right'

// 贪吃蛇游戏状态
export interface SnakeGameState {
  snake: Array<{ x: number; y: number }>
  direction: SnakeDirection
  nextDirection: SnakeDirection
  food: FoodItem | null
  score: number
  combo: number
  lives: number
  gameStatus: GameState
  speed: number
  gridSize: number
}

// 食物项（单词豆子）
export interface FoodItem {
  position: { x: number; y: number }
  word: string
  meaning: string
  isCorrect: boolean
}

// 消消乐卡片
export interface MatchCard {
  id: string
  content: string
  type: 'word' | 'meaning'
  pairId: string
  isFlipped: boolean
  isMatched: boolean
}

// 消消乐游戏状态
export interface MatchGameState {
  cards: MatchCard[]
  flippedCards: string[]
  matchedPairs: number
  totalPairs: number
  score: number
  combo: number
  timeLeft: number
  gameStatus: GameState
}

// 用户游戏记录
export interface UserGameRecord {
  id: string
  userId: string
  gameType: GameType
  score: number
  combo: number
  playedAt: Date
}

// 游戏机会
export interface GameTicket {
  gameType: GameType
  count: number
  lastEarnedAt: Date | null
}

// 游戏奖励
export interface GameReward {
  xp: number
  tickets?: Partial<Record<GameType, number>>
  badges?: string[]
}