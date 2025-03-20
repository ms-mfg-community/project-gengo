import express from 'express';
import { Pool, PoolClient } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const router = express.Router();

// Create a pool configuration
const poolConfig = {
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || '5432'),
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
};

// Create pool instance
const pool = new Pool(poolConfig);

// Handle pool errors
pool.on('error', (err: Error) => {
  console.error('Unexpected error on idle client', err);
  process.exit(-1);
});

// Endpoint to execute database queries
router.post('/query', async (req, res) => {
  const { query } = req.body;
  
  if (!query) {
    return res.status(400).json({ error: 'Query is required' });
  }

  // Security check - restrict to SELECT queries only for safety
  const normalizedQuery = query.trim().toLowerCase();
  if (!normalizedQuery.startsWith('select')) {
    return res.status(403).json({ 
      error: 'Only SELECT queries are allowed for security reasons' 
    });
  }

  let client: PoolClient | null = null;
  
  try {
    client = await pool.connect();
    const result = await client.query(query);
    res.json(result.rows);
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ 
      error: error instanceof Error ? error.message : 'An unknown database error occurred' 
    });
  } finally {
    if (client) {
      client.release();
    }
  }
});

export default router;