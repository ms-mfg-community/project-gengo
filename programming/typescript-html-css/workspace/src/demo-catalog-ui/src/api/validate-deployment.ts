// filepath: c:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\typescript-html-css\workspace\src\demo-catalog-ui\src\api\validate-deployment.ts
import { OpenAI } from 'openai';
import { Request, Response } from 'express';

interface ValidationRequest {
  credentials: {
    azureOpenAI: {
      apiVersion: string;
      azureEndpoint: string;
      apiKey: string;
      deploymentName: string;
    }
  }
}

export default async function handler(req: Request, res: Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { credentials } = req.body as ValidationRequest;

    if (!credentials || !credentials.azureOpenAI) {
      return res.status(400).json({ 
        error: 'Missing required credentials',
        valid: false
      });
    }

    const { apiKey, azureEndpoint, apiVersion, deploymentName } = credentials.azureOpenAI;

    if (!apiKey || !azureEndpoint || !deploymentName) {
      return res.status(400).json({ 
        error: 'Missing required Azure OpenAI parameters',
        valid: false
      });
    }

    // Initialize OpenAI client with Azure configuration
    const client = new OpenAI({
      apiKey: apiKey,
      baseURL: `${azureEndpoint}/openai/deployments/${deploymentName}`,
      defaultQuery: { 'api-version': apiVersion },
      defaultHeaders: { 'api-key': apiKey }
    });

    // Get models or perform a simple operation to validate the deployment
    // For embeddings models, we'll attempt to create a simple embedding
    try {
      if (deploymentName.includes('embedding')) {
        // Test with a simple embedding if it's an embedding model
        await client.embeddings.create({
          input: "Test validation",
          model: deploymentName
        });
      } else {
        // For other models, try a simple completion
        await client.completions.create({
          model: deploymentName,
          prompt: "Hello",
          max_tokens: 5
        });
      }

      // If successful, get available deployments (optional feature)
      let availableDeployments = [];
      try {
        // This endpoint might not work with Azure OpenAI, so we wrap in try/catch
        const models = await fetch(`${azureEndpoint}/openai/deployments?api-version=${apiVersion}`, {
          headers: {
            'api-key': apiKey
          }
        });
        
        if (models.ok) {
          const modelsData = await models.json();
          availableDeployments = modelsData.data.map((deployment: any) => ({
            id: deployment.id,
            model: deployment.model
          }));
        }
      } catch (error) {
        console.log('Could not fetch available deployments, continuing with validation');
      }

      return res.status(200).json({ 
        valid: true, 
        message: 'Deployment validated successfully',
        availableDeployments 
      });
    } catch (error) {
      return res.status(400).json({
        valid: false,
        message: `Invalid deployment: ${error instanceof Error ? error.message : 'Unknown error'}`
      });
    }
  } catch (error) {
    console.error('Deployment validation error:', error);
    return res.status(500).json({ 
      valid: false,
      message: `Validation failed: ${error instanceof Error ? error.message : 'Unknown error'}`
    });
  }
}