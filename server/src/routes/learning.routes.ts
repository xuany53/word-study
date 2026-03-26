import { Router } from 'express'
import { LearningController } from '../controllers/learning.controller'
import { authenticate } from '../middlewares/auth.middleware'

const router = Router()
const learningController = new LearningController()

router.use(authenticate)

router.get('/today', learningController.getTodayWords)
router.post('/start', learningController.startSession)
router.post('/answer', learningController.submitAnswer)
router.get('/records', learningController.getLearningRecords)
router.put('/record/:wordId', learningController.updateRecord)

export default router