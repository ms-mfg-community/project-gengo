import React, { useState, useEffect } from 'react';

// Define the calculator data interface based on the database schema
interface CalculatorData {
  id: number;
  operation: string;
  operandA: number;
  operandB: number;
  result: string;
  status: string;
}

const QueryTestData: React.FC = () => {
  // State variables
  const [calculatorData, setCalculatorData] = useState<CalculatorData[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [filterOperation, setFilterOperation] = useState<string>('');
  const [filterStatus, setFilterStatus] = useState<string>('');

  // Fetch calculator data
  useEffect(() => {
    const fetchCalculatorData = async () => {
      setIsLoading(true);
      setError(null);
      
      try {
        // Make API call to backend endpoint to fetch calculator data
        const response = await fetch('/api/calculator-data');
        
        if (!response.ok) {
          throw new Error(`Error fetching data: ${response.statusText}`);
        }
        
        const data = await response.json();
        setCalculatorData(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An unknown error occurred');
        console.error('Error fetching calculator data:', err);
      } finally {
        setIsLoading(false);
      }
    };

    fetchCalculatorData();
  }, []);

  // Filter data based on selected filters
  const filteredData = calculatorData.filter(item => {
    const operationMatch = filterOperation ? item.operation === filterOperation : true;
    const statusMatch = filterStatus ? item.status === filterStatus : true;
    return operationMatch && statusMatch;
  });

  // Get unique operation values for filter dropdown
  const uniqueOperations = Array.from(new Set(calculatorData.map(item => item.operation)));
  
  // Get unique status values for filter dropdown
  const uniqueStatuses = Array.from(new Set(calculatorData.map(item => item.status)));

  // Custom styles for select elements and options
  const selectStyles = {
    color: 'black',
    backgroundColor: 'white'
  };
  
  const optionStyles = {
    color: 'black',
    backgroundColor: 'lightgray'
  };

  return (
    <div className="query-test-data" style={{ color: 'black' }}>
      <h1>Calculator Test Data</h1>
      
      {/* Filters */}
      <div className="filters">
        <div className="filter-group">
          <label htmlFor="operation-filter" style={{ color: 'black' }}>Filter by Operation:</label>
          <select 
            id="operation-filter" 
            value={filterOperation}
            onChange={(e) => setFilterOperation(e.target.value)}
            style={selectStyles}
          >
            <option value="" style={optionStyles}>All Operations</option>
            {uniqueOperations.map(op => (
              <option key={op} value={op} style={optionStyles}>{op}</option>
            ))}
          </select>
        </div>
        
        <div className="filter-group">
          <label htmlFor="status-filter" style={{ color: 'black' }}>Filter by Status:</label>
          <select 
            id="status-filter" 
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            style={selectStyles}
          >
            <option value="" style={optionStyles}>All Statuses</option>
            {uniqueStatuses.map(status => (
              <option key={status} value={status} style={optionStyles}>{status}</option>
            ))}
          </select>
        </div>
      </div>

      {/* Loading indicator */}
      {isLoading && <div className="loading" style={{ color: 'black' }}>Loading data...</div>}
      
      {/* Error message */}
      {error && <div className="error" style={{ color: 'black' }}>Error: {error}</div>}
      
      {/* Results table */}
      {!isLoading && !error && (
        <>
          <p style={{ color: 'black' }}>Total records: {filteredData.length}</p>
          <div className="table-container">
            <table className="data-table" style={{ color: 'black' }}>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Operation</th>
                  <th>Operand A</th>
                  <th>Operand B</th>
                  <th>Result</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {filteredData.length > 0 ? (
                  filteredData.map(item => (
                    <tr key={item.id}>
                      <td>{item.id}</td>
                      <td>{item.operation}</td>
                      <td>{item.operandA}</td>
                      <td>{item.operandB}</td>
                      <td>{item.result}</td>
                      <td>{item.status}</td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan={6}>No data found</td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </>
      )}
    </div>
  );
};

export default QueryTestData;