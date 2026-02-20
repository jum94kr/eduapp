# Phonics RPG Learning Platform — Product Architecture (Korean Grade 2)

## 1) Vision & Core Principles
- **Core loop**: hear → blend → read in context → succeed in mini-encounter → avatar grows.
- **No quiz pressure**: no exam UI, no multiple choice dependency, no punitive grades.
- **Confidence-first**: reinforce effort, streaks, and pattern mastery through visual progression.
- **Pattern-centric**: phonics clusters are the progression backbone (not vocabulary lists).

## 2) User Personas
- **Primary learner**: Korean grade-2 child, alphabet known, weak at blending consonant/vowel clusters.
- **Guardian**: wants safe, healthy usage and visible progress without stress.
- **Teacher (future)**: class dashboard and assignment templates.

## 3) Gameplay Modules
### A. Phonics Adventure Mode
- Introduces 1–2 clusters per mission (e.g., `sn`, `bl`, `ai`).
- Animated blend rail: `s` + `n` + `a` + `p` → `snap` with timed audio segments.
- Mouth animation and tongue/lip hint cards.
- Echo repetition with adaptive pacing.

### B. Word Discovery Mode
- Dynamic cards float into scene with image + spoken word + highlighted cluster.
- Meaning is inferred through scene interactions (drag word to matching object in the scene).
- Cluster hunt missions: “Find all `sn` words in Snow Village.”

### C. Reading Story Mode
- 4–8 sentence illustrated micro-stories.
- Tap any word to hear pronunciation and segmented phonics.
- Soft highlight of known clusters for passive reinforcement.

### D. Battle Mode (Non-violent thematic option supported)
- Reading success powers actions (shield, spell, helper summon).
- Higher fluency and accurate blending produce stronger effect.
- Pattern mastery unlocks class-like skills (e.g., “Blend Burst: `sh/ch`”).

### E. Growth Map
- World map zones mapped to cluster families.
- Cannot skip foundation zones; optional side missions for cosmetics.
- Mastery gates open with sustained readiness, not one-time pass.

## 4) UX Design Rules (Child-Friendly)
- 44px+ touch targets, large typography, single-focus screens.
- Max 2 actions per screen for core flow.
- Audio-first controls and icon consistency.
- Positive language only (“Let’s try slower!” not “Wrong”).

## 5) Technical Architecture
- **Frontend**: Next.js App Router + Tailwind + Framer Motion.
- **Backend API**: Node.js + Express + JWT auth + RBAC (student/guardian/admin).
- **Data**: PostgreSQL (source of truth), Redis (leaderboards/session/cache).
- **Audio pipeline**: pre-generated phoneme segments + full-word clips, streamed via CDN.
- **Jobs**: BullMQ workers for weekly rank reset, digest generation, content precomputation.

## 6) Core Domain Services
- `ProgressEngine`: mastery updates, gating logic.
- `AdaptiveEngine`: repetition and difficulty adjustments.
- `BattleResolver`: computes encounter outcomes from reading events.
- `RewardService`: grants cosmetic unlocks.
- `SafetyService`: enforces healthy usage nudges.

## 7) Event-Driven Data Flow
1. Client sends `reading_attempt` with timing + accuracy metadata.
2. API validates token, stores attempt, updates rolling mastery features.
3. AdaptiveEngine computes next content bundle.
4. BattleResolver/StoryEngine consumes result and returns immediate UI state.
5. XP log, inventory updates, and leaderboard cache updates are queued.

## 8) Security & Compliance
- COPPA-like minimal data collection: nickname, age-band only.
- Guardian consent version tracking.
- Signed media URLs for paid/private assets.
- JWT rotation + refresh token revocation list.

## 9) Observability
- Structured logs (`pino`), trace IDs, latency budgets per endpoint.
- Metrics: session length, frustration index, cluster mastery velocity, retention.
- Alerting: queue lag, DB p95, auth anomalies.
