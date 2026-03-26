import { Router } from 'express'
import { ChallengeController } from '../controllers/challenge.controller'
import { authenticate } from '../middlewares/auth.middleware'

const router = Router()
const challengeController = new ChallengeController()

router.use(authenticate)

router.get('/levels', challengeController.getAllLevels)
router.get('/levels/:id', challengeController.getLevelById)
router.post('/start/:levelId', challengeController.startChallenge)
router.post('/answer', challengeController.submitAnswer)
router.post('/finish', challengeController.finishChallenge)
router.get('/results', challengeController.getResults)

export default router