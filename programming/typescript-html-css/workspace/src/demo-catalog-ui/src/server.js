import express from 'express';
import bodyParser from 'body-parser';
import pkg from 'pg';
const { Pool } = pkg;
import dotenv from 'dotenv';
import inquirer from 'inquirer';

const app = express();
const port = 3000;

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
    const dbPassword = await promptForPassword();
    
    const pool = new Pool({
      user: process.env.DB_USER,
      host: process.env.DB_HOST,
      database: process.env.DB_DATABASE,
      password: dbPassword, // Using the interactively provided password
      port: process.env.DB_PORT,
      ssl: {
          rejectUnauthorized: false, // This is for demonstration purposes. In production, use proper SSL certificates.
          minVersion: 'TLSv1.2' // Enforce TLS 1.2 or higher
      }
    });
    
    // Test the connection
    await pool.query('SELECT NOW()');
    console.log('Database connection successful');

    app.get('/api/db-config', (req, res) => {
      res.json({
          user: process.env.DB_USER,
          host: process.env.DB_HOST,
          database: process.env.DB_DATABASE,
          port: process.env.DB_PORT,
          // Note: Password is not included in the response
      });
    });

    app.use(bodyParser.json());

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
