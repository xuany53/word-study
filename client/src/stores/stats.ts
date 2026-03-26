import { defineStore } from 'pinia'
import { statsApi } from '@/services/api'
import type { UserStats, DailyStats } from '@/types/stats'

interface StatsState {
  userStats: UserStats | null
  dailyStats: DailyStats | null
  checkInCalendar: Date[]
  loading: boolean
  error: string | null
}

export const useStatsStore = defineStore('stats', {
  state: (): StatsState => ({
    userStats: null,
    dailyStats: null,
    checkInCalendar: [],
    loading: false,
    error: null
  }),

  getters: {
    streak: (state) => state.userStats?.streak || 0,
    totalWords: (state) => state.userStats?.totalWords || 0,
    masteredWords: (state) => state.userStats?.masteredWords || 0,
    correctRate: (state) => state.userStats?.correctRate || 0
  },

  actions: {
    async fetchStats() {
      this.loading = true
      this.error = null
      try {
        const response = await statsApi.getStats()
        if (response.success && response.data) {
          this.userStats = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取统计数据失败'
      } finally {
        this.loading = false
      }
    },

    async fetchDailyStats() {
      this.loading = true
      try {
        const response = await statsApi.getDailyStats()
        if (response.success && response.data) {
          this.dailyStats = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取每日统计失败'
      } finally {
        this.loading = false
      }
    },

    async checkIn() {
      this.loading = true
      this.error = null
      try {
        const response = await statsApi.checkIn()
        if (response.success && response.data && this.userStats) {
          this.userStats.streak = response.data.streak
          this.userStats.longestStreak = response.data.longestStreak
        }
        return response
      } catch (error: any) {
        this.error = error.message || '打卡失败'
        throw error
      } finally {
        this.loading = false
      }
    },

    async fetchCheckInCalendar() {
      this.loading = true
      try {
        const response = await statsApi.getCheckInCalendar()
        if (response.success && response.data) {
          this.checkInCalendar = response.data.map((item: any) => new Date(item.date))
        }
      } catch (error: any) {
        this.error = error.message || '获取打卡日历失败'
      } finally {
        this.loading = false
      }
    }
  }
})