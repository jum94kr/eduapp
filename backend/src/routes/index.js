import { Router } from 'express';
import { authRequired } from '../middleware/auth.js';
import { submitReadingEvent } from '../controllers/progressController.js';

const router = Router();

router.get('/health', (_req, res) => res.json({ ok: true }));
router.post('/v1/progress/reading-event', authRequired, submitReadingEvent);

export default router;
