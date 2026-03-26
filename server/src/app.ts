import 'reflect-metadata'
import express from 'express'
import cors from 'cors'
import * as dotenv from 'dotenv'

dotenv.config()

import { AppDataSource } from './config/database'
import authRoutes from './routes/auth.routes'
import wordRoutes from './routes/word.routes'
import learningRoutes from './routes/learning.routes'
import statsRoutes from './routes/stats.routes'
import challengeRoutes from './routes/challenge.routes'
import badgeRoutes from './routes/badge.routes'

const app = express()
const PORT = process.env.PORT || 3000

// 中间件
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
  credentials: true
}))
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// 路由
app.use('/api/auth', authRoutes)
app.use('/api/words', wordRoutes)
app.use('/api/learning', learningRoutes)
app.use('/api/stats', statsRoutes)
app.use('/api/challenge', challengeRoutes)
app.use('/api/badges', badgeRoutes)

// 健康检查
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() })
})

// 错误处理中间件
app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
  console.error(err.stack)
  res.status(500).json({
    success: false,
    message: process.env.NODE_ENV === 'development' ? err.message : 'Internal Server Error'
  })
})

// 启动服务器
AppDataSource.initialize()
  .then(() => {
    console.log('✅ Database connected successfully')
    app.listen(PORT, () => {
      console.log(`🚀 Server is running on http://localhost:${PORT}`)
    })
  })
  .catch((error) => {
    console.error('❌ Database connection error:', error)
    process.exit(1)
  })

export default app