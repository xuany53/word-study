import { defineStore } from 'pinia'
import type { AdventureLocation, UserAdventureProgress, LocationWithStatus } from '@/types/adventure'
import { adventureLocations, getCurrentLocationForDays } from '@/data/adventureLocations'
import { getThemeForLocation } from '@/data/wordThemes'

interface AdventureState {
  progress: UserAdventureProgress | null
  locations: AdventureLocation[]
  unlockedThemes: string[]  // 已解锁的主题ID列表
  loading: boolean
}

export const useAdventureStore = defineStore('adventure', {
  state: (): AdventureState => ({
    progress: null,
    locations: adventureLocations,
    unlockedThemes: [],
    loading: false
  }),

  getters: {
    // 获取当前位置
    currentLocation: (state): AdventureLocation | undefined => {
      if (!state.progress) return state.locations[0]
      return state.locations.find(l => l.id === state.progress!.currentLocationId)
    },

    // 获取所有地点及其状态
    locationsWithStatus: (state): LocationWithStatus[] => {
      if (!state.progress) {
        return state.locations.map((l, i) => ({
          ...l,
          status: i === 0 ? 'current' : 'locked' as const,
          progress: i === 0 ? 0 : 0
        }))
      }

      return state.locations.map(location => {
        const isCompleted = state.progress!.completedLocations.includes(location.id)
        const isCurrent = state.progress!.currentLocationId === location.id

        let status: 'locked' | 'current' | 'completed' = 'locked'
        if (isCompleted) status = 'completed'
        else if (isCurrent) status = 'current'

        // 计算进度
        let progress = 0
        if (status === 'completed') {
          progress = 100
        } else if (status === 'current') {
          const prevLocation = state.locations.find(l => l.daysRequired < location.daysRequired)
          const prevDays = prevLocation?.daysRequired || 0
          const targetDays = location.daysRequired
          const currentDays = state.progress.totalSteps

          if (targetDays > prevDays) {
            progress = Math.min(100, Math.round(((currentDays - prevDays) / (targetDays - prevDays)) * 100))
          }
        }

        return {
          ...location,
          status,
          progress
        }
      })
    },

    // 总进度百分比
    totalProgress: (state): number => {
      if (!state.progress) return 0
      const completed = state.progress.completedLocations.length
      const total = state.locations.length
      return Math.round((completed / total) * 100)
    },

    // 下一个目标地点
    nextTargetLocation: (state): AdventureLocation | undefined => {
      if (!state.progress) return state.locations[0]

      const currentIndex = state.locations.findIndex(l => l.id === state.progress!.currentLocationId)
      if (currentIndex >= state.locations.length - 1) return undefined
      return state.locations[currentIndex + 1]
    }
  },

  actions: {
    // 初始化进度
    initProgress(streak: number) {
      const currentLocation = getCurrentLocationForDays(streak)

      this.progress = {
        currentLocationId: currentLocation.id,
        totalSteps: streak,
        currentStepInLocation: streak,
        completedLocations: [],
        startedAt: new Date(),
        lastCheckInAt: null
      }

      // 标记已完成的地点，并解锁对应主题
      for (const location of this.locations) {
        if (location.daysRequired <= streak && location.id !== currentLocation.id) {
          this.progress.completedLocations.push(location.id)
          // 解锁主题
          this.unlockThemeForLocation(location.id)
        }
      }

      // 解锁当前位置主题
      this.unlockThemeForLocation(currentLocation.id)

      this.saveProgress()
    },

    // 打卡前进一步
    checkIn(): { location: AdventureLocation; isNewLocation: boolean; unlockedTheme?: string } | null {
      if (!this.progress) return null

      this.progress.totalSteps++
      this.progress.lastCheckInAt = new Date()

      const prevLocation = this.currentLocation
      const newLocation = getCurrentLocationForDays(this.progress.totalSteps)

      const isNewLocation = newLocation.id !== prevLocation?.id
      let unlockedTheme: string | undefined

      if (isNewLocation) {
        this.progress.completedLocations.push(prevLocation!.id)
        this.progress.currentLocationId = newLocation.id
        this.progress.currentStepInLocation = this.progress.totalSteps

        // 解锁新主题
        const theme = this.unlockThemeForLocation(newLocation.id)
        if (theme) {
          unlockedTheme = theme.name
        }
      }

      this.saveProgress()

      return {
        location: newLocation,
        isNewLocation,
        unlockedTheme
      }
    },

    // 解锁地点对应的主题
    unlockThemeForLocation(locationId: string) {
      const theme = getThemeForLocation(locationId)
      if (theme && !this.unlockedThemes.includes(theme.id)) {
        this.unlockedThemes.push(theme.id)
        this.saveUnlockedThemes()
        return theme
      }
      return null
    },

    // 保存已解锁主题
    saveUnlockedThemes() {
      localStorage.setItem('unlockedThemes', JSON.stringify(this.unlockedThemes))
    },

    // 加载已解锁主题
    loadUnlockedThemes() {
      const saved = localStorage.getItem('unlockedThemes')
      if (saved) {
        this.unlockedThemes = JSON.parse(saved)
      }
    },

    // 保存进度
    saveProgress() {
      if (this.progress) {
        localStorage.setItem('adventureProgress', JSON.stringify(this.progress))
      }
    },

    // 加载进度
    loadProgress() {
      const saved = localStorage.getItem('adventureProgress')
      if (saved) {
        this.progress = JSON.parse(saved)
      }
    }
  }
})