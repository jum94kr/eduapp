export function xpToNextLevel(level) {
  return Math.floor(100 + Math.pow(level, 1.5) * 25);
}

export function computeMastery({ accuracy, speedRatio, streakBonus, errorPenalty }) {
  const score = 100 * (0.55 * accuracy + 0.25 * speedRatio + 0.15 * streakBonus + 0.05 * (1 - errorPenalty));
  return Math.max(0, Math.min(100, Number(score.toFixed(2))));
}
