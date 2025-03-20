import express from 'express';
import bodyParser from 'body-parser';
import pkg from 'pg';
const { Pool } = pkg;
import dotenv from 'dotenv';
import inquirer from 'inquirer';

const app = express();
const port = 3000;

// Configure middleware first
app.use(bodyParser.json());

// Enable CORS for all routes
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  next();
});

dotenv.config();

// Function to prompt for password with masked input
const promptForPassword = async () => {
  const questions = [
    {
      type: 'password',
      name: 'dbPassword',
      message: 'Enter database password:',
      mask: '*'
    }
  ];

  const answers = await inquirer.prompt(questions);
  return answers.dbPassword;
};

// Initialize database and start server
const initializeApp = async () => {
  try {
    // Only prompt for password in development mode
    const dbPassword = process.env.NODE_ENV === 'production' 
      ? process.env.DB_PASSWORD 
      : await promptForPassword();
    
    const sslConfig = process.env.NODE_ENV === 'production' 
      ? {
          rejectUnauthorized: true,
          ca: process.env.SSL_CA_CERT,
          minVersion: 'TLSv1.2'
        }
      : false;

    const pool = new Pool({
      user: process.env.DB_USER,
      host: process.env.DB_HOST,
      database: process.env.DB_DATABASE,
      password: dbPassword,
      port: process.env.DB_PORT,
      ssl: sslConfig
    });
    
    // Test the connection
    await pool.query('SELECT NOW()');
    console.log('Database connection successful');

    // Only expose DB health check endpoint, not configuration
    app.get('/api/health', (req, res) => {
      res.json({ status: 'healthy' });
    });

    // Add new endpoint to list all tables in the database
    app.get('/api/tables', async (req, res) => {
      try {
        // This query gets all tables in the current database schema (public)
        const result = await pool.query(`
          SELECT table_name 
          FROM information_schema.tables 
          WHERE table_schema = 'public' 
          AND table_type = 'BASE TABLE'
          ORDER BY table_name
        `);
        
        res.json(result.rows.map(row => row.table_name));
      } catch (err) {
        console.error('Error fetching tables:', err);
        res.status(500).send('Error fetching database tables');
      }
    });

    // Add endpoint to get table structure
    app.get('/api/tables/:tableName', async (req, res) => {
      try {
        const { tableName } = req.params;
        // Get column information for the specified table
        const result = await pool.query(`
          SELECT column_name, data_type, is_nullable
          FROM information_schema.columns
          WHERE table_schema = 'public'
          AND table_name = $1
          ORDER BY ordinal_position
        `, [tableName]);
        
        if (result.rows.length === 0) {
          return res.status(404).send('Table not found');
        }
        
        res.json(result.rows);
      } catch (err) {
        console.error(`Error fetching structure for table ${req.params.tableName}:`, err);
        res.status(500).send('Error fetching table structure');
      }
    });

    // Add endpoint to query table data
    app.get('/api/data/:tableName', async (req, res) => {
      try {
        const { tableName } = req.params;
        const limit = req.query.limit || 100; // Default limit to 100 rows
        
        // Using parameterized query for table name isn't directly supported in pg
        // We'll validate the table name first to prevent SQL injection
        const tableCheck = await pool.query(`
          SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name = $1
          ) as "exists"
        `, [tableName]);
        
        if (!tableCheck.rows[0].exists) {
          return res.status(404).send('Table not found');
        }
        
        // Since we've validated the table name, we can use it in a query
        // Still using $1 for the LIMIT parameter
        const result = await pool.query(`
          SELECT * FROM "${tableName}" LIMIT $1
        `, [limit]);
        
        res.json(result.rows);
      } catch (err) {
        console.error(`Error fetching data from table ${req.params.tableName}:`, err);
        res.status(500).send('Error fetching table data');
      }
    });

    // Add endpoint for schema information - this is what the frontend is looking for
    app.get('/api/schema', async (req, res) => {
      try {
        // Get all tables in the public schema
        const tablesResult = await pool.query(`
          SELECT table_name 
          FROM information_schema.tables 
          WHERE table_schema = 'public' 
          AND table_type = 'BASE TABLE'
          ORDER BY table_name
        `);
        
        const tableNames = tablesResult.rows.map(row => row.table_name);
        
        // For each table, get its columns
        const schemaData = await Promise.all(
          tableNames.map(async (tableName) => {
            const columnsResult = await pool.query(`
              SELECT column_name, data_type
              FROM information_schema.columns
              WHERE table_schema = 'public'
              AND table_name = $1
              ORDER BY ordinal_position
            `, [tableName]);
            
            const columns = columnsResult.rows.map(col => ({
              name: col.column_name,
              dataType: col.data_type
            }));
            
            return {
              name: tableName,
              columns
            };
          })
        );
        
        res.json(schemaData);
      } catch (err) {
        console.error('Error fetching database schema:', err);
        res.status(500).send('Error fetching database schema');
      }
    });

    // Add endpoint for executing custom SQL queries
    app.post('/api/query', async (req, res) => {
      try {
        const { query } = req.body;
        
        if (!query || typeof query !== 'string') {
          return res.status(400).json({ error: 'Invalid query' });
        }
        
        // Basic validation to prevent destructive queries
        if (/\b(DROP|DELETE|UPDATE|INSERT|CREATE|ALTER)\b/i.test(query)) {
          return res.status(403).json({ error: 'Only SELECT queries are allowed' });
        }
        
        // Convert LIKE operator to ILIKE for case-insensitive search
        const modifiedQuery = query.replace(/\bLIKE\b/gi, 'ILIKE');
        
        // Execute the query
        const result = await pool.query(modifiedQuery);
        
        if (result.rows.length === 0) {
          return res.json([]);
        }
        
        res.json(result.rows);
      } catch (err) {
        console.error('Error executing query:', err);
        let errorMessage = 'Error executing query';
        
        // Extract meaningful error message for common database errors
        if (err.code === '42P01') {
          errorMessage = 'Table does not exist';
        } else if (err.code === '42703') {
          errorMessage = 'Column does not exist';
        } else if (err.code === '22P02') {
          errorMessage = 'Invalid data type in filter condition';
        } else if (err.message) {
          // Clean up the error message to remove any sensitive information
          errorMessage = err.message.split('\n')[0]; // Take only the first line
        }
        
        res.status(500).json({ 
          error: errorMessage,
          code: err.code || 'UNKNOWN_ERROR',
          details: process.env.NODE_ENV === 'development' ? err.message : undefined
        });
      }
    });

    app.post('/api/demo-catalog-ui', async (req, res) => {
      const {
          id, points, category, sub_category, language, role, person, ide_type, prompt_type, shot_type, is_test, test_type, epoch, confidence_percent, scenario, github_org, reference, notes_feedback, data_source, notes
      } = req.body;

      try {
          const result = await pool.query(
              `INSERT INTO demo_catalog (id, points, category, sub_category, language, role, person, ide_type, prompt_type, shot_type, is_test, test_type, epoch, confidence_percent, scenario, github_org, reference, data_source, notes)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)`,
              [id, points, category, sub_category, language, role, person, ide_type, prompt_type, shot_type, is_test, test_type, epoch, confidence_percent, scenario, github_org, reference, data_source, notes]
          );
          res.status(201).send(result);
      } catch (err) {
          console.error(err);
          res.status(500).send('Server error');
      }
    });

    // Root route handler
    app.get('/', (req, res) => {
      res.send('Hello from root route!');
    });

    app.listen(port, () => {
      console.log(`Server running on http://localhost:${port}`);
    });
    
  } catch (error) {
    console.error('Failed to initialize application:', error);
    process.exit(1);
  }
};

// Start the application
initializeApp();
