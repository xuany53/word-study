import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { ChallengeLevel } from '../entities/ChallengeLevel'
import { ChallengeResult } from '../entities/ChallengeResult'
import { Word } from '../entities/Word'
import { User } from '../entities/User'

// In-memory challenge sessions (in production, use Redis)
const challengeSessions = new Map<string, ChallengeSession>()

interface ChallengeSession {
  id: string
  userId: string
  levelId: string
  words: Word[]
  currentIndex: number
  correctCount: number
  wrongCount: number
  startTime: Date
  timeLimit: number | null
  maxErrors: number
}

export class ChallengeController {
  private levelRepository = AppDataSource.getRepository(ChallengeLevel)
  private resultRepository = AppDataSource.getRepository(ChallengeResult)
  private wordRepository = AppDataSource.getRepository(Word)
  private userRepository = AppDataSource.getRepository(User)

  /**
   * Get all challenge levels with user's progress
   */
  getAllLevels = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId

      // Get all levels
      const levels = await this.levelRepository.find({
        order: { difficulty: 'ASC', createdAt: 'ASC' }
      })

      // Get user's results for each level
      const results = await this.resultRepository.find({
        where: { userId },
        order: { completedAt: 'DESC' }
      })

      // Create a map of levelId -> best result
      const bestResults = new Map<string, ChallengeResult>()
      for (const result of results) {
        const existing = bestResults.get(result.levelId)
        if (!existing || result.starRating > existing.starRating) {
          bestResults.set(result.levelId, result)
        }
      }

      // Create a set of passed level IDs
      const passedLevelIds = new Set<string>()
      for (const result of results) {
        if (result.isPassed) {
          passedLevelIds.add(result.levelId)
        }
      }

      // Build levels with status
      const levelsWithStatus = levels.map((level, index) => {
        const bestResult = bestResults.get(level.id)
        // Unlock: first level always unlocked, or prerequisite level has been passed
        const isUnlocked = index === 0 ||
          !level.prerequisiteLevelId ||
          passedLevelIds.has(level.prerequisiteLevelId)

        return {
          ...level,
          isUnlocked,
          starRating: bestResult?.starRating || 0,
          bestTime: bestResult?.timeTaken || null,
          isPassed: bestResult?.isPassed || false
        }
      })

