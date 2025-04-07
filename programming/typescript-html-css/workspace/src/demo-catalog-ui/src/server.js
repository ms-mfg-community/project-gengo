import express from 'express';
import bodyParser from 'body-parser';
import pkg from 'pg';
const { Pool } = pkg;
import dotenv from 'dotenv';
import inquirer from 'inquirer';
import fetch from 'node-fetch'; // Add this for making API calls to Azure OpenAI
import punycode from 'punycode'; // Using the installed punycode package

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
      database: process.env.DB_NAME,
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
        res.status(500).json({ error: 'Error fetching database tables' });
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

    // Add endpoint for updating records
    app.put('/api/update/:tableName', async (req, res) => {
      try {
        const { tableName } = req.params;
        const recordData = req.body;
        
        if (!recordData || Object.keys(recordData).length === 0) {
          return res.status(400).json({ error: 'No data provided for update' });
        }
        
        // Get primary key for the table - currently assuming 'id' is always the primary key
        const idField = 'id';
        const idValue = recordData[idField];
        
        if (!idValue) {
          return res.status(400).json({ error: 'Record ID is required for update' });
        }
        
        // Validate the table name
        const tableCheck = await pool.query(`
          SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name = $1
          ) as "exists"
        `, [tableName]);
        
        if (!tableCheck.rows[0].exists) {
          return res.status(404).json({ error: 'Table not found' });
        }
        
        // Build the SET clause for the UPDATE statement
        const updates = [];
        const values = [];
        let paramIndex = 1;
        
        // Exclude the ID field from the SET clause
        for (const [key, value] of Object.entries(recordData)) {
          if (key !== idField) {
            updates.push(`${key} = $${paramIndex}`);
            values.push(value);
            paramIndex++;
          }
        }
        
        // Add the ID value as the last parameter for the WHERE clause
        values.push(idValue);
        
        const query = `
          UPDATE "${tableName}"
          SET ${updates.join(', ')}
          WHERE ${idField} = $${paramIndex}
        `;
        
        const result = await pool.query(query, values);
        
        if (result.rowCount === 0) {
          return res.status(404).json({ error: 'Record not found' });
        }
        
        res.json({ message: 'Record updated successfully' });
      } catch (err) {
        console.error('Error updating record:', err);
        
        // Extract meaningful error message for common database errors
        let errorMessage = 'Error updating record';
        if (err.code === '42P01') {
          errorMessage = 'Table does not exist';
        } else if (err.code === '42703') {
          errorMessage = 'Column does not exist';
        } else if (err.code === '22P02') {
          errorMessage = 'Invalid data type in update';
        } else if (err.message) {
          errorMessage = err.message.split('\n')[0]; // Take only the first line
        }
        
        res.status(500).json({ 
          error: errorMessage,
          code: err.code || 'UNKNOWN_ERROR',
          details: process.env.NODE_ENV === 'development' ? err.message : undefined
        });
      }
    });

    // Add endpoint for deleting records
    app.delete('/api/delete/:tableName/:idField/:idValue', async (req, res) => {
      try {
        const { tableName, idField, idValue } = req.params;
        
        // Validate the table name
        const tableCheck = await pool.query(`
          SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name = $1
          ) as "exists"
        `, [tableName]);
        
        if (!tableCheck.rows[0].exists) {
          return res.status(404).json({ error: 'Table not found' });
        }
        
        // Validate the column name
        const columnCheck = await pool.query(`
          SELECT EXISTS (
            SELECT FROM information_schema.columns 
            WHERE table_schema = 'public' 
            AND table_name = $1
            AND column_name = $2
          ) as "exists"
        `, [tableName, idField]);
        
        if (!columnCheck.rows[0].exists) {
          return res.status(404).json({ error: 'Column not found' });
        }
        
        const query = `
          DELETE FROM "${tableName}"
          WHERE ${idField} = $1
        `;
        
        const result = await pool.query(query, [idValue]);
        
        if (result.rowCount === 0) {
          return res.status(404).json({ error: 'Record not found' });
        }
        
        res.json({ message: 'Record deleted successfully' });
      } catch (err) {
        console.error('Error deleting record:', err);
        
        // Extract meaningful error message for common database errors
        let errorMessage = 'Error deleting record';
        if (err.code === '42P01') {
          errorMessage = 'Table does not exist';
        } else if (err.code === '42703') {
          errorMessage = 'Column does not exist';
        } else if (err.code === '22P02') {
          errorMessage = 'Invalid data type in delete condition';
        } else if (err.message) {
          errorMessage = err.message.split('\n')[0]; // Take only the first line
        }
        
        res.status(500).json({ 
          error: errorMessage,
          code: err.code || 'UNKNOWN_ERROR',
          details: process.env.NODE_ENV === 'development' ? err.message : undefined
        });
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

    // Add semantic-search endpoint
    app.post('/api/semantic-search', async (req, res) => {
      try {
        console.log('Received semantic search request');
        const { query, credentials } = req.body;
        
        if (!query || typeof query !== 'string') {
          console.error('Invalid query in request');
          return res.status(400).json({ error: 'Invalid query' });
        }
        
        if (!credentials || !credentials.azureOpenAI || !credentials.dbParams) {
          console.error('Missing required credentials:', JSON.stringify({ 
            hasCredentials: !!credentials,
            hasAzureOpenAI: !!(credentials && credentials.azureOpenAI),
            hasDbParams: !!(credentials && credentials.dbParams)
          }));
          return res.status(400).json({ error: 'Missing required credentials' });
        }
        
        const { azureOpenAI, dbParams } = credentials;
        console.log('Connecting to database with params:', {
          user: dbParams.user,
          host: dbParams.host,
          database: dbParams.dbname,
          port: dbParams.port,
          ssl: { rejectUnauthorized: false }
        });
        
        // Step 1: Create a connection to the specified database
        const searchPool = new Pool({
          user: dbParams.user,
          host: dbParams.host,
          database: dbParams.dbname,
          password: dbParams.password,
          port: dbParams.port,
          ssl: { rejectUnauthorized: false } // Adjust as needed for your DB security
        });
        
        try {
          // Test the connection
          await searchPool.query('SELECT 1');
          console.log('Database connection successful');
        } catch (dbError) {
          console.error('Database connection failed:', dbError);
          await searchPool.end();
          return res.status(500).json({ error: `Database connection error: ${dbError.message}` });
        }
        
        console.log('Requesting embedding from Azure OpenAI');
        // Step 2: Get embedding for the query from Azure OpenAI
        let embeddingResponse;
        try {
          // Use the deploymentName from credentials or default to "embedding-ada-002"
          const deploymentName = azureOpenAI.deploymentName || "embedding-ada-002";
          const embedUrl = `${azureOpenAI.azureEndpoint}/openai/deployments/${deploymentName}/embeddings?api-version=${azureOpenAI.apiVersion}`;
          console.log('Making embedding request to:', embedUrl);
          
          embeddingResponse = await fetch(embedUrl, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'api-key': azureOpenAI.apiKey
            },
            body: JSON.stringify({
              input: query,
              model: "text-embedding-ada-002" 
            })
          });
        } catch (fetchError) {
          console.error('Fetch to Azure OpenAI failed:', fetchError);
          await searchPool.end();
          return res.status(500).json({ error: `Azure OpenAI API fetch error: ${fetchError.message}` });
        }
        
        if (!embeddingResponse.ok) {
          const errorText = await embeddingResponse.text();
          console.error('Azure OpenAI API returned error:', embeddingResponse.status, errorText);
          await searchPool.end();
          return res.status(502).json({ 
            error: `Azure OpenAI API error: ${embeddingResponse.status} ${errorText}`,
            status: embeddingResponse.status
          });
        }
        
        const embeddingData = await embeddingResponse.json();
        console.log('Received embedding data with dimensions:', embeddingData.data[0].embedding.length);
        const queryEmbedding = embeddingData.data[0].embedding;
        
        // Check if the demo_catalog table exists and has the embedding column
        try {
          const tableCheck = await searchPool.query(`
            SELECT EXISTS (
              SELECT FROM information_schema.tables
              WHERE table_schema = 'public'
              AND table_name = 'demo_catalog'
            ) as exists
          `);
          
          if (!tableCheck.rows[0].exists) {
            console.error('demo_catalog table does not exist');
            await searchPool.end();
            return res.status(500).json({ error: 'Database error: demo_catalog table does not exist' });
          }

          const columnCheck = await searchPool.query(`
            SELECT EXISTS (
              SELECT FROM information_schema.columns
              WHERE table_schema = 'public'
              AND table_name = 'demo_catalog'
              AND column_name = 'embedding'
            ) as exists
          `);
          
          if (!columnCheck.rows[0].exists) {
            console.error('embedding column does not exist in demo_catalog table');
            await searchPool.end();
            return res.status(500).json({ error: 'Database error: embedding column does not exist' });
          }
        } catch (dbStructureError) {
          console.error('Error checking database structure:', dbStructureError);
          await searchPool.end();
          return res.status(500).json({ error: `Database structure error: ${dbStructureError.message}` });
        }
        
        console.log('Performing vector similarity search');
        // Step 3: Use the embedding to search the database for similar content
        try {
          // Format the embedding vector for PostgreSQL - convert JavaScript array to PostgreSQL vector format
          // The correct pgvector format is '[x1,x2,...,xn]' - a string with square brackets
          const formattedVector = JSON.stringify(queryEmbedding);
          
          const searchResults = await searchPool.query(`
            SELECT 
              id,
              scenario, 
              category,
              sub_category,
              language,
              role,
              ide_type as ide,
              reference,
              1 - (embedding <-> $1::vector) as similarity
            FROM demo_catalog
            WHERE embedding IS NOT NULL
            ORDER BY embedding <-> $1::vector
            LIMIT 5;
          `, [formattedVector]);
          
          console.log(`Search complete, found ${searchResults.rows.length} results`);
          
          // Close the connection to the search pool
          await searchPool.end();
          
          // Return the search results
          res.json(searchResults.rows);
        } catch (searchError) {
          console.error('Database search error:', searchError);
          await searchPool.end();
          return res.status(500).json({ error: `Database search error: ${searchError.message}` });
        }
      } catch (err) {
        console.error('Error performing semantic search:', err);
        res.status(500).json({ error: `Error performing semantic search: ${err.message}` });
      }
    });

    // Add validate-deployment endpoint
    app.post('/api/validate-deployment', async (req, res) => {
      try {
        const { credentials } = req.body;
        
        if (!credentials || !credentials.azureOpenAI) {
          return res.status(400).json({ 
            valid: false,
            message: 'Missing required credentials' 
          });
        }
        
        const { apiKey, azureEndpoint, apiVersion, deploymentName } = credentials.azureOpenAI;
        
        if (!apiKey || !azureEndpoint || !deploymentName) {
          return res.status(400).json({ 
            valid: false,
            message: 'Missing required Azure OpenAI parameters' 
          });
        }
        
        console.log(`Validating deployment: ${deploymentName} at ${azureEndpoint}`);
        
        // For embedding models, we'll test with a simple embedding request
        if (deploymentName.includes('embedding')) {
          try {
            const testUrl = `${azureEndpoint}/openai/deployments/${deploymentName}/embeddings?api-version=${apiVersion}`;
            console.log('Testing embedding endpoint:', testUrl);
            
            const embeddingResponse = await fetch(testUrl, {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'api-key': apiKey
              },
              body: JSON.stringify({
                input: "Test validation",
                model: deploymentName
              })
            });
            
            if (!embeddingResponse.ok) {
              const errorText = await embeddingResponse.text();
              console.error('Embedding test failed:', embeddingResponse.status, errorText);
              throw new Error(`Embedding test failed: ${embeddingResponse.status} ${errorText}`);
            }
            
            // Test passed, response was successful
            await embeddingResponse.json(); // Just to validate the response is proper JSON
          } catch (testError) {
            console.error('Deployment test failed:', testError);
            throw testError;
          }
        } else {
          // For generative models, we'll use a simple completion request
          try {
            const testUrl = `${azureEndpoint}/openai/deployments/${deploymentName}/completions?api-version=${apiVersion}`;
            console.log('Testing completion endpoint:', testUrl);
            
            const completionResponse = await fetch(testUrl, {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'api-key': apiKey
              },
              body: JSON.stringify({
                prompt: "Hello",
                max_tokens: 5,
                temperature: 0.5
              })
            });
            
            if (!completionResponse.ok) {
              const errorText = await completionResponse.text();
              console.error('Completion test failed:', completionResponse.status, errorText);
              throw new Error(`Completion test failed: ${completionResponse.status} ${errorText}`);
            }
            
            // Test passed, response was successful
            await completionResponse.json(); // Just to validate the response is proper JSON
          } catch (testError) {
            console.error('Deployment test failed:', testError);
            throw testError;
          }
        }
        
        // If we got here, the validation was successful
        console.log('Deployment validation successful');
        
        // Attempt to get available deployments
        let availableDeployments = [];
        try {
          // This endpoint works with Azure OpenAI
          const modelsUrl = `${azureEndpoint}/openai/deployments?api-version=${apiVersion}`;
          console.log('Fetching available deployments:', modelsUrl);
          
          const modelsResponse = await fetch(modelsUrl, {
            headers: {
              'api-key': apiKey
            }
          });
          
          if (modelsResponse.ok) {
            const modelsData = await modelsResponse.json();
            if (modelsData.data && Array.isArray(modelsData.data)) {
              availableDeployments = modelsData.data.map(deployment => ({
                id: deployment.id,
                model: deployment.model
              }));
              console.log(`Found ${availableDeployments.length} available deployments`);
            }
          } else {
            console.log('Could not fetch available deployments, continuing with validation');
          }
        } catch (modelsError) {
          console.log('Error fetching available deployments:', modelsError.message);
          // Non-critical error, we can continue without available deployments
        }
        
        // Return success response
        res.json({ 
          valid: true, 
          message: 'Deployment validated successfully',
          availableDeployments 
        });
      } catch (error) {
        console.error('Deployment validation error:', error);
        res.status(400).json({ 
          valid: false,
          message: `Validation failed: ${error.message}` 
        });
      }
    });

    // Add endpoint to format search results with left justification
    app.post('/api/format-search-results', async (req, res) => {
      try {
        const { results } = req.body;
        
        if (!results || !Array.isArray(results)) {
          return res.status(400).json({ error: 'Invalid results data. Expected an array.' });
        }
        
        // Format the results with left justification
        const formattedResults = results.map((result, index) => {
          const score = typeof result.similarity === 'number' ? result.similarity.toFixed(4) : result.score?.toFixed(4) || 'N/A';
            return [
            `Result ${index + 1} - Score: ${score}`,
            `Category: ${result.category || 'N/A'}${result.sub_category ? ' / ' + result.sub_category : ''}`,
            '',
            `Language: ${result.language || 'N/A'}`,
            '',
            `Role: ${result.role || 'N/A'}`,
            '',
            `IDE: ${result.ide || 'N/A'}`,
            '',
            `Reference: ${result.reference || 'N/A'}`,
            '',
            `Scenario: ${result.scenario || 'N/A'}`,
            ''
            ].join('\n');
        }).join('\n');
        
        res.json({ formattedResults });
      } catch (err) {
        console.error('Error formatting search results:', err);
        res.status(500).json({ error: `Error formatting results: ${err.message}` });
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
