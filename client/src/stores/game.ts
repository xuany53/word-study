import { defineStore } from 'pinia'
import type { GameType, UserGameRecord, GameTicket, GameReward } from '@/types/game'

interface GameState {
  tickets: Record<GameType, number>
  records: UserGameRecord[]
  loading: boolean
  error: string | null
}

export const useGameStore = defineStore('game', {
  state: (): GameState => ({
    tickets: {
      snake: 3,
      match: 3,
      adventure: 0,
      farm: 0
    },
    records: [],
    loading: false,
    error: null
  }),

  getters: {
    hasTicket: (state) => (gameType: GameType) => state.tickets[gameType] > 0,
    totalTickets: (state) => Object.values(state.tickets).reduce((sum, t) => sum + t, 0)
  },

  actions: {
    // 使用游戏机会
    useTicket(gameType: GameType): boolean {
      if (this.tickets[gameType] <= 0) return false

      this.tickets[gameType]--
      this.saveTickets()
      return true
    },

    // 添加游戏机会
    addTickets(gameType: GameType, count: number = 1) {
      this.tickets[gameType] += count
      this.saveTickets()
    },

    // 从 localStorage 加载
    loadTickets() {
      const saved = localStorage.getItem('gameTickets')
      if (saved) {
        const data = JSON.parse(saved)
        const today = new Date().toDateString()

        if (data.date === today) {
          this.tickets = data.tickets || this.tickets
        } else {
          // 新的一天，重置
          this.resetTickets()
        }
      }
    },

    // 保存到 localStorage
    saveTickets() {
      localStorage.setItem('gameTickets', JSON.stringify({
        date: new Date().toDateString(),
        tickets: this.tickets
      }))
    },

    // 重置机会
    resetTickets() {
      this.tickets = {
        snake: 3,
        match: 3,
        adventure: 0,
        farm: 0
      }
      this.saveTickets()
    },

    // 记录游戏结果
    addGameRecord(record: Omit<UserGameRecord, 'id'>) {
      const newRecord: UserGameRecord = {
        ...record,
        id: `game-${Date.now()}`
      }
      this.records.push(newRecord)
    },

    // 获取今日游戏记录
    getTodayRecords(): UserGameRecord[] {
      const today = new Date().toDateString()
      return this.records.filter(r =>
        new Date(r.playedAt).toDateString() === today
      )
    },

    // 计算游戏奖励
    calculateReward(gameType: GameType, score: number, combo: number): GameReward {
      const baseXP = Math.floor(score / 2)

      return {
        xp: baseXP,
        tickets: combo >= 10 ? { snake: 1 } : undefined
      }
    }
  }
})