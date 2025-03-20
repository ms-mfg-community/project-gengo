import express from 'express';
import { Pool } from 'pg';
import dotenv from 'dotenv';
import React from 'react';

dotenv.config();

// Create Express router
const router = express.Router();

// Configure PostgreSQL connection
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || '5432'),
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
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

  try {
    const result = await pool.query(query);
    res.json(result.rows);
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ 
      error: error instanceof Error ? error.message : 'An unknown database error occurred' 
    });
  }
});

// If we need to render an error component for API visualization (unused in actual API routes)
export const QueryErrorDisplay: React.FC<{ error: string }> = ({ error }) => {
  return (
    <div className="query-error">
      <h3>Database Query Error</h3>
      <p>{error}</p>
    </div>
  );
};

export default router;