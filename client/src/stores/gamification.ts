import { defineStore } from 'pinia'
import { badgeApi } from '@/services/api'
import type { Badge } from '@/types/gamification'

interface GamificationState {
  badges: Badge[]
  unlockedBadges: Badge[]
  userLevel: {
    currentLevel: number
    currentTitle: string
    xp: number
    xpToNext: number
    levelProgress: number
  } | null
  loading: boolean
  error: string | null
}

export const useGamificationStore = defineStore('gamification', {
  state: (): GamificationState => ({
    badges: [],
    unlockedBadges: [],
    userLevel: null,
    loading: false,
    error: null
  }),

  getters: {
    lockedBadges: (state) => state.badges.filter(b => !b.isUnlocked),
    hasUnlockedBadge: (state) => (badgeId: string) => {
      return state.unlockedBadges.some(b => b.id === badgeId)
    }
  },

  actions: {
    async fetchAllBadges() {
      this.loading = true
      this.error = null
      try {
        const response = await badgeApi.getAll()
        if (response.success && response.data) {
          this.badges = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取徽章列表失败'
      } finally {
        this.loading = false
      }
    },

    async fetchUnlockedBadges() {
      this.loading = true
      try {
        const response = await badgeApi.getUnlocked()
        if (response.success && response.data) {
          this.unlockedBadges = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取已解锁徽章失败'
      } finally {
        this.loading = false
      }
    },

    async checkBadges() {
      this.loading = true
      try {
        const response = await badgeApi.check()
        if (response.success && response.data) {
          // 更新已解锁的徽章
          const newBadges = response.data
          for (const badge of newBadges) {
            if (!this.unlockedBadges.some(b => b.id === badge.id)) {
              this.unlockedBadges.push(badge)
            }
          }
        }
        return response
      } catch (error: any) {
        this.error = error.message || '检查徽章失败'
        throw error
      } finally {
        this.loading = false
      }
    },

    setUserLevel(level: { currentLevel: number; currentTitle: string; xp: number; xpToNext: number; levelProgress: number }) {
      this.userLevel = level
    }
  }
})