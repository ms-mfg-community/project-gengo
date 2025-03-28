import React, { useState, useRef, useEffect } from 'react';
import './SearchChat.css';

interface SearchResult {
  id: number;
  scenario: string;
  category: string;
  sub_category: string;
  language: string;
  role: string;
  similarity: number;
  ide?: string;
  reference?: string;
}

type MessageType = 'user' | 'system' | 'results';

interface Message {
  id: string;
  type: MessageType;
  content: string;
  timestamp: Date;
  results?: SearchResult[];
}

interface ConfigurationCredentials {
  modelDeploymentKey: string;
  mainDatabasePassword: string;
  azureEndpoint: string;
  apiVersion: string;
  deploymentName: string;
}

const SearchChat: React.FC = () => {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 'welcome',
      type: 'system',
      content: 'Welcome to Demo Catalog Search! Please configure your credentials to begin searching.',
      timestamp: new Date()
    }
  ]);
  const [inputValue, setInputValue] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isConfigured, setIsConfigured] = useState(false);
  const [showConfiguration, setShowConfiguration] = useState(true);
  const [validationInProgress, setValidationInProgress] = useState(false);
  const [deploymentValidated, setDeploymentValidated] = useState(false);
  const [availableDeployments, setAvailableDeployments] = useState<Array<{ id: string, model: string }>>([]);
  const [credentials, setCredentials] = useState<ConfigurationCredentials>({
    modelDeploymentKey: '',
    mainDatabasePassword: '',
    azureEndpoint: 'https://admin-m8i1oz7d-eastus.openai.azure.com',
    apiVersion: '2024-06-01', // Updated to a more common version
    deploymentName: 'text-embedding-ada-002'
  });
  const messageEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const scrollToBottom = () => {
    messageEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setInputValue(e.target.value);
  };

  const handleCredentialChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setCredentials(prev => ({
      ...prev,
      [name]: value
    }));

    // Reset validation state when credentials change
    if (name === 'modelDeploymentKey' || name === 'azureEndpoint' || name === 'deploymentName') {
      setDeploymentValidated(false);
    }
  };

  const validateDeployment = async (): Promise<boolean> => {
    setValidationInProgress(true);
    try {
      console.log('Validating deployment:', credentials.deploymentName);
      
      // Create a basic validation request to check if the deployment exists
      const response = await fetch('/api/validate-deployment', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          credentials: {
            azureOpenAI: {
              apiVersion: credentials.apiVersion,
              azureEndpoint: credentials.azureEndpoint,
              apiKey: credentials.modelDeploymentKey,
              deploymentName: credentials.deploymentName
            }
          }
        })
      });
      
      if (response.ok) {
        const validationData = await response.json();
        if (validationData.valid) {
          setDeploymentValidated(true);
          
          // Store available deployments if provided
          if (validationData.availableDeployments) {
            setAvailableDeployments(validationData.availableDeployments);
          }
          
          // Add a system message indicating successful validation
          const validationSuccessMessage: Message = {
            id: `validation-success-${Date.now()}`,
            type: 'system',
            content: `Deployment "${credentials.deploymentName}" successfully validated!`,
            timestamp: new Date()
          };
          
          setMessages(prev => [...prev, validationSuccessMessage]);
          return true;
        } else {
          throw new Error(validationData.message || 'Deployment validation failed');
        }
      } else {
        const errorText = await response.text();
        throw new Error(`Validation failed: ${response.status} ${errorText || response.statusText}`);
      }
    } catch (error) {
      console.error('Deployment validation error:', error);
      const errorMessage: Message = {
        id: `validation-error-${Date.now()}`,
        type: 'system',
        content: `Deployment validation failed: ${error instanceof Error ? error.message : 'Unknown error'}. Please check your deployment name and API key.`,
        timestamp: new Date()
      };
      
      setMessages(prev => [...prev, errorMessage]);
      return false;
    } finally {
      setValidationInProgress(false);
    }
  };

  const handleConfigSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (credentials.modelDeploymentKey && 
        credentials.mainDatabasePassword &&
        credentials.azureEndpoint) {
      
      // First validate the deployment before completing configuration
      validateDeployment().then(isValid => {
        if (isValid) {
          setIsConfigured(true);
          setShowConfiguration(false);
          
          // Add a system message indicating successful configuration
          const configSuccessMessage: Message = {
            id: `config-success-${Date.now()}`,
            type: 'system',
            content: 'Configuration complete! You can now start searching the demo catalog.',
            timestamp: new Date()
          };
          
          setMessages(prev => [...prev, configSuccessMessage]);
        }
      });
    }
  };

  const handleSelectDeployment = (deploymentId: string) => {
    setCredentials(prev => ({
      ...prev,
      deploymentName: deploymentId
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!inputValue.trim()) return;

    const userMessage: Message = {
      id: Date.now().toString(),
      type: 'user',
      content: inputValue,
      timestamp: new Date()
    };

    setMessages(prev => [...prev, userMessage]);
    setInputValue('');
    setIsLoading(true);

    try {
      // Add debugging message to help troubleshoot
      console.log('Sending search request with query:', userMessage.content);
      console.log('Using credentials:', {
        dbname: "ghc_prompts",
        user: "ztmadmin",
        host: "pfs-sql-01.postgres.database.azure.com",
        // Password and API key hidden for security
        azureEndpoint: credentials.azureEndpoint,
        apiVersion: credentials.apiVersion,
        deploymentName: credentials.deploymentName
      });

      // Prepare the request body according to the Python script's DB_PARAMS and Azure OpenAI client
      const response = await fetch('/api/semantic-search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 
          query: userMessage.content,
          credentials: {
            // Database credentials following the structure in the Python script
            dbParams: {
              dbname: "ghc_prompts",
              user: "ztmadmin",
              password: credentials.mainDatabasePassword,
              host: "pfs-sql-01.postgres.database.azure.com",
              port: "5432"
            },
            // Azure OpenAI configuration
            azureOpenAI: {
              apiVersion: credentials.apiVersion,
              azureEndpoint: credentials.azureEndpoint,
              apiKey: credentials.modelDeploymentKey,
              deploymentName: credentials.deploymentName
            }
          }
        })
      });

      // Add detailed error information
      if (!response.ok) {
        const errorText = await response.text();
        console.error('Search request failed with status:', response.status);
        console.error('Error details:', errorText);
        throw new Error(`Search request failed: ${response.status} ${errorText || response.statusText}`);
      }

      const searchResults: SearchResult[] = await response.json();
      console.log('Received search results:', searchResults);
      
      const resultsMessage: Message = {
        id: `results-${Date.now()}`,
        type: 'results',
        content: 'Here are the search results:',
        timestamp: new Date(),
        results: searchResults
      };

      setMessages(prev => [...prev, resultsMessage]);
    } catch (error) {
      console.error('Error in handleSubmit:', error);
      const errorMessage: Message = {
        id: `error-${Date.now()}`,
        type: 'system',
        content: `Sorry, an error occurred: ${error instanceof Error ? error.message : 'Unknown error'}`,
        timestamp: new Date()
      };

      setMessages(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  const formatTimestamp = (date: Date) => {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  };

  return (
    <div className="search-chat-container">
      <div className="chat-header">
        <h2>Demo Catalog Search</h2>
        {isConfigured && (
          <button 
            className="reconfigure-button"
            onClick={() => setShowConfiguration(true)}>
            Configure
          </button>
        )}
      </div>
      
      {showConfiguration && (
        <form className="configuration-form" onSubmit={handleConfigSubmit}>
          <h3>Configuration</h3>
          <div className="config-section">
            <h4>Azure OpenAI Configuration</h4>
            <input
              type="password"
              name="modelDeploymentKey"
              value={credentials.modelDeploymentKey}
              onChange={handleCredentialChange}
              placeholder="Azure OpenAI API Key"
              required
            />
            <input
              type="text"
              name="azureEndpoint"
              value={credentials.azureEndpoint}
              onChange={handleCredentialChange}
              placeholder="Azure Endpoint"
              required
            />
            <input
              type="text"
              name="apiVersion"
              value={credentials.apiVersion}
              onChange={handleCredentialChange}
              placeholder="API Version"
              required
            />
            <div className="deployment-input-container">
              <input
                type="text"
                name="deploymentName"
                value={credentials.deploymentName}
                onChange={handleCredentialChange}
                placeholder="Deployment Name (e.g., text-embedding-ada-002)"
                required
              />
              <button 
                type="button" 
                onClick={validateDeployment}
                disabled={!credentials.modelDeploymentKey || !credentials.azureEndpoint || !credentials.deploymentName || validationInProgress}
                className="validate-button"
              >
                {validationInProgress ? 'Validating...' : 'Validate Deployment'}
              </button>
            </div>
            
            {deploymentValidated && (
              <div className="validation-success">
                ✓ Deployment validated successfully
              </div>
            )}
            
            {availableDeployments.length > 0 && (
              <div className="available-deployments">
                <h5>Available Deployments:</h5>
                <ul>
                  {availableDeployments.map(deployment => (
                    <li key={deployment.id} onClick={() => handleSelectDeployment(deployment.id)}>
                      {deployment.id} ({deployment.model})
                    </li>
                  ))}
                </ul>
              </div>
            )}
          </div>
          
          <div className="config-section">
            <h4>Database Configuration</h4>
            <input
              type="password"
              name="mainDatabasePassword"
              value={credentials.mainDatabasePassword}
              onChange={handleCredentialChange}
              placeholder="Main Database Password"
              required
            />
          </div>
          
          <button 
            type="submit" 
            disabled={!credentials.modelDeploymentKey || !credentials.mainDatabasePassword || !credentials.azureEndpoint || validationInProgress}
          >
            {validationInProgress ? 'Validating...' : 'Submit'}
          </button>
        </form>
      )}

      <div className="messages-container">
        {messages.map(message => (
          <div key={message.id} className={`message ${message.type}`}>
            <div className="message-header">
              <span className="message-sender">
                {message.type === 'user' ? 'You' : 'Demo Search'}
              </span>
              <span className="message-time">{formatTimestamp(message.timestamp)}</span>
            </div>
            
            <div className="message-content">
              {message.content}
              
              {message.type === 'results' && message.results && (
                <div className="search-results">
                  {message.results.length === 0 ? (
                    <p>No matching results found.</p>
                  ) : (
                    message.results.map((result, index) => (
                      <div key={result.id} className="result-item">
                        <h4>Result {index + 1} - Score: {result.similarity.toFixed(4)}</h4>
                        <div className="result-details">
                          <p><strong>Category:</strong> {result.category} / {result.sub_category}</p>
                          <p><strong>Language:</strong> {result.language}</p>
                          <p><strong>Role:</strong> {result.role}</p>
                          <p className="result-scenario">
                            <strong>Scenario:</strong> {result.scenario.length > 150 
                              ? `${result.scenario.substring(0, 150)}...` 
                              : result.scenario}
                          </p>
                          
                          {result.ide && <span className="ide-tag">{result.ide}</span>}
                          
                          {result.reference && (
                            <a 
                              href={result.reference}
                              target="_blank"
                              rel="noopener noreferrer"
                              className="reference-link"
                            >
                              Reference Documentation
                            </a>
                          )}
                        </div>
                      </div>
                    ))
                  )}
                </div>
              )}
            </div>
          </div>
        ))}
        
        {isLoading && (
          <div className="message system loading">
            <div className="loading-indicator">
              <div className="dot"></div>
              <div className="dot"></div>
              <div className="dot"></div>
            </div>
          </div>
        )}
        
        <div ref={messageEndRef} />
      </div>
      
      <form className="input-container" onSubmit={handleSubmit}>
        <input
          type="text"
          value={inputValue}
          onChange={handleInputChange}
          placeholder="Describe what you're looking for..."
          disabled={isLoading || !isConfigured}
        />
        <button type="submit" disabled={isLoading || !inputValue.trim() || !isConfigured}>
          {isLoading ? 'Searching...' : 'Search'}
        </button>
      </form>
    </div>
  );
};

export default SearchChat;
