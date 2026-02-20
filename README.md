# EduApp — Phonics RPG (MVP Skeleton)

This repository provides a production-oriented skeleton for an immersive phonics RPG learning platform.

## Included deliverables
1. Product architecture document: `docs/product-architecture.md`
2. 12-week roadmap: `docs/learning-progression-12-week.md`
3. Phonics cluster map: `docs/phonics-cluster-map.md`
4. PostgreSQL schema: `db/schema.sql`
5. Backend structure: `docs/backend-folder-structure.md` + `backend/`
6. Frontend structure: `docs/frontend-folder-structure.md` + `frontend/`
7. Adaptive logic pseudocode: `docs/adaptive-algorithm.md`
8. XP/level formulas: `docs/xp-leveling-formulas.md`
9. MVP code skeleton: Express API + Next.js mobile-first shell
10. Scaling strategy: `docs/scaling-10k-users.md`

## Quick start
### Backend
```bash
cd backend
npm install
npm run dev
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```

## Redis usage
- Leaderboard sorted sets (`leaderboard:week:YYYY-MM-DD`).
- Session/progression cache (`session:{userId}`, short TTL).
