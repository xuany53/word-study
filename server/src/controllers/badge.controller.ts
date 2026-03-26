import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { Badge } from '../entities/Badge'
import { UserBadge } from '../entities/UserBadge'
import { User } from '../entities/User'
import { LearningRecord } from '../entities/LearningRecord'
import { ChallengeResult } from '../entities/ChallengeResult'

export class BadgeController {
  private badgeRepository = AppDataSource.getRepository(Badge)
  private userBadgeRepository = AppDataSource.getRepository(UserBadge)
  private userRepository = AppDataSource.getRepository(User)
  private learningRepository = AppDataSource.getRepository(LearningRecord)
  private challengeRepository = AppDataSource.getRepository(ChallengeResult)

  getAllBadges = async (req: Request, res: Response): Promise<void> => {
    try {
      const badges = await this.badgeRepository.find({
        order: { rarity: 'ASC', createdAt: 'ASC' }
      })

      res.json({
        success: true,
        data: badges
      })
    } catch (error) {
      console.error('Get all badges error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  getUnlockedBadges = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId

      const userBadges = await this.userBadgeRepository.find({
        where: { userId },
        relations: ['badge'],
        order: { unlockedAt: 'DESC' }
      })

      const badges = userBadges.map(ub => ({
        ...ub.badge,
        isUnlocked: true,
        unlockedAt: ub.unlockedAt
      }))

      res.json({
        success: true,
        data: badges
      })
    } catch (error) {
      console.error('Get unlocked badges error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  checkBadges = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId

      // Get user stats
      const user = await this.userRepository.findOne({ where: { id: userId } })
      if (!user) {
        res.status(404).json({ success: false, message: 'User not found' })
        return
      }

      // Get learning records
      const records = await this.learningRepository.find({ where: { userId } })
      const masteredCount = records.filter(r => r.status === 'mastered').length
      const totalWords = records.length
      const totalCorrect = records.reduce((sum, r) => sum + r.correctCount, 0)
      const totalWrong = records.reduce((sum, r) => sum + r.wrongCount, 0)
      const correctRate = totalCorrect + totalWrong > 0
        ? (totalCorrect / (totalCorrect + totalWrong)) * 100
        : 0

      // Get challenge results
      const challengeResults = await this.challengeRepository.find({ where: { userId } })
      const completedLevels = challengeResults.filter(r => r.isPassed).length
      const perfectScores = challengeResults.filter(r => r.starRating === 3).length

      // Get all badges
      const allBadges = await this.badgeRepository.find()

      // Get already unlocked badges
      const unlockedUserBadges = await this.userBadgeRepository.find({ where: { userId } })
      const unlockedBadgeIds = unlockedUserBadges.map(ub => ub.badgeId)

      // Check each badge
      const newlyUnlocked: Badge[] = []

      for (const badge of allBadges) {
        if (unlockedBadgeIds.includes(badge.id)) continue

        const condition = badge.unlockCondition as any
        let shouldUnlock = false

        switch (condition.type) {
          case 'streak':
            shouldUnlock = user.streak >= condition.value
            break
          case 'words_learned':
            shouldUnlock = totalWords >= condition.value
            break
          case 'words_mastered':
            shouldUnlock = masteredCount >= condition.value
            break
          case 'accuracy':
            shouldUnlock = correctRate >= condition.value
            break
          case 'level':
            shouldUnlock = user.level >= condition.value
            break
          case 'challenge_complete':
            shouldUnlock = completedLevels >= condition.value
            break
          case 'perfect_score':
            shouldUnlock = perfectScores >= condition.value
            break
        }

        if (shouldUnlock) {
          // Create user badge
          const userBadge = this.userBadgeRepository.create({
            userId,
            badgeId: badge.id,
            unlockedAt: new Date()
          })
          await this.userBadgeRepository.save(userBadge)
          newlyUnlocked.push(badge)
        }
      }

      res.json({
        success: true,
        data: newlyUnlocked
      })
    } catch (error) {
      console.error('Check badges error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  // Get all badges with unlock status for current user
  getBadgesWithStatus = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId

      const badges = await this.badgeRepository.find({
        order: { rarity: 'ASC', createdAt: 'ASC' }
      })

      const userBadges = await this.userBadgeRepository.find({
        where: { userId }
      })

      const unlockedMap = new Map(
        userBadges.map(ub => [ub.badgeId, ub.unlockedAt])
      )

      const badgesWithStatus = badges.map(badge => ({
        ...badge,
        isUnlocked: unlockedMap.has(badge.id),
        unlockedAt: unlockedMap.get(badge.id) || null
      }))

      res.json({
        success: true,
        data: badgesWithStatus
      })
    } catch (error) {
      console.error('Get badges with status error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }
}