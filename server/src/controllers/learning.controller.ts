import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { LearningRecord } from '../entities/LearningRecord'
import { Word } from '../entities/Word'
import { User } from '../entities/User'

export class LearningController {
  private learningRepository = AppDataSource.getRepository(LearningRecord)
  private wordRepository = AppDataSource.getRepository(Word)
  private userRepository = AppDataSource.getRepository(User)

  getTodayWords = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const { category, source, razLevel, gradeLevel } = req.query
      const today = new Date()
      today.setHours(0, 0, 0, 0)

      // 获取需要复习的单词记录
      const reviewRecords = await this.learningRepository
        .createQueryBuilder('record')
        .where('record.userId = :userId', { userId })
        .andWhere('record.nextReviewAt <= :now', { now: new Date() })
        .getMany()

      // 如果有复习记录，获取对应的单词信息
      let reviewWords: any[] = []
      if (reviewRecords.length > 0) {
        const wordIds = reviewRecords.map(r => r.wordId)
        let wordsQuery = this.wordRepository.createQueryBuilder('word')
          .where('word.id IN (:...wordIds)', { wordIds })

        // 应用筛选条件
        wordsQuery = this.applyFilters(wordsQuery, category, source, razLevel, gradeLevel)

        reviewWords = await wordsQuery.getMany()
      }

      // 获取用户设置
      const user = await this.userRepository.findOne({ where: { id: userId } })
      const dailyNewWords = user?.dailyNewWords || 20

      // 获取新单词（用户还没学过的）
      const learnedWordIds = await this.learningRepository
        .createQueryBuilder('record')
        .select('record.wordId')
        .where('record.userId = :userId', { userId })
        .getRawMany()

      const learnedIds = learnedWordIds.map(r => r.record_wordId)

      let newWordsQuery = this.wordRepository.createQueryBuilder('word')

      // 应用筛选条件
      newWordsQuery = this.applyFilters(newWordsQuery, category, source, razLevel, gradeLevel)

      // 排除已学习的单词
      if (learnedIds.length > 0) {
        newWordsQuery = newWordsQuery.andWhere('word.id NOT IN (:...learnedIds)', { learnedIds })
      }

      const newWords = await newWordsQuery.take(dailyNewWords).getMany()

      res.json({
        success: true,
        data: {
          reviewWords: reviewWords.length,
          newWords: newWords.length,
          reviewRecords: reviewRecords.map(r => ({
            ...r,
            word: reviewWords.find(w => w.id === r.wordId)
          })),
          newWordList: newWords
        }
      })
    } catch (error) {
      console.error('Get today words error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  // 应用筛选条件的辅助方法
  private applyFilters(queryBuilder: any, category: any, source: any, razLevel: any, gradeLevel: any) {
    // 按分类筛选（兼容旧逻辑）
    if (category && category !== 'all') {
      queryBuilder = queryBuilder.andWhere('word.category = :category', { category })
    }

    // 按来源筛选：汇总/RAZ分级
    if (source && source !== 'all') {
      queryBuilder = queryBuilder.andWhere('word.source = :source', { source })
    }

    // 按RAZ级别筛选（支持多选，逗号分隔）
    if (razLevel && razLevel !== 'all') {
      const levels = String(razLevel).split(',').map(l => l.trim().toLowerCase())
      queryBuilder = queryBuilder.andWhere('word.razLevel IN (:...levels)', { levels })
    }

    // 按年级筛选
    if (gradeLevel && gradeLevel !== 'all') {
      queryBuilder = queryBuilder.andWhere('word.gradeLevel = :gradeLevel', { gradeLevel })
    }

    return queryBuilder
  }

  startSession = async (req: Request, res: Response): Promise<void> => {
    // TODO: 实现开始学习会话
    res.json({ success: true, message: 'Session started' })
  }

  submitAnswer = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const { wordId, isCorrect } = req.body

      let record = await this.learningRepository.findOne({
        where: { userId, wordId }
      })

      if (!record) {
        record = this.learningRepository.create({
          userId,
          wordId,
          status: 'learning',
          masteryLevel: 0,
          correctCount: 0,
          wrongCount: 0,
          nextReviewAt: new Date()
        })
      }

      if (isCorrect) {
        record.correctCount++
        record.masteryLevel = Math.min(5, record.masteryLevel + 1) as any
      } else {
        record.wrongCount++
        record.masteryLevel = Math.max(0, record.masteryLevel - 1) as any
      }

      record.lastReviewAt = new Date()
      // 艾宾浩斯间隔：1,2,4,7,15,30天
      const intervals = [1, 2, 4, 7, 15, 30]
      const days = intervals[record.masteryLevel] || 1
      record.nextReviewAt = new Date(Date.now() + days * 24 * 60 * 60 * 1000)

      record.status = record.masteryLevel >= 4 ? 'mastered' : 'learning'

      await this.learningRepository.save(record)

      // 更新用户经验值
      const xpGain = isCorrect ? 2 : 0
      await this.userRepository.increment({ id: userId }, 'xp', xpGain)

      res.json({
        success: true,
        data: {
          masteryLevel: record.masteryLevel,
          xpGain,
          nextReviewAt: record.nextReviewAt
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

  getLearningRecords = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const records = await this.learningRepository.find({ where: { userId } })

      res.json({
        success: true,
        data: records
      })
    } catch (error) {
      console.error('Get learning records error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  updateRecord = async (req: Request, res: Response): Promise<void> => {
    // TODO: 实现更新学习记录
    res.json({ success: true, message: 'Record updated' })
  }
}