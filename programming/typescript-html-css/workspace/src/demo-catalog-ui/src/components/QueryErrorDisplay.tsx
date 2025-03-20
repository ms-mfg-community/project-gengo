import React from 'react';

interface QueryErrorDisplayProps {
  error: string;
}

export const QueryErrorDisplay: React.FC<QueryErrorDisplayProps> = ({ error }) => {
  return (
    <div className="query-error">
      <h3>Database Query Error</h3>
      <p>{error}</p>
    </div>
  );
};