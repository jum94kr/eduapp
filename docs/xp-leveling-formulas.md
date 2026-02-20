# XP, Leveling, and Review Formulas

## Mastery Score (0–100)
\[
M = 100 \times \big(0.55A + 0.25S + 0.15B + 0.05(1-E)\big)
\]
- \(A\): rolling accuracy (0–1)
- \(S\): normalized speed ratio (0–1)
- \(B\): streak bonus (0–1)
- \(E\): weighted error penalty (0–1)

## XP Gain per reading event
\[
XP = \lfloor base \times (0.6 + 0.4A) \times (0.7 + 0.3S) \times (1 + 0.1B) \times C \rfloor
\]
- base = 8 for standard, 12 for story completion chunk, 15 for battle finisher.
- \(C\): challenge modifier (0.9 review, 1.0 standard, 1.15 advanced).
- Daily XP cap soft limit: 500 (rewards continue cosmetically, XP reduced to 30%).

## Level Curve
\[
XP_{to\_next}(L) = 100 + 25 \times L^{1.5}
\]
Total XP to level \(N\):
\[
\sum_{L=1}^{N-1} XP_{to\_next}(L)
\]

## Review Frequency
- If \(M < 40\): review in 10 min.
- 40–59: review in 1 hour.
- 60–79: review in 24 hours.
- 80+: review in 72 hours + random contextual reappearance.

## Weekly Ranking (encouragement-first)
\[
Score_{week} = 0.5\times\Delta Mastery + 0.3\timesConsistency + 0.2\timesStoryCompletions
\]
- Rank tiers are buckets (Explorer, Star, Hero), not harsh numeric pressure.
- Weekly reset on Monday 00:00 local time; keeps previous badges and grants cosmetic rewards.
