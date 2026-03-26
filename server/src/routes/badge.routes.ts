import { Router } from 'express'
import { BadgeController } from '../controllers/badge.controller'
import { authenticate } from '../middlewares/auth.middleware'

const router = Router()
const badgeController = new BadgeController()

router.use(authenticate)

router.get('/', badgeController.getBadgesWithStatus)
router.get('/all', badgeController.getAllBadges)
router.get('/unlocked', badgeController.getUnlockedBadges)
router.post('/check', badgeController.checkBadges)

export default router