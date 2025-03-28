import React, { useState } from 'react';

interface SearchResult {
  id?: string;
  similarity?: number;
  score?: number;
  category?: string;
  sub_category?: string;
  language?: string;
  role?: string;
  scenario?: string;
}

interface SearchResultsFormatterProps {
  results: SearchResult[];
  apiEndpoint?: string;
}

const SearchResultsFormatter: React.FC<SearchResultsFormatterProps> = ({ results, apiEndpoint = '/api/format-search-results' }) => {
  const [formattedResults, setFormattedResults] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const formatResults = async () => {
    if (!results.length) {
      setError('No results to format');
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch(apiEndpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ results }),
      });

      if (!response.ok) {
        throw new Error(`Server responded with status: ${response.status}`);
      }

      const data = await response.json();
      setFormattedResults(data.formattedResults || '');
    } catch (err) {
      setError(`Error formatting results: ${err instanceof Error ? err.message : 'Unknown error'}`);
      console.error('Error formatting search results:', err);
    } finally {
      setIsLoading(false);
    }
  };

  const copyToClipboard = () => {
    if (formattedResults) {
      navigator.clipboard.writeText(formattedResults)
        .then(() => {
          alert('Results copied to clipboard!');
        })
        .catch(err => {
          console.error('Failed to copy text: ', err);
          alert('Failed to copy text. Please try again.');
        });
    }
  };

  return (
    <div className="search-results-formatter">
      <h3>Search Results Formatter</h3>
      
      <div className="button-group">
        <button 
          onClick={formatResults} 
          disabled={isLoading || results.length === 0}
        >
          {isLoading ? 'Formatting...' : 'Format Results'}
        </button>
        
        <button
          onClick={copyToClipboard}
          disabled={!formattedResults}
        >
          Copy to Clipboard
        </button>
      </div>
      
      {error && <div className="error-message">{error}</div>}
      
      {formattedResults && (
        <div className="formatted-results">
          <h4>Formatted Results:</h4>
          <pre style={{ textAlign: 'left', whiteSpace: 'pre-wrap', fontFamily: 'monospace' }}>
            {formattedResults}
          </pre>
        </div>
      )}
    </div>
  );
};

export default SearchResultsFormatter;