import { Router } from 'express'
import { StatsController } from '../controllers/stats.controller'
import { authenticate } from '../middlewares/auth.middleware'

const router = Router()
const statsController = new StatsController()

router.use(authenticate)

router.get('/', statsController.getStats)
router.get('/daily', statsController.getDailyStats)
router.post('/checkin', statsController.checkIn)
router.get('/calendar', statsController.getCheckInCalendar)

export default router