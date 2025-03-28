import React, { useState } from 'react';
import SearchResultsFormatter from './SearchResultsFormatter';

interface SearchResult {
  id?: string;
  similarity?: number;
  score?: number;
  category?: string;
  sub_category?: string;
  language?: string;
  role?: string;
  scenario?: string;
  ide?: string;
  reference?: string;
}

interface Credentials {
  azureOpenAI: {
    apiKey: string;
    azureEndpoint: string;
    apiVersion: string;
    deploymentName: string;
  };
  dbParams: {
    user: string;
    host: string;
    dbname: string;
    password: string;
    port: number;
  };
}

const SearchPage: React.FC = () => {
  const [query, setQuery] = useState<string>('');
  const [results, setResults] = useState<SearchResult[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [showCredentialsForm, setShowCredentialsForm] = useState<boolean>(true);
  const [credentials, setCredentials] = useState<Credentials>({
    azureOpenAI: {
      apiKey: '',
      azureEndpoint: '',
      apiVersion: '2023-05-15',
      deploymentName: 'embedding-ada-002',
    },
    dbParams: {
      user: '',
      host: '',
      dbname: '',
      password: '',
      port: 5432,
    }
  });

  const handleSearch = async (event: React.FormEvent) => {
    event.preventDefault();
    
    if (!query.trim()) {
      setError('Please enter a search query');
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch('/api/semantic-search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ query, credentials }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || `Server responded with status: ${response.status}`);
      }

      const searchResults = await response.json();
      setResults(searchResults);
    } catch (err) {
      setError(`Error performing search: ${err instanceof Error ? err.message : 'Unknown error'}`);
      console.error('Error during semantic search:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleCredentialChange = (
    section: 'azureOpenAI' | 'dbParams',
    field: string,
    value: string | number
  ) => {
    setCredentials(prev => ({
      ...prev,
      [section]: {
        ...prev[section],
        [field]: value
      }
    }));
  };

  return (
    <div className="search-page">
      <h2>Semantic Search</h2>

      {showCredentialsForm ? (
        <div className="credentials-form">
          <h3>Configure Search Credentials</h3>
          
          <div className="form-section">
            <h4>Azure OpenAI Settings</h4>
            <div className="form-field">
              <label>API Key:</label>
              <input
                type="password"
                value={credentials.azureOpenAI.apiKey}
                onChange={(e) => handleCredentialChange('azureOpenAI', 'apiKey', e.target.value)}
              />
            </div>
            
            <div className="form-field">
              <label>Azure Endpoint:</label>
              <input
                type="text"
                value={credentials.azureOpenAI.azureEndpoint}
                onChange={(e) => handleCredentialChange('azureOpenAI', 'azureEndpoint', e.target.value)}
                placeholder="https://your-resource-name.openai.azure.com"
              />
            </div>
            
            <div className="form-field">
              <label>API Version:</label>
              <input
                type="text"
                value={credentials.azureOpenAI.apiVersion}
                onChange={(e) => handleCredentialChange('azureOpenAI', 'apiVersion', e.target.value)}
              />
            </div>
            
            <div className="form-field">
              <label>Deployment Name:</label>
              <input
                type="text"
                value={credentials.azureOpenAI.deploymentName}
                onChange={(e) => handleCredentialChange('azureOpenAI', 'deploymentName', e.target.value)}
              />
            </div>
          </div>
          
          <div className="form-section">
            <h4>Database Settings</h4>
            <div className="form-field">
              <label>User:</label>
              <input
                type="text"
                value={credentials.dbParams.user}
                onChange={(e) => handleCredentialChange('dbParams', 'user', e.target.value)}
              />
            </div>
            
            <div className="form-field">
              <label>Host:</label>
              <input
                type="text"
                value={credentials.dbParams.host}
                onChange={(e) => handleCredentialChange('dbParams', 'host', e.target.value)}
              />
            </div>
            
            <div className="form-field">
              <label>Database Name:</label>
              <input
                type="text"
                value={credentials.dbParams.dbname}
                onChange={(e) => handleCredentialChange('dbParams', 'dbname', e.target.value)}
              />
            </div>
            
            <div className="form-field">
              <label>Password:</label>
              <input
                type="password"
                value={credentials.dbParams.password}
                onChange={(e) => handleCredentialChange('dbParams', 'password', e.target.value)}
              />
            </div>
            
            <div className="form-field">
              <label>Port:</label>
              <input
                type="number"
                value={credentials.dbParams.port}
                onChange={(e) => handleCredentialChange('dbParams', 'port', parseInt(e.target.value) || 5432)}
              />
            </div>
          </div>
          
          <button onClick={() => setShowCredentialsForm(false)}>
            Continue to Search
          </button>
        </div>
      ) : (
        <>
          <form onSubmit={handleSearch} className="search-form">
            <div className="search-input-container">
              <input
                type="text"
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                placeholder="Enter search query..."
                className="search-input"
              />
              <button 
                type="submit" 
                disabled={isLoading || !query.trim()}
                className="search-button"
              >
                {isLoading ? 'Searching...' : 'Search'}
              </button>
            </div>
            <button 
              type="button"
              onClick={() => setShowCredentialsForm(true)}
              className="config-button"
            >
              Configure Credentials
            </button>
          </form>

          {error && <div className="error-message">{error}</div>}

          {results.length > 0 && (
            <div className="search-results">
              <h3>Search Results</h3>
              <div className="results-list">
                {results.map((result, index) => (
                  <div key={result.id || index} className="result-item">
                    <h4>Result {index + 1}</h4>
                    <p><strong>Similarity Score:</strong> {result.similarity?.toFixed(4) || 'N/A'}</p>
                    <p><strong>Category:</strong> {result.category || 'N/A'} {result.sub_category ? `/ ${result.sub_category}` : ''}</p>
                    <p><strong>Language:</strong> {result.language || 'N/A'}</p>
                    <p><strong>Role:</strong> {result.role || 'N/A'}</p>
                    <p><strong>Scenario:</strong> {result.scenario || 'N/A'}</p>
                    
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
                ))}
              </div>
              
              <SearchResultsFormatter results={results} />
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default SearchPage;