import { OpenAI } from 'openai';
import { Request, Response } from 'express';
import pg from 'pg';

interface SearchRequest {
  query: string;
  credentials: {
    dbParams: {
      dbname: string;
      user: string;
      password: string;
      host: string;
      port: string;
    };
    azureOpenAI: {
      apiVersion: string;
      azureEndpoint: string;
      apiKey: string;
    }
  }
}

export default async function handler(req: Request, res: Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { query, credentials } = req.body as SearchRequest;

    if (!query || !credentials) {
      return res.status(400).json({ error: 'Missing required parameters' });
    }

    // Initialize OpenAI client with Azure configuration, matching the Python script configuration
    const client = new OpenAI({
      apiKey: credentials.azureOpenAI.apiKey,
      baseURL: `${credentials.azureOpenAI.azureEndpoint}/openai/deployments/text-embedding-ada-002`,
      defaultQuery: { 'api-version': credentials.azureOpenAI.apiVersion },
      defaultHeaders: { 'api-key': credentials.azureOpenAI.apiKey }
    });

    // Generate embedding for the query
    const embeddingResponse = await client.embeddings.create({
      input: query,
      model: 'text-embedding-ada-002'
    });
    
    const queryEmbedding = embeddingResponse.data[0].embedding;

    // Connect to PostgreSQL database using the credentials from the frontend
    // which match the DB_PARAMS structure in the Python script
    const dbClient = new pg.Client({
      user: credentials.dbParams.user,
      host: credentials.dbParams.host,
      database: credentials.dbParams.dbname,
      password: credentials.dbParams.password,
      port: parseInt(credentials.dbParams.port, 10),
      ssl: true
    });

    await dbClient.connect();

    // Perform the semantic search using cosine similarity - same query as in Python script
    const searchQuery = `
      SELECT id, scenario, category, sub_category, language, role, 
             1 - (embedding <=> $1) AS similarity
      FROM demo_catalog
      WHERE embedding IS NOT NULL
      ORDER BY similarity DESC
      LIMIT 5;
    `;

    const searchResults = await dbClient.query(searchQuery, [JSON.stringify(queryEmbedding)]);
    await dbClient.end();

    return res.status(200).json(searchResults.rows);
  } catch (error) {
    console.error('Semantic search error:', error);
    return res.status(500).json({ 
      error: 'Failed to perform semantic search',
      details: error instanceof Error ? error.message : 'Unknown error'
    });
  }
}