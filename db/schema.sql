CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "citext";

-- Users / auth
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email CITEXT UNIQUE,
  password_hash TEXT,
  nickname VARCHAR(32) NOT NULL,
  role VARCHAR(16) NOT NULL DEFAULT 'student',
  age_band VARCHAR(16) NOT NULL DEFAULT 'g2',
  guardian_consent_version VARCHAR(16),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE refresh_tokens (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash TEXT NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  revoked_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Character and RPG state
CREATE TABLE characters (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  avatar_type VARCHAR(32) NOT NULL,
  level INT NOT NULL DEFAULT 1,
  xp_total INT NOT NULL DEFAULT 0,
  coins_soft INT NOT NULL DEFAULT 0,
  title VARCHAR(64),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE character_stats (
  character_id UUID PRIMARY KEY REFERENCES characters(id) ON DELETE CASCADE,
  power INT NOT NULL DEFAULT 1,
  focus INT NOT NULL DEFAULT 1,
  rhythm INT NOT NULL DEFAULT 1,
  resilience INT NOT NULL DEFAULT 1,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE skills (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  code VARCHAR(32) UNIQUE NOT NULL,
  name VARCHAR(64) NOT NULL,
  cluster_family VARCHAR(32) NOT NULL,
  unlock_mastery_threshold INT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE character_skills (
  character_id UUID NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  skill_id UUID NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  unlocked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (character_id, skill_id)
);

-- Learning content
CREATE TABLE phonics_clusters (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  code VARCHAR(16) UNIQUE NOT NULL,
  cluster_type VARCHAR(32) NOT NULL,
  week_recommended INT,
  difficulty_tier INT NOT NULL,
  ipa_hint VARCHAR(32),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE words (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  text VARCHAR(64) NOT NULL,
  cluster_id UUID REFERENCES phonics_clusters(id),
  difficulty_tier INT NOT NULL,
  image_url TEXT,
  audio_word_url TEXT,
  audio_segments JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE stories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(128) NOT NULL,
  body JSONB NOT NULL,
  difficulty_tier INT NOT NULL,
  primary_cluster_id UUID REFERENCES phonics_clusters(id),
  illustration_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Mastery tracking
CREATE TABLE cluster_mastery (
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  cluster_id UUID NOT NULL REFERENCES phonics_clusters(id) ON DELETE CASCADE,
  mastery_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  speed_wpm NUMERIC(6,2) NOT NULL DEFAULT 0,
  accuracy_rate NUMERIC(5,4) NOT NULL DEFAULT 0,
  streak_days INT NOT NULL DEFAULT 0,
  mistake_pattern JSONB NOT NULL DEFAULT '{}'::jsonb,
  next_review_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, cluster_id)
);

CREATE TABLE word_mastery (
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  word_id UUID NOT NULL REFERENCES words(id) ON DELETE CASCADE,
  exposures INT NOT NULL DEFAULT 0,
  successful_reads INT NOT NULL DEFAULT 0,
  avg_response_ms INT,
  mastery_score NUMERIC(5,2) NOT NULL DEFAULT 0,
  last_seen_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, word_id)
);

CREATE TABLE reading_attempts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  content_type VARCHAR(16) NOT NULL,
  content_id UUID NOT NULL,
  cluster_id UUID REFERENCES phonics_clusters(id),
  accuracy NUMERIC(5,4) NOT NULL,
  response_ms INT NOT NULL,
  error_tags TEXT[] NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- RPG progression and rewards
CREATE TABLE xp_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  source VARCHAR(32) NOT NULL,
  source_ref UUID,
  xp_delta INT NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  code VARCHAR(32) UNIQUE NOT NULL,
  name VARCHAR(64) NOT NULL,
  item_type VARCHAR(16) NOT NULL CHECK (item_type IN ('cosmetic','title','emote')),
  rarity VARCHAR(16) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE inventory (
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  item_id UUID NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  acquired_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  source VARCHAR(32) NOT NULL,
  PRIMARY KEY (user_id, item_id)
);

CREATE TABLE story_progress (
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  story_id UUID NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
  read_count INT NOT NULL DEFAULT 0,
  completion_state VARCHAR(16) NOT NULL DEFAULT 'in_progress',
  last_read_at TIMESTAMPTZ,
  PRIMARY KEY (user_id, story_id)
);

-- Ranking
CREATE TABLE weekly_rank_cache (
  week_key DATE NOT NULL,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  rank_position INT NOT NULL,
  score INT NOT NULL,
  tier VARCHAR(16) NOT NULL,
  reward_granted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (week_key, user_id)
);

CREATE INDEX idx_attempt_user_time ON reading_attempts(user_id, created_at DESC);
CREATE INDEX idx_cluster_review ON cluster_mastery(next_review_at);
CREATE INDEX idx_xp_logs_user_time ON xp_logs(user_id, created_at DESC);
