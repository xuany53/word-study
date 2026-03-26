import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { User } from '../entities/User'
import { LearningRecord } from '../entities/LearningRecord'

export class StatsController {
  private userRepository = AppDataSource.getRepository(User)
  private learningRepository = AppDataSource.getRepository(LearningRecord)

  getStats = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const user = await this.userRepository.findOne({ where: { id: userId } })

      if (!user) {
        res.status(404).json({
          success: false,
          message: 'User not found'
        })
        return
      }

      const records = await this.learningRepository.find({ where: { userId } })
      const masteredCount = records.filter(r => r.status === 'mastered').length
      const totalCorrect = records.reduce((sum, r) => sum + r.correctCount, 0)
      const totalWrong = records.reduce((sum, r) => sum + r.wrongCount, 0)
      const correctRate = totalCorrect + totalWrong > 0
        ? (totalCorrect / (totalCorrect + totalWrong)) * 100
        : 0

      res.json({
        success: true,
        data: {
          level: user.level,
          xp: user.xp,
          streak: user.streak,
          longestStreak: user.longestStreak,
          totalWords: records.length,
          masteredWords: masteredCount,
          correctRate: Math.round(correctRate * 10) / 10
        }
      })
    } catch (error) {
      console.error('Get stats error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  getDailyStats = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const today = new Date()
      today.setHours(0, 0, 0, 0)
      const tomorrow = new Date(today)
      tomorrow.setDate(tomorrow.getDate() + 1)

      // Get today's learning records
      const todayRecords = await this.learningRepository
        .createQueryBuilder('record')
        .where('record.userId = :userId', { userId })
        .andWhere('record.lastReviewAt >= :today', { today })
        .andWhere('record.lastReviewAt < :tomorrow', { tomorrow })
        .getMany()

      const newWordsCount = todayRecords.filter(r => r.correctCount + r.wrongCount === 1).length
      const reviewWordsCount = todayRecords.filter(r => r.correctCount + r.wrongCount > 1).length
      const correctCount = todayRecords.reduce((sum, r) => {
        // Only count today's correct answers
        return sum + (r.correctCount > 0 ? 1 : 0)
      }, 0)
      const wrongCount = todayRecords.reduce((sum, r) => {
        return sum + (r.wrongCount > 0 ? 1 : 0)
      }, 0)
      const totalAnswers = correctCount + wrongCount
      const correctRate = totalAnswers > 0 ? (correctCount / totalAnswers) * 100 : 0

      res.json({
        success: true,
        data: {
          newWordsCount,
          reviewWordsCount,
          correctCount,
          wrongCount,
          correctRate: Math.round(correctRate * 10) / 10
        }
      })
    } catch (error) {
      console.error('Get daily stats error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  checkIn = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const user = await this.userRepository.findOne({ where: { id: userId } })

      if (!user) {
        res.status(404).json({
          success: false,
          message: 'User not found'
        })
        return
      }

      const today = new Date()
      today.setHours(0, 0, 0, 0)

      if (user.lastCheckIn) {
        const lastCheckIn = new Date(user.lastCheckIn)
        lastCheckIn.setHours(0, 0, 0, 0)

        if (lastCheckIn.getTime() === today.getTime()) {
          res.status(400).json({
            success: false,
            message: 'Already checked in today'
          })
          return
        }

        // 检查是否连续
        const yesterday = new Date(today)
        yesterday.setDate(yesterday.getDate() - 1)

        if (lastCheckIn.getTime() === yesterday.getTime()) {
          // 连续打卡
          user.streak++
          if (user.streak > user.longestStreak) {
            user.longestStreak = user.streak
          }
        } else {
          // 中断
          user.streak = 1
        }
      } else {
        user.streak = 1
      }

      user.lastCheckIn = new Date()
      await this.userRepository.save(user)

      res.json({
        success: true,
        data: {
          streak: user.streak,
          longestStreak: user.longestStreak,
          xpGained: 50
        }
      })
    } catch (error) {
      console.error('Check in error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  getCheckInCalendar = async (req: Request, res: Response): Promise<void> => {
    // TODO: 实现获取打卡日历
    res.json({ success: true, data: [] })
  }
}