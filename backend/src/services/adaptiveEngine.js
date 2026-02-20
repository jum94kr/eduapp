export function nextReviewMinutes(mastery) {
  if (mastery < 40) return 10;
  if (mastery < 60) return 60;
  if (mastery < 80) return 24 * 60;
  return 72 * 60;
}

export function chooseDifficulty({ mastery, frustrationIndex }) {
  if (frustrationIndex > 0.6) return 'easier_review';
  if (mastery >= 80) return 'advance';
  if (mastery >= 60) return 'standard';
  return 'review';
}
