import { defineStore } from 'pinia'
import { challengeApi } from '@/services/api'
import type { ChallengeLevel, ChallengeSession, ChallengeResult } from '@/types/challenge'

interface ChallengeState {
  levels: ChallengeLevel[]
  currentSession: ChallengeSession | null
  results: ChallengeResult[]
  loading: boolean
  error: string | null
}

export const useChallengeStore = defineStore('challenge', {
  state: (): ChallengeState => ({
    levels: [],
    currentSession: null,
    results: [],
    loading: false,
    error: null
  }),

  getters: {
    unlockedLevels: (state) => state.levels.filter(l => l.isUnlocked),
    currentLevel: (state) => {
      if (!state.currentSession) return null
      return state.levels.find(l => l.id === state.currentSession?.levelId)
    }
  },

  actions: {
    async fetchLevels() {
      this.loading = true
      this.error = null
      try {
        const response = await challengeApi.getAllLevels()
        if (response.success && response.data) {
          this.levels = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取关卡列表失败'
      } finally {
        this.loading = false
      }
    },

    async startChallenge(levelId: string, category?: string) {
      this.loading = true
      this.error = null
      try {
        const response = await challengeApi.startChallenge(levelId, category)
        if (response.success && response.data) {
          this.currentSession = response.data
        }
        return response
      } catch (error: any) {
        this.error = error.message || '开始闯关失败'
        throw error
      } finally {
        this.loading = false
      }
    },

    async submitAnswer(wordId: string, isCorrect: boolean) {
      if (!this.currentSession) return
      try {
        // Handle both 'id' and 'sessionId' field names
        const sessionId = (this.currentSession as any).sessionId || (this.currentSession as any).id
        const response = await challengeApi.submitAnswer({
          sessionId,
          wordId,
          isCorrect
        })
        if (response.success) {
          if (isCorrect) {
            this.currentSession.correctCount++
          } else {
            this.currentSession.wrongCount++
          }
          this.currentSession.currentIndex++
        }
        return response
      } catch (error: any) {
        this.error = error.message || '提交答案失败'
        throw error
      }
    },

    async finishChallenge() {
      if (!this.currentSession) return
      this.loading = true
      try {
        // Handle both 'id' and 'sessionId' field names
        const sessionId = (this.currentSession as any).sessionId || (this.currentSession as any).id
        const response = await challengeApi.finishChallenge({ sessionId })
        if (response.success && response.data) {
          this.results.push(response.data)
        }
        return response
      } catch (error: any) {
        this.error = error.message || '结束闯关失败'
        throw error
      } finally {
        this.loading = false
        this.currentSession = null
      }
    },

    async fetchResults() {
      this.loading = true
      try {
        const response = await challengeApi.getResults()
        if (response.success && response.data) {
          this.results = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取闯关结果失败'
      } finally {
        this.loading = false
      }
    }
  }
})