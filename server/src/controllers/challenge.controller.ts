import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { ChallengeLevel } from '../entities/ChallengeLevel'
import { ChallengeResult } from '../entities/ChallengeResult'
import { Word } from '../entities/Word'
import { User } from '../entities/User'

// In-memory challenge sessions (in production, use Redis)
const challengeSessions = new Map<string, ChallengeSession>()

// 关卡模板配置 - 5个难度等级，每个等级可生成无限关卡
const LEVEL_TEMPLATES = {
  easy: {
    namePrefix: '新手训练',
    wordCount: 5,
    timeLimit: null,
    maxErrors: 2,
    xpReward: 10,
    difficulty: 'easy'
  },
  medium: {
    namePrefix: '速度挑战',
    wordCount: 10,
    timeLimit: 60,
    maxErrors: 2,
    xpReward: 20,
    difficulty: 'medium'
  },
  hard: {
    namePrefix: '完美挑战',
    wordCount: 15,
    timeLimit: 90,
    maxErrors: 0,
    xpReward: 35,
    difficulty: 'hard'
  },
  expert: {
    namePrefix: '终极挑战',
    wordCount: 20,
    timeLimit: 120,
    maxErrors: 1,
    xpReward: 50,
    difficulty: 'expert'
  },
  legendary: {
    namePrefix: '传奇挑战',
    wordCount: 30,
    timeLimit: 150,
    maxErrors: 1,
    xpReward: 80,
    difficulty: 'legendary'
  }
}

const DIFFICULTY_ORDER = ['easy', 'medium', 'hard', 'expert', 'legendary']

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
   * 动态生成关卡：每个难度等级最多显示3关待挑战
   */
  getAllLevels = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId

      // Get existing levels
      const existingLevels = await this.levelRepository.find({
        order: { difficulty: 'ASC', createdAt: 'ASC' }
      })

      // Get user's results
      const results = await this.resultRepository.find({
        where: { userId },
        order: { completedAt: 'DESC' }
      })

      // Count passed levels per difficulty
      const passedPerDifficulty: Record<string, number> = {}
      for (const result of results) {
        if (result.isPassed) {
          const level = existingLevels.find(l => l.id === result.levelId)
          if (level) {
            passedPerDifficulty[level.difficulty] = (passedPerDifficulty[level.difficulty] || 0) + 1
          }
        }
      }

      // Check if we need to generate more levels
      const levelsToAdd: ChallengeLevel[] = []
      for (const difficulty of DIFFICULTY_ORDER) {
        const template = LEVEL_TEMPLATES[difficulty]
        const existingCount = existingLevels.filter(l => l.difficulty === difficulty).length
        const passedCount = passedPerDifficulty[difficulty] || 0

        // 生成新关卡的条件：
        // 1. 该难度至少有3关可玩
        // 2. 用户通关的关卡数 >= 现有关卡数 - 1 时，生成新关卡
        const minLevelsPerDifficulty = 3
        const neededLevels = Math.max(minLevelsPerDifficulty, passedCount + 2) - existingCount

        if (neededLevels > 0) {
          for (let i = 0; i < neededLevels; i++) {
            const levelNumber = existingCount + i + 1
            const newLevel = this.levelRepository.create({
              name: `${template.namePrefix} #${levelNumber}`,
              description: this.getLevelDescription(difficulty, levelNumber),
              wordCount: template.wordCount,
              timeLimit: template.timeLimit,
              maxErrors: template.maxErrors,
              difficulty: template.difficulty,
              xpReward: template.xpReward + Math.floor(levelNumber / 3) * 5, // 每3关奖励增加
              prerequisiteLevelId: null // 将在后面设置
            })
            levelsToAdd.push(newLevel)
          }
        }
      }

      // Save new levels
      if (levelsToAdd.length > 0) {
        await this.levelRepository.save(levelsToAdd)
        // 重新获取所有关卡
        const allLevels = await this.levelRepository.find({
          order: { difficulty: 'ASC', createdAt: 'ASC' }
        })

        // 设置前置关卡（同一难度的前一关）
        for (let i = 0; i < allLevels.length; i++) {
          const level = allLevels[i]
          // 找到同一难度的前一关
          for (let j = i - 1; j >= 0; j--) {
            if (allLevels[j].difficulty === level.difficulty) {
              if (level.prerequisiteLevelId !== allLevels[j].id) {
                level.prerequisiteLevelId = allLevels[j].id
                await this.levelRepository.save(level)
              }
              break
            }
          }
        }

        existingLevels.length = 0
        existingLevels.push(...allLevels)
      }

      // Build levels with status
      const passedLevelIds = new Set<string>()
      for (const result of results) {
        if (result.isPassed) {
          passedLevelIds.add(result.levelId)
        }
      }

      // Create a map of levelId -> best result
      const bestResults = new Map<string, ChallengeResult>()
      for (const result of results) {
        const existing = bestResults.get(result.levelId)
        if (!existing || result.starRating > existing.starRating) {
          bestResults.set(result.levelId, result)
        }
      }

      const levelsWithStatus = existingLevels.map((level, index) => {
        const bestResult = bestResults.get(level.id)
        // Unlock: first level of each difficulty always unlocked, or prerequisite level has been passed
        const isFirstOfDifficulty = !level.prerequisiteLevelId ||
          !existingLevels.some(l => l.difficulty === level.difficulty && l.prerequisiteLevelId === level.id)
        const isUnlocked = isFirstOfDifficulty || passedLevelIds.has(level.prerequisiteLevelId || '')

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
   * Get level description based on difficulty
   */
  private getLevelDescription(difficulty: string, levelNumber: number): string {
    const descriptions: Record<string, string> = {
      easy: '无时间限制，轻松入门',
      medium: '限时挑战，测试速度',
      hard: '零失误要求，追求完美',
      expert: '高难度单词，终极考验',
      legendary: '传奇级别，挑战极限'
    }
    return `${descriptions[difficulty] || '挑战自我'} - 第${levelNumber}关`
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