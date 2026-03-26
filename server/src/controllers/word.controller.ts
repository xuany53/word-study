import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { Word } from '../entities/Word'

export class WordController {
  private wordRepository = AppDataSource.getRepository(Word)

  getAllWords = async (req: Request, res: Response): Promise<void> => {
    try {
      const { page = 1, limit = 50, category, difficulty } = req.query

      const queryBuilder = this.wordRepository.createQueryBuilder('word')

      if (category) {
        queryBuilder.andWhere('word.category = :category', { category })
      }

      if (difficulty) {
        queryBuilder.andWhere('word.difficulty = :difficulty', { difficulty })
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