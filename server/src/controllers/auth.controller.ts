import { Request, Response } from 'express'
import { AppDataSource } from '../config/database'
import { User } from '../entities/User'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'

export class AuthController {
  private userRepository = AppDataSource.getRepository(User)

  register = async (req: Request, res: Response): Promise<void> => {
    try {
      const { username, email, password } = req.body

      // 检查用户是否已存在
      const existingUser = await this.userRepository.findOne({
        where: [{ username }, { email }]
      })

      if (existingUser) {
        res.status(400).json({
          success: false,
          message: existingUser.username === username
            ? '该用户名已被注册'
            : '该邮箱已被注册'
        })
        return
      }

      // 创建新用户
      const hashedPassword = await bcrypt.hash(password, 10)
      const user = this.userRepository.create({
        username,
        email,
        password: hashedPassword
      })

      await this.userRepository.save(user)

      // 生成 token
      const token = jwt.sign(
        { userId: user.id },
        process.env.JWT_SECRET || 'secret',
        { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
      )

      res.status(201).json({
        success: true,
        data: {
          user: {
            id: user.id,
            username: user.username,
            email: user.email,
            level: user.level,
            xp: user.xp
          },
          token
        }
      })
    } catch (error) {
      console.error('Register error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  login = async (req: Request, res: Response): Promise<void> => {
    try {
      const { email, password } = req.body

      const user = await this.userRepository.findOne({ where: { email } })

      if (!user) {
        res.status(401).json({
          success: false,
          message: '邮箱或密码错误'
        })
        return
      }

      const isPasswordValid = await bcrypt.compare(password, user.password)

      if (!isPasswordValid) {
        res.status(401).json({
          success: false,
          message: '邮箱或密码错误'
        })
        return
      }

      const token = jwt.sign(
        { userId: user.id },
        process.env.JWT_SECRET || 'secret',
        { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
      )

      res.json({
        success: true,
        data: {
          user: {
            id: user.id,
            username: user.username,
            email: user.email,
            level: user.level,
            xp: user.xp,
            streak: user.streak
          },
          token
        }
      })
    } catch (error) {
      console.error('Login error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  getProfile = async (req: Request, res: Response): Promise<void> => {
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

      res.json({
        success: true,
        data: {
          id: user.id,
          username: user.username,
          email: user.email,
          level: user.level,
          xp: user.xp,
          streak: user.streak,
          longestStreak: user.longestStreak,
          theme: user.theme,
          dailyNewWords: user.dailyNewWords,
          learningMode: user.learningMode,
          soundEnabled: user.soundEnabled,
          autoPlayAudio: user.autoPlayAudio
        }
      })
    } catch (error) {
      console.error('Get profile error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  updateProfile = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const { theme, dailyNewWords, learningMode, soundEnabled, autoPlayAudio } = req.body

      await this.userRepository.update(userId, {
        theme,
        dailyNewWords,
        learningMode,
        soundEnabled,
        autoPlayAudio
      })

      res.json({
        success: true,
        message: 'Profile updated successfully'
      })
    } catch (error) {
      console.error('Update profile error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }

  changePassword = async (req: Request, res: Response): Promise<void> => {
    try {
      const userId = (req as any).userId
      const { oldPassword, newPassword } = req.body

      const user = await this.userRepository.findOne({ where: { id: userId } })

      if (!user) {
        res.status(404).json({
          success: false,
          message: 'User not found'
        })
        return
      }

      const isPasswordValid = await bcrypt.compare(oldPassword, user.password)

      if (!isPasswordValid) {
        res.status(400).json({
          success: false,
          message: 'Invalid old password'
        })
        return
      }

      const hashedPassword = await bcrypt.hash(newPassword, 10)
      await this.userRepository.update(userId, { password: hashedPassword })

      res.json({
        success: true,
        message: 'Password changed successfully'
      })
    } catch (error) {
      console.error('Change password error:', error)
      res.status(500).json({
        success: false,
        message: 'Internal server error'
      })
    }
  }
}