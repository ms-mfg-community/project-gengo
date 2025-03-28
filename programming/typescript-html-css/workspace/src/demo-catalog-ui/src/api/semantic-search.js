// API endpoint for performing semantic searches using Azure OpenAI embeddings
// This endpoint connects to a Postgres database and performs vector similarity search

const { OpenAIClient, AzureKeyCredential } = require('@azure/openai');
const { Pool } = require('pg');

module.exports = async (req, res) => {
  console.log('Received semantic search request');

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { query, credentials } = req.body;

    if (!query) {
      return res.status(400).json({ error: 'Query is required' });
    }

    if (!credentials?.dbParams || !credentials?.azureOpenAI) {
      return res.status(400).json({ error: 'Database and Azure OpenAI credentials are required' });
    }

    const { dbParams, azureOpenAI } = credentials;
    const { apiKey, azureEndpoint, apiVersion, deploymentName } = azureOpenAI;

    // Validate required parameters
    if (!dbParams.host || !dbParams.dbname || !dbParams.user || !dbParams.password) {
      return res.status(400).json({ error: 'Missing required database parameters' });
    }

    if (!apiKey || !azureEndpoint || !deploymentName) {
      return res.status(400).json({ error: 'Missing required Azure OpenAI parameters' });
    }

    // Initialize Azure OpenAI client 
    console.log(`Initializing Azure OpenAI client with endpoint: ${azureEndpoint} and deployment: ${deploymentName}`);
    const client = new OpenAIClient(
      azureEndpoint,
      new AzureKeyCredential(apiKey)
    );

    // Get embedding for the query
    console.log(`Getting embedding for query: "${query}"`);
    try {
      const { data } = await client.getEmbeddings(deploymentName, [query]);
      
      if (!data || data.length === 0) {
        console.error('Failed to obtain embeddings: No data returned');
        return res.status(500).json({ error: 'Failed to generate embeddings' });
      }
      
      const queryEmbedding = data[0].embedding;
      console.log(`Successfully obtained embedding of dimension: ${queryEmbedding.length}`);

      // Connect to PostgreSQL database
      console.log(`Connecting to PostgreSQL database: ${dbParams.host}/${dbParams.dbname}`);
      const pool = new Pool({
        user: dbParams.user,
        password: dbParams.password,
        host: dbParams.host,
        port: dbParams.port || 5432,
        database: dbParams.dbname,
        ssl: true
      });

      try {
        // Query database for semantic matches
        const sqlQuery = `
          SELECT 
            id, 
            scenario,
            category,
            sub_category,
            language,
            role,
            1 - (embedding <=> $1::vector) as similarity
          FROM ghc_prompts.prompt_scenarios
          ORDER BY similarity DESC
          LIMIT 10;
        `;

        const result = await pool.query(sqlQuery, [queryEmbedding]);
        console.log(`Search complete, found ${result.rows.length} results`);
        
        return res.status(200).json(result.rows);
      } catch (dbError) {
        console.error('Database error:', dbError);
        return res.status(500).json({ error: `Database error: ${dbError.message}` });
      } finally {
        // Always close pool to prevent connection leaks
        await pool.end();
      }
    } catch (embeddingError) {
      console.error('Error getting embeddings:', embeddingError);
      
      // Provide more detailed error information based on the error type
      let errorMessage = embeddingError.message || 'Unknown error';
      let statusCode = 500;

      // Handle specific Azure OpenAI errors
      if (embeddingError.statusCode === 404) {
        statusCode = 404;
        errorMessage = `Azure OpenAI API error: 404 - Deployment "${deploymentName}" not found. Please verify the deployment name is correct.`;
      } else if (embeddingError.statusCode === 401) {
        statusCode = 401;
        errorMessage = 'Azure OpenAI API error: 401 - Unauthorized. Please verify your API key is correct.';
      } else if (embeddingError.statusCode === 429) {
        statusCode = 429;
        errorMessage = 'Azure OpenAI API error: 429 - Too many requests. Please try again later.';
      }
      
      return res.status(statusCode).json({ error: errorMessage });
    }
  } catch (error) {
    console.error('Unhandled error in semantic search API:', error);
    return res.status(500).json({ error: `Unhandled error: ${error.message || 'Unknown error'}` });
  }
};