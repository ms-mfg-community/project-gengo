# Calculator SQLite Database

## Overview

This directory contains the SQLite database for the CalculatorBlazor project. The database stores calculator test cases that are used to validate calculator operations.

## Database File

- **File Name**: `calculator.db`
- **Database Type**: SQLite 3
- **Location**: `CalculatorBlazor/Data/calculator.db`

## Schema

### CalculatorTestCases Table

| Column Name | Data Type | Constraints | Description |
|------------|-----------|-------------|-------------|
| Id | INTEGER | PRIMARY KEY, AUTOINCREMENT | Unique identifier for each test case |
| FirstNumber | REAL | NOT NULL | First operand in the calculation |
| SecondNumber | REAL | NOT NULL | Second operand in the calculation |
| Operation | TEXT | NOT NULL, INDEXED | Operation type (Add, Subtract, Multiply, Divide, Modulo, Exponent) |
| ExpectedValue | REAL | NOT NULL | Expected result of the calculation |
| Description | TEXT | NOT NULL | Human-readable description of the test case |
| ActualValue | REAL | NULL | Actual calculated value (populated at runtime) |
| Result | TEXT | NOT NULL, INDEXED | Test result status (pending, passed, failed) |

### Indexes

- `IX_CalculatorTestCases_Operation` - Index on Operation column for efficient filtering
- `IX_CalculatorTestCases_Result` - Index on Result column for efficient status queries

## Data Source

The database is automatically seeded from the CSV file located at:
`CalculatorBlazor/TestData/calculator-test-data.csv`

The initial seed contains 31 test cases covering all calculator operations:
- Add: 5 test cases
- Subtract: 5 test cases
- Multiply: 5 test cases
- Divide: 5 test cases
- Modulo: 5 test cases
- Exponent: 6 test cases

## Database Initialization

The database is automatically created and seeded when the application starts if it doesn't already exist. This is handled by the `DatabaseInitializationService` class.

### Initialization Process

1. Database file is created at `Data/calculator.db`
2. Table schema is created with indexes
3. If the table is empty, data is loaded from the CSV file
4. All 31 test cases are inserted with default `Result` status of "pending"

## Services

### CalculatorDatabaseService

Provides CRUD operations for test cases:

- `GetAllTestCasesAsync()` - Retrieve all test cases
- `GetTestCasesByOperationAsync(operation)` - Filter test cases by operation
- `GetTestCaseByIdAsync(id)` - Get a specific test case
- `UpdateTestResultAsync(id, actualValue, result)` - Update test results
- `AddTestCaseAsync(testCase)` - Add a new test case
- `DeleteTestCaseAsync(id)` - Delete a test case
- `GetTestCaseCountByResultAsync(result)` - Count test cases by result status

## Usage Examples

### Querying the Database Directly

```bash
# Count all test cases
sqlite3 calculator.db "SELECT COUNT(*) FROM CalculatorTestCases;"

# View all test cases
sqlite3 calculator.db -header -column "SELECT * FROM CalculatorTestCases;"

# Get test cases by operation
sqlite3 calculator.db -header -column "SELECT * FROM CalculatorTestCases WHERE Operation = 'Add';"

# View schema
sqlite3 calculator.db ".schema CalculatorTestCases"
```

### Using in Code

```csharp
// Inject the service in a Blazor component
@inject CalculatorDatabaseService DatabaseService

// Get all test cases
var testCases = await DatabaseService.GetAllTestCasesAsync();

// Get test cases for a specific operation
var addTests = await DatabaseService.GetTestCasesByOperationAsync("Add");

// Update test result
await DatabaseService.UpdateTestResultAsync(1, 8.0, "passed");
```

## Database Regeneration

To regenerate the database:

1. Delete the `calculator.db` file
2. Restart the application
3. The database will be automatically recreated and seeded from the CSV file

## Notes

- The database file is excluded from version control via `.gitignore`
- Write-Ahead Logging (WAL) mode is enabled for better concurrency
- The database uses Entity Framework Core with SQLite provider
- Connection string: `Data Source={ContentRootPath}/Data/calculator.db`
