-- ================================================
-- Azure SQL Database - Schema Discovery and Export
-- Expert SQL Developer and GitHub Copilot Instructor
-- ================================================
-- Purpose: Generate table_schema.csv for context reference
-- Database: Azure SQL Database
-- Output: table_schema.csv in same directory as this .sql file
-- ================================================

-- ================================================
-- SCHEMA DISCOVERY QUERY FOR CSV EXPORT
-- ================================================
SELECT 
    t.TABLE_SCHEMA,
    t.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.IS_NULLABLE,
    ISNULL(c.COLUMN_DEFAULT, '') AS COLUMN_DEFAULT,
    ISNULL(CAST(c.CHARACTER_MAXIMUM_LENGTH AS VARCHAR), '') AS MAX_LENGTH,
    ISNULL(CAST(c.NUMERIC_PRECISION AS VARCHAR), '') AS PRECISION,
    ISNULL(CAST(c.NUMERIC_SCALE AS VARCHAR), '') AS SCALE,
    c.ORDINAL_POSITION,
    ISNULL(tc.CONSTRAINT_TYPE, '') AS CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_NAME = c.TABLE_NAME AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc ON t.TABLE_NAME = tc.TABLE_NAME AND t.TABLE_SCHEMA = tc.TABLE_SCHEMA
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME AND c.COLUMN_NAME = kcu.COLUMN_NAME
WHERE t.TABLE_TYPE = 'BASE TABLE'
ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME, c.ORDINAL_POSITION;

-- ================================================
-- CSV EXPORT INSTRUCTIONS
-- ================================================
/*
METHOD 1 - SQL Server Management Studio (SSMS):
1. Execute the query above
2. Right-click on the results grid
3. Select "Save Results As..."
4. Choose "CSV (Comma delimited)" format
5. Navigate to: c:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\workspace\sql\
6. Save as "table_schema.csv"

METHOD 2 - Azure Data Studio:
1. Execute the query above
2. Click the "Save as CSV" button in the results toolbar
3. Navigate to the same directory as this .sql file
4. Save as "table_schema.csv"

METHOD 3 - PowerShell with SqlServer Module:
# Replace connection details with your actual values
$ServerInstance = "your-server.database.windows.net"
$Database = "your-database-name"
$OutputPath = "c:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\workspace\sql\table_schema.csv"

$Query = @"
SELECT 
    t.TABLE_SCHEMA,
    t.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.IS_NULLABLE,
    ISNULL(c.COLUMN_DEFAULT, '') AS COLUMN_DEFAULT,
    ISNULL(CAST(c.CHARACTER_MAXIMUM_LENGTH AS VARCHAR), '') AS MAX_LENGTH,
    ISNULL(CAST(c.NUMERIC_PRECISION AS VARCHAR), '') AS PRECISION,
    ISNULL(CAST(c.NUMERIC_SCALE AS VARCHAR), '') AS SCALE,
    c.ORDINAL_POSITION,
    ISNULL(tc.CONSTRAINT_TYPE, '') AS CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_NAME = c.TABLE_NAME AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc ON t.TABLE_NAME = tc.TABLE_NAME AND t.TABLE_SCHEMA = tc.TABLE_SCHEMA
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME AND c.COLUMN_NAME = kcu.COLUMN_NAME
WHERE t.TABLE_TYPE = 'BASE TABLE'
ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME, c.ORDINAL_POSITION;
"@

Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $Query | Export-Csv -Path $OutputPath -NoTypeInformation

METHOD 4 - BCP Command Line:
bcp "SELECT t.TABLE_SCHEMA, t.TABLE_NAME, c.COLUMN_NAME, c.DATA_TYPE, c.IS_NULLABLE, ISNULL(c.COLUMN_DEFAULT, '') AS COLUMN_DEFAULT, ISNULL(CAST(c.CHARACTER_MAXIMUM_LENGTH AS VARCHAR), '') AS MAX_LENGTH, ISNULL(CAST(c.NUMERIC_PRECISION AS VARCHAR), '') AS PRECISION, ISNULL(CAST(c.NUMERIC_SCALE AS VARCHAR), '') AS SCALE, c.ORDINAL_POSITION, ISNULL(tc.CONSTRAINT_TYPE, '') AS CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLES t LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_NAME = c.TABLE_NAME AND t.TABLE_SCHEMA = c.TABLE_SCHEMA LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc ON t.TABLE_NAME = tc.TABLE_NAME AND t.TABLE_SCHEMA = tc.TABLE_SCHEMA LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME AND c.COLUMN_NAME = kcu.COLUMN_NAME WHERE t.TABLE_TYPE = 'BASE TABLE' ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME, c.ORDINAL_POSITION" queryout "table_schema.csv" -c -t, -S your-server.database.windows.net -d your-database-name -U username -P password
*/

-- ================================================
-- CONTEXT REFERENCE SETUP
-- ================================================
/*
After creating table_schema.csv:

1. The CSV file will contain complete schema information for all tables
2. Use this file as reference context for subsequent T-SQL generation prompts
3. The schema includes:
   - Table and column names
   - Data types and constraints
   - Nullable/Not null information
   - Default values
   - Primary key information

This ensures all future T-SQL queries will use:
- Correct table names
- Correct column names
- Appropriate data types
- Valid constraint considerations
*/

-- ================================================
-- DISCOVERED SCHEMA CONTEXT FROM table_schema.csv
-- ================================================
/*
AVAILABLE TABLES:
- cdc.captured_columns (BASE TABLE)
- cdc.change_tables (BASE TABLE) 
- cdc.ddl_history (BASE TABLE)
- cdc.index_columns (BASE TABLE)
- cdc.lsn_time_mapping (BASE TABLE)
- dbo.ChangeTrackingControl (BASE TABLE)
- dbo.demos (BASE TABLE) ★ PRIMARY TARGET TABLE
- dbo.MSchange_tracking_history (BASE TABLE)
- dbo.scenario_hashes (BASE TABLE)
- dbo.SyncVersionControl (BASE TABLE)
- dbo.systranschemas (BASE TABLE)
- dbo.vectorization_change_log (BASE TABLE)

PRIMARY TARGET: dbo.demos table contains programming demo information
*/

-- ================================================
-- QUERY TO DISCOVER DEMOS TABLE STRUCTURE
-- ================================================
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT,
    CHARACTER_MAXIMUM_LENGTH,
    ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'demos' AND TABLE_SCHEMA = 'dbo'
ORDER BY ORDINAL_POSITION;

-- ================================================
-- Prompt 1: Show me the top 10 demos in the database with their categories and languages
-- ================================================
SELECT TOP 10 
    id,
    scenario AS demo_name,
    category,
    sub_category,
    language,
    confidence_percent,
    points,
    role,
    ide_type,
    reference
FROM dbo.demos
ORDER BY 
    confidence_percent DESC, 
    points DESC;

-- ================================================
-- Prompt 2: Find all C# programming demos with confidence over 60% sorted by highest confidence
-- ================================================
SELECT 
    id,
    scenario AS demo_name,
    category,
    sub_category,
    language,
    confidence_percent,
    points,
    role,
    ide_type,
    reference
FROM dbo.demos
WHERE 
    language IN ('csharp', 'c#', 'C#', 'CSharp') 
    AND category = 'programming'
    AND confidence_percent > 60
ORDER BY 
    confidence_percent DESC,
    points DESC;

