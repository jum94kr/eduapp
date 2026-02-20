# Scaling Strategy for 10,000 Users

## Infra
- Deploy API replicas behind load balancer (3–6 pods baseline).
- Managed PostgreSQL with read replica for analytics endpoints.
- Redis cluster for leaderboard + session cache + queue backing.
- CDN for audio/image assets.

## Data & Performance
- Partition `reading_attempts` monthly once >10M rows.
- Use async jobs for leaderboard recompute and reward grants.
- Cache hot progression payloads in Redis with short TTL (2–5 min).

## Reliability
- Queue-based retry for non-critical writes (rank cache, digest).
- Circuit breaker for downstream audio metadata service.
- Zero-downtime migrations with feature flags.

## SLO Targets
- API p95 < 250ms for gameplay endpoints.
- 99.9% auth success availability.
- Rank refresh completion < 5 min after weekly reset.

## Anti-addiction / healthy usage
- Session nudges every 20 minutes: stretch/water reminders.
- Reduced XP after soft cap; story mode remains available.
- Guardian dashboard with playtime summary and optional limits.
