# Adaptive Algorithm Pseudocode

```pseudo
INPUT: reading_event(user_id, cluster_id, accuracy, response_ms, error_tags)

state <- fetch_cluster_mastery(user_id, cluster_id)
recent <- fetch_recent_attempts(user_id, cluster_id, N=20)

speed_ratio = clamp(target_ms_for_cluster / response_ms, 0, 1)
error_penalty = weighted_error_penalty(error_tags)
streak_bonus = min(consecutive_success_days / 7, 1)

mastery = 100 * (
  0.55 * accuracy_ema(recent + event)
+ 0.25 * speed_ratio_ema(recent + event)
+ 0.15 * streak_bonus
+ 0.05 * (1 - error_penalty)
)
mastery = clamp(mastery, 0, 100)

forgetting_factor = exp(-hours_since_last_seen / tau)
review_urgency = (1 - mastery/100) * 0.7 + (1 - forgetting_factor) * 0.3

IF frustration_index(recent) > 0.6:
  next_bundle = easier_words(cluster_id) + success-guaranteed story lines
  feedback_tone = "encourage"
ELSE IF mastery >= 80:
  next_bundle = introduce_next_cluster_with_30pct_review()
ELSE IF mastery >= 60:
  next_bundle = same_cluster_context_mix(60% known + 40% new words)
ELSE:
  next_bundle = guided_blending_replay + high-frequency review cards

next_review_at = schedule_spaced_review(mastery, review_urgency)
persist(state, mastery, next_review_at, error_tags)
award_xp = compute_xp(event, mastery, streak_bonus)
RETURN next_bundle, mastery, award_xp
```
