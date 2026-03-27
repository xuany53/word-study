import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { Word } from '../entities/Word'

export class WordController {
  private wordRepository = AppDataSource.getRepository(Word)

  getAllWords = async (req: Request, res: Response): Promise<void> => {
    try {
      const { page = 1, limit = 50, category, difficulty, source, razLevel, gradeLevel } = req.query

      const queryBuilder = this.wordRepository.createQueryBuilder('word')

      // 按分类筛选（兼容旧逻辑）
      if (category) {
        queryBuilder.andWhere('word.category = :category', { category })
      }

      // 按难度筛选
      if (difficulty) {
        queryBuilder.andWhere('word.difficulty = :difficulty', { difficulty })
      }

      // 按来源筛选：汇总/RAZ分级
      if (source) {
        queryBuilder.andWhere('word.source = :source', { source })
      }

      // 按RAZ级别筛选（支持多选，逗号分隔，如 "a,b,c"）
      if (razLevel) {
        const levels = String(razLevel).split(',').map(l => l.trim().toLowerCase())
        queryBuilder.andWhere('word.razLevel IN (:...levels)', { levels })
      }

      // 按年级筛选（小学/初中/高中）
      if (gradeLevel) {
        queryBuilder.andWhere('word.gradeLevel = :gradeLevel', { gradeLevel })
      }

      const [words, total] = await queryBuilder
        .skip((Number(page) - 1) * Number(limit))
        .take(Number(limit))
        .getManyAndCount()

      res.json({
        success: true,
        data: words,
        pagination: {
          page: Number(page),
          limit: Number(limit),
          total,
          totalPages: Math.ceil(total / Number(limit))
        }
      })
    } catch (error) {
      console.error('Get all words error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  getWordById = async (req: Request, res: Response): Promise<void> => {
    try {
      const { id } = req.params
      const word = await this.wordRepository.findOne({ where: { id } })

      if (!word) {
        res.status(404).json({
          success: false,
          message: 'Word not found'
        })
        return
      }

      res.json({
        success: true,
        data: word
      })
    } catch (error) {
      console.error('Get word by id error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  getWordsByCategory = async (req: Request, res: Response): Promise<void> => {
    try {
      const { category } = req.params
      const words = await this.wordRepository.find({ where: { category } })

      res.json({
        success: true,
        data: words
      })
    } catch (error) {
      console.error('Get words by category error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }
}