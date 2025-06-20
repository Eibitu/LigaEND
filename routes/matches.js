import express from 'express';
const router = express.Router();

// Rutas de ejemplo
router.get('/', (req, res) => {
  res.send('Matches OK');
});

export default router;