      res.json({
        success: true,
        data: levelsWithStatus
      })
    } catch (error) {
      console.error('Get all levels error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  /**
   * Get level by ID with details
   */
  getLevelById = async (req: Request, res: Response): Promise<void> => {
    try {
      const { id } = req.params
      const userId = (req as any).userId

      const level = await this.levelRepository.findOne({
        where: { id }
      })

      if (!level) {
        res.status(404).json({
          success: false,
          message: 'Level not found'
        })
        return
      }

      // Get user's best result for this level
      const bestResult = await this.resultRepository.findOne({
        where: { userId, levelId: id },
        order: { starRating: 'DESC' }
      })

      res.json({
        success: true,
        data: {
          ...level,
          starRating: bestResult?.starRating || 0,
          bestTime: bestResult?.timeTaken || null,
          isPassed: bestResult?.isPassed || false
        }
      })
    } catch (error) {
      console.error('Get level by id error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  /**
   * Start a challenge session
   */
  startChallenge = async (req: Request, res: Response): Promise<void> => {
    try {
      const { levelId } = req.params
      const userId = (req as any).userId
      const { category } = req.query // 获取 RAZ 级别过滤

      // Get level
      const level = await this.levelRepository.findOne({
        where: { id: levelId }
      })

      if (!level) {
        res.status(404).json({
          success: false,
          message: 'Level not found'
        })
        return
      }

      // Check if level is unlocked
      if (level.prerequisiteLevelId) {
        const prerequisiteResult = await this.resultRepository.findOne({
          where: { userId, levelId: level.prerequisiteLevelId, isPassed: true }
        })

        if (!prerequisiteResult) {
          res.status(403).json({
            success: false,
            message: 'Complete the prerequisite level first'
          })
          return
        }
      }

      // Get random words for the challenge with optional category filter
      let wordsQuery = this.wordRepository.createQueryBuilder('word')
      if (category && category !== 'all') {
        wordsQuery = wordsQuery.where('word.category = :category', { category })
      }
      const words = await wordsQuery
        .orderBy('RAND()')
        .take(level.wordCount)
        .getMany()

      if (words.length < level.wordCount) {
        res.status(400).json({
          success: false,
          message: 'Not enough words in the database'
        })
        return
      }

      // Create session
      const sessionId = generateUUID()
      const session: ChallengeSession = {
        id: sessionId,
        userId,
        levelId,
        words,
        currentIndex: 0,
        correctCount: 0,
        wrongCount: 0,
        startTime: new Date(),
        timeLimit: level.timeLimit,
        maxErrors: level.maxErrors
      }

      challengeSessions.set(sessionId, session)

      res.json({
        success: true,
        data: {
          sessionId,
          words: words.map(w => ({
            id: w.id,
            word: w.word,
            phonetic: w.phonetic,
            meaning: w.meanings?.[0]?.translation || w.meanings?.[0]?.definition || ''
          })),
          totalWords: words.length,
          timeLimit: level.timeLimit,
          maxErrors: level.maxErrors,
          xpReward: level.xpReward
        }
      })
    } catch (error) {
      console.error('Start challenge error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  /**
   * Submit an answer during challenge
   */
  submitAnswer = async (req: Request, res: Response): Promise<void> => {
    try {
      const { sessionId, wordId, isCorrect } = req.body
      const userId = (req as any).userId

      const session = challengeSessions.get(sessionId)

      if (!session || session.userId !== userId) {
        res.status(404).json({
          success: false,
          message: 'Session not found'
        })
        return
      }

      // Update session
      if (isCorrect) {
        session.correctCount++
      } else {
        session.wrongCount++
      }
      session.currentIndex++

      // Check if challenge should end
      const shouldEnd =
        session.currentIndex >= session.words.length ||
        session.wrongCount > session.maxErrors

      res.json({
        success: true,
        data: {
          currentIndex: session.currentIndex,
          correctCount: session.correctCount,
          wrongCount: session.wrongCount,
          shouldEnd,
          reason: shouldEnd
            ? (session.wrongCount > session.maxErrors ? 'Too many errors' : 'Completed')
            : null
        }
      })
    } catch (error) {
      console.error('Submit answer error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  /**
   * Finish challenge and save results
   */
  finishChallenge = async (req: Request, res: Response): Promise<void> => {
    try {
      const { sessionId } = req.body
      const userId = (req as any).userId

      const session = challengeSessions.get(sessionId)

      if (!session || session.userId !== userId) {
        res.status(404).json({
          success: false,
          message: 'Session not found'
        })
        return
      }

      // Get level
      const level = await this.levelRepository.findOne({
        where: { id: session.levelId }
      })

      if (!level) {
        res.status(404).json({
          success: false,
          message: 'Level not found'
        })
        return
      }

      // Calculate results
      const timeTaken = Math.floor((new Date().getTime() - session.startTime.getTime()) / 1000)
      const totalWords = session.words.length
      const accuracy = session.correctCount / totalWords
      const isPassed = session.wrongCount <= session.maxErrors

      // Calculate star rating
      let starRating = 0
      if (isPassed) {
        if (session.wrongCount === 0) {
          starRating = 3 // Perfect
        } else if (session.wrongCount === 1) {
          starRating = 2 // Great
        } else {
          starRating = 1 // Passed
        }
      }

      // Calculate XP (bonus for speed and accuracy)
      let xpEarned = 0
      if (isPassed) {
        xpEarned = level.xpReward
        // Bonus for perfect score
        if (starRating === 3) {
          xpEarned = Math.floor(xpEarned * 1.5)
        }
      }

      // Save result
      const result = this.resultRepository.create({
        userId,
        levelId: session.levelId,
        correctCount: session.correctCount,
        wrongCount: session.wrongCount,
        timeTaken,
        starRating,
        xpEarned,
        isPassed
      })
      await this.resultRepository.save(result)

      // Update user XP if passed
      if (isPassed && xpEarned > 0) {
        await this.userRepository.increment(
          { id: userId },
          'xp',
          xpEarned
        )

        // Check for level up
        const user = await this.userRepository.findOne({ where: { id: userId } })
        if (user) {
          const newLevel = Math.floor(user.xp / 100) + 1
          if (newLevel > user.level) {
            await this.userRepository.update(
              { id: userId },
              { level: newLevel }
            )
          }
        }
      }

      // Clean up session
      challengeSessions.delete(sessionId)

      res.json({
        success: true,
        data: {
          isPassed,
          starRating,
          correctCount: session.correctCount,
          wrongCount: session.wrongCount,
          totalWords,
          timeTaken,
          xpEarned,
          isNewRecord: false // TODO: Compare with previous best
        }
      })
    } catch (error) {
      console.error('Finish challenge error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  /**
   * Get user's challenge results
   */
  getResults = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId

      const results = await this.resultRepository.find({
        where: { userId },
        relations: ['level'],
        order: { completedAt: 'DESC' }
      })

      res.json({
        success: true,
        data: results
      })
    } catch (error) {
      console.error('Get results error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }
}

function generateUUID(): string {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    const r = Math.random() * 16 | 0
    const v = c === 'x' ? r : (r & 0x3 | 0x8)
    return v.toString(16)
  })
}