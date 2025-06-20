import express from 'express';
import cors from 'cors';
import { Pool } from 'pg';

import matchesRoutes from './routes/matches.js';
import playersRoutes from './routes/players.js';
import standingsRoutes from './routes/standings.js';
import resultsRoutes from './routes/results.js';
import calendarRoutes from './routes/calendar.js';

const app = express();
const pool = new Pool({ connectionString: process.env.DATABASE_URL });

app.use(cors());
app.use(express.json());

app.use('/matches', matchesRoutes);
app.use('/players', playersRoutes);
app.use('/standings', standingsRoutes);
app.use('/results', resultsRoutes);
app.use('/calendar', calendarRoutes);

// Ruta básica de salud
app.get('/ping', (req, res) => res.send('pong'));

app.listen(process.env.PORT || 3001, () => {
  console.log('Backend corriendo en puerto 3001');
});
