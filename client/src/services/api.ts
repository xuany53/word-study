import axios, { AxiosInstance, AxiosRequestConfig, AxiosResponse } from 'axios'
import { useAuthStore } from '@/stores/auth'

// API 响应类型
export interface ApiResponse<T = unknown> {
  success: boolean
  data?: T
  message?: string
}

// 创建 axios 实例
const api: AxiosInstance = axios.create({
  baseURL: '/api',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json'
  }
})

// 请求拦截器 - 添加 token
api.interceptors.request.use(
  (config: AxiosRequestConfig) => {
    const token = localStorage.getItem('token')
    if (token && config.headers) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// 响应拦截器 - 处理错误
api.interceptors.response.use(
  (response: AxiosResponse) => {
    return response.data
  },
  (error) => {
    if (error.response?.status === 401) {
      // Token 过期，清除登录状态
      localStorage.removeItem('token')
      const authStore = useAuthStore()
      authStore.logout()
      window.location.href = '/login'
    }
    return Promise.reject(error.response?.data || error)
  }
)

// 认证 API
export const authApi = {
  register: (data: { username: string; email: string; password: string }) =>
    api.post<any, ApiResponse<{ user: any; token: string }>>('/auth/register', data),

  login: (data: { email: string; password: string }) =>
    api.post<any, ApiResponse<{ user: any; token: string }>>('/auth/login', data),

  getProfile: () =>
    api.get<any, ApiResponse<any>>('/auth/me'),

  updateProfile: (data: Partial<any>) =>
    api.put<any, ApiResponse<void>>('/auth/me', data),

  changePassword: (data: { oldPassword: string; newPassword: string }) =>
    api.put<any, ApiResponse<void>>('/auth/password', data)
}

// 单词 API
export const wordApi = {
  getAll: (params?: { page?: number; limit?: number; category?: string; difficulty?: number }) =>
    api.get<any, ApiResponse<{ data: any[]; pagination: any }>>('/words', { params }),

  getById: (id: string) =>
    api.get<any, ApiResponse<any>>(`/words/${id}`),

  getByCategory: (category: string) =>
    api.get<any, ApiResponse<any[]>>(`/words/category/${category}`)
}

// 学习 API
export const learningApi = {
  getTodayWords: (category?: string) =>
    api.get<any, ApiResponse<{ reviewWords: number; newWords: number; reviewRecords: any[]; newWords: any[] }>>('/learning/today', { params: category && category !== 'all' ? { category } : {} }),

  startSession: () =>
    api.post<any, ApiResponse<any>>('/learning/start'),

  submitAnswer: (data: { wordId: string; isCorrect: boolean }) =>
    api.post<any, ApiResponse<{ masteryLevel: number; xpGain: number; nextReviewAt: Date }>>('/learning/answer', data),

  getRecords: () =>
    api.get<any, ApiResponse<any[]>>('/learning/records'),

  updateRecord: (wordId: string, data: Partial<any>) =>
    api.put<any, ApiResponse<void>>(`/learning/record/${wordId}`, data)
}

// 统计 API
export const statsApi = {
  getStats: () =>
    api.get<any, ApiResponse<any>>('/stats'),

  getDailyStats: () =>
    api.get<any, ApiResponse<any>>('/stats/daily'),

  checkIn: () =>
    api.post<any, ApiResponse<{ streak: number; longestStreak: number; xpGained: number }>>('/stats/checkin'),

  getCheckInCalendar: () =>
    api.get<any, ApiResponse<any[]>>('/stats/calendar')
}

// 闯关 API
export const challengeApi = {
  getAllLevels: () =>
    api.get<any, ApiResponse<any[]>>('/challenge/levels'),

  getLevelById: (id: string) =>
    api.get<any, ApiResponse<any>>(`/challenge/levels/${id}`),

  startChallenge: (levelId: string, category?: string) =>
    api.post<any, ApiResponse<any>>(`/challenge/start/${levelId}`, {}, { params: category && category !== 'all' ? { category } : {} }),

  submitAnswer: (data: { sessionId: string; wordId: string; isCorrect: boolean }) =>
    api.post<any, ApiResponse<any>>('/challenge/answer', data),

  finishChallenge: (data: { sessionId: string }) =>
    api.post<any, ApiResponse<any>>('/challenge/finish', data),

  getResults: () =>
    api.get<any, ApiResponse<any[]>>('/challenge/results')
}

// 徽章 API
export const badgeApi = {
  getAll: () =>
    api.get<any, ApiResponse<any[]>>('/badges'),

  getUnlocked: () =>
    api.get<any, ApiResponse<any[]>>('/badges/unlocked'),

  check: () =>
    api.post<any, ApiResponse<any[]>>('/badges/check')
}

export default api