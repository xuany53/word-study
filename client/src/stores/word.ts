import { defineStore } from 'pinia'
import { wordApi } from '@/services/api'
import type { Word } from '@/types/word'

interface WordState {
  words: Word[]
  currentWord: Word | null
  loading: boolean
  error: string | null
  total: number
  page: number
  limit: number
}

export const useWordStore = defineStore('word', {
  state: (): WordState => ({
    words: [],
    currentWord: null,
    loading: false,
    error: null,
    total: 0,
    page: 1,
    limit: 50
  }),

  getters: {
    hasNextPage: (state) => state.page * state.limit < state.total
  },

  actions: {
    async fetchWords(page = 1, category?: string, filters?: { source?: string; razLevel?: string; gradeLevel?: string }) {
      this.loading = true
      this.error = null
      try {
        const params: any = { page, limit: this.limit }
        if (category) params.category = category
        if (filters?.source) params.source = filters.source
        if (filters?.razLevel) params.razLevel = filters.razLevel
        if (filters?.gradeLevel) params.gradeLevel = filters.gradeLevel

        const response = await wordApi.getAll(params)
        if (response.success && response.data) {
          // API returns { success, data: Word[], pagination }
          // The axios interceptor already extracts response.data
          const data = response.data as any
          if (Array.isArray(data)) {
            // Direct array response
            this.words = data
          } else if (data.data && Array.isArray(data.data)) {
            // Nested data structure
            this.words = data.data
            this.total = data.pagination?.total || data.data.length
          } else {
            this.words = []
          }
          this.page = page
        }
      } catch (error: any) {
        this.error = error.message || '获取单词列表失败'
      } finally {
        this.loading = false
      }
    },

    async fetchWordById(id: string) {
      this.loading = true
      try {
        const response = await wordApi.getById(id)
        if (response.success && response.data) {
          this.currentWord = response.data
        }
        return response.data
      } catch (error: any) {
        this.error = error.message || '获取单词详情失败'
        throw error
      } finally {
        this.loading = false
      }
    },

    setCurrentWord(word: Word | null) {
      this.currentWord = word
    }
  }
})