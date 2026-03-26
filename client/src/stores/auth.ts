import { defineStore } from 'pinia'
import { authApi } from '@/services/api'

interface User {
  id: string
  username: string
  email: string
  level: number
  xp: number
  streak: number
  longestStreak: number
}

interface AuthState {
  user: User | null
  token: string | null
  isAuthenticated: boolean
  loading: boolean
  error: string | null
}

export const useAuthStore = defineStore('auth', {
  state: (): AuthState => ({
    user: null,
    token: localStorage.getItem('token'),
    isAuthenticated: !!localStorage.getItem('token'),
    loading: false,
    error: null
  }),

  getters: {
    getUser: (state) => state.user,
    isLoggedIn: (state) => state.isAuthenticated
  },

  actions: {
    async login(email: string, password: string) {
      this.loading = true
      this.error = null
      try {
        const response = await authApi.login({ email, password })
        if (response.success && response.data) {
          this.token = response.data.token
          this.user = response.data.user
          this.isAuthenticated = true
          localStorage.setItem('token', response.data.token)
        }
        return response
      } catch (error: any) {
        this.error = error.message || '登录失败'
        throw error
      } finally {
        this.loading = false
      }
    },

    async register(username: string, email: string, password: string) {
      this.loading = true
      this.error = null
      try {
        const response = await authApi.register({ username, email, password })
        if (response.success && response.data) {
          this.token = response.data.token
          this.user = response.data.user
          this.isAuthenticated = true
          localStorage.setItem('token', response.data.token)
        }
        return response
      } catch (error: any) {
        this.error = error.message || '注册失败'
        throw error
      } finally {
        this.loading = false
      }
    },

    async fetchProfile() {
      if (!this.token) return
      this.loading = true
      try {
        const response = await authApi.getProfile()
        if (response.success && response.data) {
          this.user = response.data
        }
      } catch (error) {
        this.logout()
      } finally {
        this.loading = false
      }
    },

    logout() {
      this.user = null
      this.token = null
      this.isAuthenticated = false
      localStorage.removeItem('token')
    }
  }
})