import dotenv from 'dotenv';

dotenv.config();

export const env = {
  port: Number(process.env.PORT || 4000),
  jwtSecret: process.env.JWT_SECRET || 'dev-secret',
  dbUrl: process.env.DATABASE_URL || 'postgres://localhost:5432/eduapp',
  redisUrl: process.env.REDIS_URL || 'redis://localhost:6379'
};
