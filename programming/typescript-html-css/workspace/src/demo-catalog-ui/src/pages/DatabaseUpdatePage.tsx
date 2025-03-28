import React, { useState, useEffect, useMemo } from 'react';
import '../styles/DatabaseUpdatePage.css';

interface TableInfo {
  name: string;
  columns: ColumnInfo[];
}

interface ColumnInfo {
  name: string;
  dataType: string;
}

interface RecordData {
  [key: string]: any;
}

interface SortConfig {
  key: string;
  direction: 'ascending' | 'descending' | null;
}

/**
 * DatabaseUpdatePage component that provides functionality to update and delete
 * database records through a user-friendly interface.
 */
const DatabaseUpdatePage: React.FC = () => {
  // State for database structure
  const [tables, setTables] = useState<TableInfo[]>([]);
  const [isLoadingSchema, setIsLoadingSchema] = useState(false);
  
  // State for table and record selection
  const [selectedTable, setSelectedTable] = useState<string>('');
  const [tableData, setTableData] = useState<RecordData[]>([]);
  const [selectedRecord, setSelectedRecord] = useState<RecordData | null>(null);
  
  // State for editing
  const [editedRecord, setEditedRecord] = useState<RecordData | null>(null);
  
  // State for UI feedback
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);
  const [confirmDelete, setConfirmDelete] = useState(false);
  
  // State for sorting
  const [sortConfig, setSortConfig] = useState<SortConfig>({
    key: '',
    direction: null
  });

  // Fetch tables and their columns on component mount
  useEffect(() => {
    fetchDatabaseSchema();
  }, []);

  // Fetch table data when a table is selected
  useEffect(() => {
    if (selectedTable) {
      fetchTableData(selectedTable);
    } else {
      setTableData([]);
      setSelectedRecord(null);
      setEditedRecord(null);
    }
  }, [selectedTable]);

  /**
   * Fetches the database schema (tables and columns) from the API
   */
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

  /**
   * Fetches data for the selected table
   * @param tableName Name of the table to fetch data from
   */
  const fetchTableData = async (tableName: string) => {
    setIsLoading(true);
    try {
      const response = await fetch(`/api/data/${tableName}`);
      if (!response.ok) {
        throw new Error(`Error: ${response.statusText}`);
      }
      const data = await response.json();
      setTableData(data);
      setError(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load table data');
      setTableData([]);
    } finally {
      setIsLoading(false);
    }
  };

  /**
   * Handles table selection change
   */
  const handleTableChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const tableName = e.target.value;
    setSelectedTable(tableName);
    setSelectedRecord(null);
    setEditedRecord(null);
    clearMessages();
  };

  /**
   * Handles record selection for editing or deletion
   */
  const handleRecordSelect = (record: RecordData) => {
    setSelectedRecord(record);
    setEditedRecord({ ...record });
    setConfirmDelete(false);
    clearMessages();
  };

  /**
   * Handles changes to the form fields when editing a record
   */
  const handleFieldChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    if (!editedRecord) return;
    
    const { name, value, type } = e.target as HTMLInputElement;
    let parsedValue: any = value;
    
    // Convert values based on input type
    if (type === 'checkbox') {
      parsedValue = (e.target as HTMLInputElement).checked;
    } else if (type === 'number') {
      // Keep it as a string initially, but will be converted to number during API call
      parsedValue = value === '' ? null : value;
    }
    
    setEditedRecord({
      ...editedRecord,
      [name]: parsedValue
    });
  };

  /**
   * Handles the update of a record
   */
  const handleUpdateRecord = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editedRecord || !selectedTable) return;
    
    setIsLoading(true);
    clearMessages();
    
    try {
      const response = await fetch(`/api/update/${selectedTable}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(editedRecord)
      });
      
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to update record');
      }
      
      // Refresh table data to show the updated record
      await fetchTableData(selectedTable);
      setSuccessMessage('Record updated successfully');
      setSelectedRecord(null);
      setEditedRecord(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to update record');
    } finally {
      setIsLoading(false);
    }
  };

  /**
   * Handles the deletion of a record
   */
  const handleDeleteRecord = async () => {
    if (!selectedRecord || !selectedTable) return;
    
    setIsLoading(true);
    clearMessages();
    
    try {
      // For demo_catalog table, we use the ID as the primary key
      const idField = 'id';
      const idValue = selectedRecord[idField];
      
      const response = await fetch(`/api/delete/${selectedTable}/${idField}/${idValue}`, {
        method: 'DELETE'
      });
      
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to delete record');
      }
      
      // Refresh table data to remove the deleted record
      await fetchTableData(selectedTable);
      setSuccessMessage('Record deleted successfully');
      setSelectedRecord(null);
      setEditedRecord(null);
      setConfirmDelete(false);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to delete record');
    } finally {
      setIsLoading(false);
    }
  };

  /**
   * Clears success and error messages
   */
  const clearMessages = () => {
    setError(null);
    setSuccessMessage(null);
  };

  /**
   * Handles sorting when a column header is clicked
   */
  const requestSort = (key: string) => {
    let direction: 'ascending' | 'descending' | null = 'ascending';
    
    if (sortConfig.key === key) {
      if (sortConfig.direction === 'ascending') {
        direction = 'descending';
      } else if (sortConfig.direction === 'descending') {
        direction = null;
      }
    }
    
    setSortConfig({ key, direction });
  };

  /**
   * Sorts the table data based on current sort configuration
   */
  const sortedData = useMemo(() => {
    if (!sortConfig.key || !sortConfig.direction) {
      return tableData;
    }

    return [...tableData].sort((a, b) => {
      // Handle null values
      if (a[sortConfig.key] === null) return 1;
      if (b[sortConfig.key] === null) return -1;
      
      // Compare based on type
      if (typeof a[sortConfig.key] === 'string') {
        // Case-insensitive string comparison
        const valA = a[sortConfig.key].toLowerCase();
        const valB = b[sortConfig.key].toLowerCase();
        
        if (valA < valB) {
          return sortConfig.direction === 'ascending' ? -1 : 1;
        }
        if (valA > valB) {
          return sortConfig.direction === 'ascending' ? 1 : -1;
        }
        return 0;
      } else {
        // Numeric or other comparison
        if (a[sortConfig.key] < b[sortConfig.key]) {
          return sortConfig.direction === 'ascending' ? -1 : 1;
        }
        if (a[sortConfig.key] > b[sortConfig.key]) {
          return sortConfig.direction === 'ascending' ? 1 : -1;
        }
        return 0;
      }
    });
  }, [tableData, sortConfig]);

  /**
   * Renders form fields based on column data types
   */
  const renderFormField = (column: ColumnInfo) => {
    if (!editedRecord) return null;
    
    const value = editedRecord[column.name] ?? '';
    
    // Handle boolean fields
    if (column.dataType === 'boolean') {
      return (
        <div className="form-group" key={column.name}>
          <label className="checkbox-label">
            <input 
              type="checkbox" 
              name={column.name} 
              checked={!!value} 
              onChange={handleFieldChange} 
            />
            {column.name}
          </label>
        </div>
      );
    }
    
    // Handle text areas for longer text fields
    if (column.dataType === 'text' || column.dataType.includes('varchar') && column.name === 'notes') {
      return (
        <div className="form-group" key={column.name}>
          <label htmlFor={column.name}>
            <span className="field-name">{column.name}</span>
          </label>
          <textarea 
            id={column.name}
            name={column.name} 
            value={value || ''} 
            onChange={handleFieldChange}
            rows={4}
          />
        </div>
      );
    }
    
    // Handle number fields
    if (column.dataType === 'integer' || column.dataType.includes('int')) {
      return (
        <div className="form-group" key={column.name}>
          <label htmlFor={column.name}>
            <span className="field-name">{column.name}</span>
          </label>
          <input 
            type="number" 
            id={column.name}
            name={column.name} 
            value={value || ''} 
            onChange={handleFieldChange} 
          />
        </div>
      );
    }
    
    // Default text input for other field types
    return (
      <div className="form-group" key={column.name}>
        <label htmlFor={column.name}>
          <span className="field-name">{column.name}</span>
        </label>
        <input 
          type="text" 
          id={column.name}
          name={column.name} 
          value={value || ''} 
          onChange={handleFieldChange} 
        />
      </div>
    );
  };

  return (
    <div className="database-update-page">
      <h1>Update Database Records</h1>
      
      {/* Table Selection */}
      <div className="table-selection-section">
        <h2>1. Select Table</h2>
        {isLoadingSchema ? (
          <div className="loading-message">Loading database schema...</div>
        ) : (
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
        )}
      </div>
      
      {/* Display table data */}
      {selectedTable && (
        <div className="data-section">
          <h2>2. Select Record to Update or Delete</h2>
          
          {isLoading ? (
            <div className="loading-message">Loading data...</div>
          ) : tableData.length === 0 ? (
            <div className="no-records">No records found in this table</div>
          ) : (
            <>
              {/* Sorting controls */}
              <div className="sorting-controls">
                <label htmlFor="sort-select">Sort by:</label>
                <select 
                  id="sort-select"
                  value={sortConfig.key} 
                  onChange={(e) => requestSort(e.target.value)}
                  className="sort-select"
                >
                  <option value="">-- No sorting --</option>
                  {tables.find(t => t.name === selectedTable)?.columns.map(column => (
                    <option key={column.name} value={column.name}>
                      {column.name}
                    </option>
                  ))}
                </select>
                
                {sortConfig.key && (
                  <button 
                    className="sort-direction-button"
                    onClick={() => {
                      const newDirection = sortConfig.direction === 'ascending' ? 'descending' : 'ascending';
                      setSortConfig({ ...sortConfig, direction: newDirection });
                    }}
                  >
                    {sortConfig.direction === 'ascending' ? 'Sort Descending ↓' : 'Sort Ascending ↑'}
                  </button>
                )}
                
                {sortConfig.key && (
                  <button 
                    className="clear-sort-button"
                    onClick={() => setSortConfig({ key: '', direction: null })}
                  >
                    Clear Sort
                  </button>
                )}
              </div>
              
              <div className="table-container">
                <table className="records-table">
                  <thead>
                    <tr>
                      <th>Select</th>
                      {tables.find(t => t.name === selectedTable)?.columns.slice(0, 5).map(column => (
                        <th 
                          key={column.name} 
                          className={`sortable-header ${sortConfig.key === column.name ? 'sorted' : ''}`}
                          onClick={() => requestSort(column.name)}
                        >
                          {column.name}
                          {sortConfig.key === column.name && (
                            <span className="sort-indicator">
                              {sortConfig.direction === 'ascending' ? ' ↑' : ' ↓'}
                            </span>
                          )}
                        </th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {sortedData.map((record, rowIndex) => (
                      <tr 
                        key={rowIndex} 
                        className={selectedRecord && record.id === selectedRecord.id ? 'selected-row' : ''}
                        onClick={() => handleRecordSelect(record)}
                      >
                        <td>
                          <button 
                            className="select-button"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleRecordSelect(record);
                            }}
                          >
                            Select
                          </button>
                        </td>
                        {tables.find(t => t.name === selectedTable)?.columns.slice(0, 5).map(column => (
                          <td key={column.name}>
                            {typeof record[column.name] === 'object' 
                              ? JSON.stringify(record[column.name]) 
                              : record[column.name]?.toString() || ''}
                          </td>
                        ))}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </>
          )}
        </div>
      )}
      
      {/* Edit form */}
      {selectedRecord && editedRecord && (
        <div className="edit-section">
          <h2>3. Edit Record</h2>
          
          <form onSubmit={handleUpdateRecord}>
            <div className="form-grid">
              {tables
                .find(t => t.name === selectedTable)?.columns
                .map(column => renderFormField(column))}
            </div>
            
            <div className="action-buttons">
              <button 
                type="submit" 
                className="update-button"
                disabled={isLoading}
              >
                {isLoading ? 'Updating...' : 'Update Record'}
              </button>
              
              <button 
                type="button" 
                className="delete-button"
                onClick={() => setConfirmDelete(true)}
                disabled={isLoading}
              >
                Delete Record
              </button>
              
              <button 
                type="button" 
                className="cancel-button"
                onClick={() => {
                  setSelectedRecord(null);
                  setEditedRecord(null);
                  clearMessages();
                }}
                disabled={isLoading}
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
      )}
      
      {/* Confirmation dialog for delete */}
      {confirmDelete && (
        <div className="delete-confirmation">
          <div className="delete-confirmation-content">
            <h3>Confirm Deletion</h3>
            <p>Are you sure you want to delete this record? This action cannot be undone.</p>
            
            <div className="confirmation-buttons">
              <button 
                className="confirm-delete-button"
                onClick={handleDeleteRecord}
                disabled={isLoading}
              >
                {isLoading ? 'Deleting...' : 'Yes, Delete'}
              </button>
              
              <button 
                className="cancel-delete-button"
                onClick={() => setConfirmDelete(false)}
                disabled={isLoading}
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
      
      {/* Messages */}
      {error && <div className="error-message">{error}</div>}
      {successMessage && <div className="success-message">{successMessage}</div>}
    </div>
  );
};

export default DatabaseUpdatePage;