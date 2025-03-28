// API endpoint for validating Azure OpenAI deployments
// This endpoint checks if the specified deployment exists and is accessible

const { OpenAIClient, AzureKeyCredential } = require('@azure/openai');

module.exports = async (req, res) => {
  console.log('Validating Azure OpenAI deployment...');

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { credentials } = req.body;
    
    if (!credentials?.azureOpenAI) {
      return res.status(400).json({ 
        valid: false,
        message: 'Missing Azure OpenAI credentials' 
      });
    }

    const {
      apiKey,
      azureEndpoint,
      apiVersion,
      deploymentName
    } = credentials.azureOpenAI;

    if (!apiKey || !azureEndpoint || !deploymentName) {
      return res.status(400).json({
        valid: false,
        message: 'Missing required Azure OpenAI configuration parameters'
      });
    }

    // Create Azure OpenAI client to validate the deployment
    const client = new OpenAIClient(
      azureEndpoint, 
      new AzureKeyCredential(apiKey)
    );

    // Make a lightweight call to validate that the deployment exists
    // Using listDeployments if available, or try to get embeddings with minimal content
    try {
      // First try to get a list of deployments
      const deployments = await client.listDeployments();
      const foundDeployment = deployments.some(
        deployment => deployment.id === deploymentName || 
                      deployment.model === deploymentName
      );
      
      if (!foundDeployment) {
        console.log(`Deployment "${deploymentName}" not found in available deployments`);
        return res.status(404).json({
          valid: false,
          message: `Deployment "${deploymentName}" not found. Available deployments are: ${deployments.map(d => d.id).join(', ')}`
        });
      }
      
      console.log(`Deployment "${deploymentName}" validated successfully`);
      return res.status(200).json({
        valid: true,
        message: `Deployment "${deploymentName}" validated successfully`,
        availableDeployments: deployments.map(d => ({ id: d.id, model: d.model }))
      });
      
    } catch (listError) {
      console.log('Could not list deployments, trying to get embeddings instead:', listError);
      
      // If listing deployments fails, try to get embeddings with a minimal request
      try {
        const response = await client.getEmbeddings(deploymentName, ['test']);
        if (response && response.data && response.data.length > 0) {
          console.log(`Deployment "${deploymentName}" validated successfully via embeddings`);
          return res.status(200).json({
            valid: true,
            message: `Deployment "${deploymentName}" validated successfully via embeddings`
          });
        }
      } catch (embeddingsError) {
        console.error('Embedding validation error:', embeddingsError);
        return res.status(404).json({
          valid: false,
          message: `Deployment validation failed: ${embeddingsError.message || 'Unknown error'}`
        });
      }
    }

  } catch (error) {
    console.error('Error validating deployment:', error);
    const statusCode = error.statusCode || 500;
    const errorMessage = error.message || 'Unknown error occurred';
    
    return res.status(statusCode).json({
      valid: false,
      message: `Deployment validation error: ${errorMessage}`
    });
  }
};