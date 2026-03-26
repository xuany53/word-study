import { defineStore } from 'pinia'
import { learningApi } from '@/services/api'
import type { Word } from '@/types/word'
import type { LearningRecord, LearningMode } from '@/types/learning'

interface LearningState {
  todayWords: {
    reviewWords: number
    newWords: number
    reviewRecords: LearningRecord[]
    newWordList: Word[]
  }
  currentSession: {
    words: Word[]
    currentIndex: number
    correctCount: number
    wrongCount: number
    startTime: Date | null
    mode: LearningMode
  } | null
  records: LearningRecord[]
  loading: boolean
  error: string | null
}

export const useLearningStore = defineStore('learning', {
  state: (): LearningState => ({
    todayWords: {
      reviewWords: 0,
      newWords: 0,
      reviewRecords: [],
      newWordList: []
    },
    currentSession: null,
    records: [],
    loading: false,
    error: null
  }),

  getters: {
    currentWord: (state) => {
      if (!state.currentSession) return null
      return state.currentSession.words[state.currentSession.currentIndex]
    },
    progress: (state) => {
      if (!state.currentSession) return 0
      const total = state.currentSession.words.length
      const current = state.currentSession.currentIndex + 1
      return Math.round((current / total) * 100)
    },
    isSessionComplete: (state) => {
      if (!state.currentSession) return false
      return state.currentSession.currentIndex >= state.currentSession.words.length - 1
    }
  },

  actions: {
    async fetchTodayWords(category?: string) {
      this.loading = true
      this.error = null
      try {
        const response = await learningApi.getTodayWords(category)
        if (response.success && response.data) {
          const data = response.data as any
          this.todayWords = {
            reviewWords: data.reviewWords || 0,
            newWords: data.newWords || 0,
            reviewRecords: data.reviewRecords || [],
            newWordList: data.newWordList || []
          }
        }
      } catch (error: any) {
        this.error = error.message || '获取今日单词失败'
      } finally {
        this.loading = false
      }
    },

    startSession(words: Word[], mode: LearningMode) {
      this.currentSession = {
        words,
        currentIndex: 0,
        correctCount: 0,
        wrongCount: 0,
        startTime: new Date(),
        mode
      }
    },

    async submitAnswer(wordId: string, isCorrect: boolean) {
      if (!this.currentSession) return

      try {
        const response = await learningApi.submitAnswer({ wordId, isCorrect })
        if (response.success) {
          if (isCorrect) {
            this.currentSession.correctCount++
          } else {
            this.currentSession.wrongCount++
          }
        }
        return response
      } catch (error: any) {
        this.error = error.message || '提交答案失败'
        throw error
      }
    },

    nextWord() {
      if (!this.currentSession) return
      if (this.currentSession.currentIndex < this.currentSession.words.length - 1) {
        this.currentSession.currentIndex++
      }
    },

    endSession() {
      this.currentSession = null
    },

    async fetchRecords() {
      this.loading = true
      try {
        const response = await learningApi.getRecords()
        if (response.success && response.data) {
          this.records = response.data
        }
      } catch (error: any) {
        this.error = error.message || '获取学习记录失败'
      } finally {
        this.loading = false
      }
    }
  }
})