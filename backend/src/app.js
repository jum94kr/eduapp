import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import pino from 'pino';
import router from './routes/index.js';

const app = express();
const logger = pino();

app.use(helmet());
app.use(cors());
app.use(express.json());

app.use((req, _res, next) => {
  req.log = logger;
  next();
});

app.use(router);

export default app;
