import { Router } from 'express'
import { WordController } from '../controllers/word.controller'
import { authenticate } from '../middlewares/auth.middleware'

const router = Router()
const wordController = new WordController()

// 所有路由都需要认证
router.use(authenticate)

router.get('/', wordController.getAllWords)
router.get('/:id', wordController.getWordById)
router.get('/category/:category', wordController.getWordsByCategory)

export default router