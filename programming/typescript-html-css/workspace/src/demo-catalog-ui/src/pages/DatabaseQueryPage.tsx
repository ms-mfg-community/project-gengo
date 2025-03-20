import React, { useState, useEffect } from 'react';
import '../styles/DatabaseQueryPage.css';

interface QueryResult {
  id: number;
  [key: string]: any;
}

interface TableInfo {
  name: string;
  columns: ColumnInfo[];
}

interface ColumnInfo {
  name: string;
  dataType: string;
}

interface FilterCondition {
  column: string;
  operator: string;
  value: string;
}

const DatabaseQueryPage: React.FC = () => {
  // Database structure state
  const [tables, setTables] = useState<TableInfo[]>([]);
  const [isLoadingSchema, setIsLoadingSchema] = useState(false);
  
  // Query builder state
  const [selectedTable, setSelectedTable] = useState<string>('');
  const [selectedColumns, setSelectedColumns] = useState<string[]>([]);
  const [filterConditions, setFilterConditions] = useState<FilterCondition[]>([]);
  const [sortColumn, setSortColumn] = useState<string>('');
  const [sortDirection, setSortDirection] = useState<'ASC' | 'DESC'>('ASC');
  const [limit, setLimit] = useState<number>(100);
  
  // Results state
  const [results, setResults] = useState<QueryResult[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [generatedQuery, setGeneratedQuery] = useState<string>('');

  // Available operators for filter conditions
  const operators = ['=', '!=', '>', '<', '>=', '<=', 'LIKE', 'IN', 'NOT IN', 'IS NULL', 'IS NOT NULL'];

  // Fetch tables and their columns on component mount
  useEffect(() => {
    fetchDatabaseSchema();
  }, []);

  const fetchDatabaseSchema = async () => {
    setIsLoadingSchema(true);
    try {
      const response = await fetch('/api/schema');
      if (!response.ok) {
        throw new Error(`Error: ${response.statusText}`);
      }
      const data = await response.json();
      setTables(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load database schema');
    } finally {
      setIsLoadingSchema(false);
    }
  };

  const handleTableChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const tableName = e.target.value;
    setSelectedTable(tableName);
    setSelectedColumns([]);
    setFilterConditions([]);
    setSortColumn('');
  };

  const handleColumnSelectChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const options = e.target.options;
    const selectedOptions: string[] = [];
    
    for (let i = 0; i < options.length; i++) {
      if (options[i].selected) {
        selectedOptions.push(options[i].value);
      }
    }
    
    setSelectedColumns(selectedOptions);
  };

  const handleSelectAllColumns = () => {
    const table = tables.find(t => t.name === selectedTable);
    if (table) {
      setSelectedColumns(table.columns.map(col => col.name));
    }
  };

  const handleClearAllColumns = () => {
    setSelectedColumns([]);
  };

  const addFilterCondition = () => {
    const table = tables.find(t => t.name === selectedTable);
    if (table && table.columns.length > 0) {
      setFilterConditions([
        ...filterConditions,
        {
          column: table.columns[0].name,
          operator: '=',
          value: ''
        }
      ]);
    }
  };

  const removeFilterCondition = (index: number) => {
    setFilterConditions(filterConditions.filter((_, i) => i !== index));
  };

  const updateFilterCondition = (index: number, field: keyof FilterCondition, value: string) => {
    const updatedFilters = [...filterConditions];
    updatedFilters[index] = {
      ...updatedFilters[index],
      [field]: value
    };
    setFilterConditions(updatedFilters);
  };

  const buildQuery = (): string => {
    if (!selectedTable || selectedColumns.length === 0) {
      return '';
    }

    // Build the SELECT clause
    let query = `SELECT ${selectedColumns.join(', ')} FROM ${selectedTable}`;
    
    // Add WHERE clause if there are filter conditions
    if (filterConditions.length > 0) {
      const conditions = filterConditions
        .filter(condition => condition.column && condition.operator)
        .map(condition => {
          if (['IS NULL', 'IS NOT NULL'].includes(condition.operator)) {
            return `${condition.column} ${condition.operator}`;
          } else if (['IN', 'NOT IN'].includes(condition.operator)) {
            // For IN operators, split the comma-separated values
            const values = condition.value.split(',').map(v => `'${v.trim()}'`).join(', ');
            return `${condition.column} ${condition.operator} (${values})`;
          } else if (condition.operator === 'LIKE') {
            return `${condition.column} LIKE '%${condition.value}%'`;
          } else {
            return `${condition.column} ${condition.operator} '${condition.value}'`;
          }
        });
      
      if (conditions.length > 0) {
        query += ` WHERE ${conditions.join(' AND ')}`;
      }
    }
    
    // Add ORDER BY clause if a sort column is selected
    if (sortColumn) {
      query += ` ORDER BY ${sortColumn} ${sortDirection}`;
    }
    
    // Add LIMIT clause
    query += ` LIMIT ${limit}`;
    
    return query;
  };

  const executeQuery = async () => {
    const query = buildQuery();
    if (!query) {
      setError('Please select a table and at least one column');
      return;
    }

    setGeneratedQuery(query);
    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch('/api/query', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ query }),
      });

      const data = await response.json();

      if (!response.ok) {
        // Handle error response that's properly formatted as JSON
        const errorMessage = data.error || 'An unknown error occurred';
        throw new Error(errorMessage);
      }

      // If we get here, the response was successful
      setResults(Array.isArray(data) ? data : []);
      setError(null);
    } catch (err) {
      // Handle both network errors and application errors
      const errorMessage = err instanceof Error ? err.message : 'Failed to execute query';
      setError(errorMessage);
      setResults([]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="database-query-page">
      <h1>Database Query Builder</h1>
      
      {isLoadingSchema ? (
        <div className="loading-message">Loading database schema...</div>
      ) : (
        <div className="query-builder">
          <div className="query-section">
            <h2>1. Select Table</h2>
            <select 
              className="table-select"
              value={selectedTable}
              onChange={handleTableChange}
            >
              <option value="">-- Select a table --</option>
              {tables.map(table => (
                <option key={table.name} value={table.name}>
                  {table.name}
                </option>
              ))}
            </select>
          </div>

          {selectedTable && (
            <div className="query-section">
              <h2>2. Select Columns</h2>
              <div className="column-selector-container">
                <select 
                  className="column-selector"
                  multiple
                  value={selectedColumns}
                  onChange={handleColumnSelectChange}
                >
                  {tables
                    .find(t => t.name === selectedTable)?.columns
                    .map(column => (
                      <option key={column.name} value={column.name}>
                        {column.name} ({column.dataType})
                      </option>
                    ))}
                </select>
                <div className="column-selector-actions">
                  <button 
                    className="select-all-button"
                    onClick={handleSelectAllColumns}
                  >
                    Select All
                  </button>
                  <button 
                    className="clear-all-button"
                    onClick={handleClearAllColumns}
                  >
                    Clear All
                  </button>
                </div>
              </div>
            </div>
          )}

          {selectedTable && (
            <div className="query-section">
              <h2>3. Filter Conditions (Optional)</h2>
              <div className="filter-conditions">
                {filterConditions.map((condition, index) => (
                  <div key={index} className="filter-condition">
                    <select
                      value={condition.column}
                      onChange={(e) => updateFilterCondition(index, 'column', e.target.value)}
                    >
                      {tables
                        .find(t => t.name === selectedTable)?.columns
                        .map(column => (
                          <option key={column.name} value={column.name}>
                            {column.name}
                          </option>
                        ))}
                    </select>
                    
                    <select
                      value={condition.operator}
                      onChange={(e) => updateFilterCondition(index, 'operator', e.target.value)}
                    >
                      {operators.map(op => (
                        <option key={op} value={op}>{op}</option>
                      ))}
                    </select>
                    
                    {!['IS NULL', 'IS NOT NULL'].includes(condition.operator) && (
                      <input
                        type="text"
                        value={condition.value}
                        onChange={(e) => updateFilterCondition(index, 'value', e.target.value)}
                        placeholder="Value"
                      />
                    )}
                    
                    <button 
                      className="remove-filter-button"
                      onClick={() => removeFilterCondition(index)}
                    >
                      Remove
                    </button>
                  </div>
                ))}
                
                <button 
                  className="add-filter-button"
                  onClick={addFilterCondition}
                >
                  Add Filter
                </button>
              </div>
            </div>
          )}

          {selectedTable && (
            <div className="query-section">
              <h2>4. Sorting (Optional)</h2>
              <div className="sorting-options">
                <select
                  value={sortColumn}
                  onChange={(e) => setSortColumn(e.target.value)}
                >
                  <option value="">-- No sorting --</option>
                  {tables
                    .find(t => t.name === selectedTable)?.columns
                    .map(column => (
                      <option key={column.name} value={column.name}>
                        {column.name}
                      </option>
                    ))}
                </select>
                
                {sortColumn && (
                  <select
                    value={sortDirection}
                    onChange={(e) => setSortDirection(e.target.value as 'ASC' | 'DESC')}
                  >
                    <option value="ASC">Ascending</option>
                    <option value="DESC">Descending</option>
                  </select>
                )}
              </div>
            </div>
          )}

          {selectedTable && (
            <div className="query-section">
              <h2>5. Limit Results</h2>
              <input
                type="number"
                min="1"
                max="1000"
                value={limit}
                onChange={(e) => setLimit(parseInt(e.target.value))}
                className="limit-input"
              />
            </div>
          )}

          <div className="query-actions">
            <button 
              className="execute-button"
              onClick={executeQuery}
              disabled={isLoading || !selectedTable || selectedColumns.length === 0}
            >
              {isLoading ? 'Executing...' : 'Execute Query'}
            </button>
          </div>
          
          {error && <div className="error-message">{error}</div>}
          
          {generatedQuery && (
            <div className="generated-query">
              <h3>Generated SQL</h3>
              <pre>{generatedQuery}</pre>
            </div>
          )}
        </div>
      )}

      <div className="results-container">
        <h2>Query Results</h2>
        {results.length > 0 ? (
          <div className="results-table-container">
            <table className="results-table">
              <thead>
                <tr>
                  {Object.keys(results[0]).map((key) => (
                    <th key={key}>{key}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {results.map((row, rowIndex) => (
                  <tr key={rowIndex}>
                    {Object.values(row).map((value, colIndex) => (
                      <td key={colIndex}>
                        {typeof value === 'object' ? JSON.stringify(value) : value?.toString()}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p className="no-results">{isLoading ? 'Loading...' : 'No results to display'}</p>
        )}
      </div>
    </div>
  );
};

export default DatabaseQueryPage;