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
      const { category } = req.query // 获取 RAZ 级别过滤
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

        // 如果有分类过滤，添加条件
        if (category && category !== 'all') {
          wordsQuery = wordsQuery.andWhere('word.category = :category', { category })
        }

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

      // 如果有分类过滤，添加条件
      if (category && category !== 'all') {
        newWordsQuery = newWordsQuery.where('word.category = :category', { category })
      }

      // 排除已学习的单词
      if (learnedIds.length > 0) {
        if (category && category !== 'all') {
          newWordsQuery = newWordsQuery.andWhere('word.id NOT IN (:...learnedIds)', { learnedIds })
        } else {
          newWordsQuery = newWordsQuery.where('word.id NOT IN (:...learnedIds)', { learnedIds })
        }
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
          newWords
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