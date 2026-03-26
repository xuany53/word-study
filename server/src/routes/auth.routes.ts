import { Router } from 'express'
import { AuthController } from '../controllers/auth.controller'
import { authenticate } from '../middlewares/auth.middleware'

const router = Router()
const authController = new AuthController()

// 公开路由
router.post('/register', authController.register)
router.post('/login', authController.login)

// 受保护路由
router.get('/me', authenticate, authController.getProfile)
router.put('/me', authenticate, authController.updateProfile)
router.put('/password', authenticate, authController.changePassword)

export default router