import { z } from 'zod';
import { computeMastery } from '../utils/leveling.js';
import { chooseDifficulty, nextReviewMinutes } from '../services/adaptiveEngine.js';

const readingEventSchema = z.object({
  clusterId: z.string().uuid(),
  accuracy: z.number().min(0).max(1),
  speedRatio: z.number().min(0).max(1),
  streakBonus: z.number().min(0).max(1),
  errorPenalty: z.number().min(0).max(1),
  frustrationIndex: z.number().min(0).max(1)
});

export async function submitReadingEvent(req, res) {
  const payload = readingEventSchema.parse(req.body);
  const mastery = computeMastery(payload);
  const difficulty = chooseDifficulty({ mastery, frustrationIndex: payload.frustrationIndex });
  const reviewInMinutes = nextReviewMinutes(mastery);

  return res.json({
    mastery,
    adaptivePlan: { difficulty, reviewInMinutes }
  });
}
