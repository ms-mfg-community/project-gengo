-- Script to import CSV file into Azure SQL Database

-- Create the demos table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[demos]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[demos](
        [id] [int] NULL,
        [points] [int] NULL,
        [category] [nvarchar](255) NULL,
        [sub_category] [nvarchar](255) NULL,
        [language] [nvarchar](255) NULL,
        [role] [nvarchar](255) NULL,
        [person] [nvarchar](255) NULL,
        [ide_type] [nvarchar](255) NULL,
        [prompt_type] [nvarchar](255) NULL,
        [shot_type] [nvarchar](255) NULL,
        [is_test] [bit] NULL,
        [test_type] [nvarchar](255) NULL,
        [epoch] [int] NULL,
        [confidence_percent] [int] NULL,
        [scenario] [nvarchar](max) NULL,
        [github_org] [nvarchar](255) NULL,
        [reference] [nvarchar](max) NULL,
        [data_source] [nvarchar](255) NULL,
        [notes] [nvarchar](max) NULL
    )
END
GO

-- Clear any existing data in the table to avoid duplicates
DELETE FROM [dbo].[demos];
GO

-- Option 1: Using BULK INSERT from local file
-- Only works if SQL Server has access to the file location
-- BULK INSERT [dbo].[demos]
-- FROM 'C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\ghc_demos.csv'
-- WITH (
--     FIRSTROW = 2,
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n',
--     TABLOCK
-- );
-- GO

-- Option 2: Using OPENROWSET with Azure Blob Storage
-- Replace the placeholders with your actual values
-- This is the recommended approach for Azure SQL Database

-- DECLARE @sasToken NVARCHAR(MAX) = 'YOUR_SAS_TOKEN'; -- Create a SAS token with at least Read permission
-- DECLARE @blobPath NVARCHAR(MAX) = 'https://yourstorageaccount.blob.core.windows.net/yourcontainer/ghc_demos.csv';

-- INSERT INTO [dbo].[demos]
-- SELECT *
-- FROM OPENROWSET(
--     BULK @blobPath,
--     FORMAT = 'CSV',
--     PARSER_VERSION = '2.0',
--     FIRSTROW = 2,
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n'
-- ) WITH (
--     [id] [int],
--     [points] [int],
--     [category] [nvarchar](255),
--     [sub_category] [nvarchar](255),
--     [language] [nvarchar](255),
--     [role] [nvarchar](255),
--     [person] [nvarchar](255),
--     [ide_type] [nvarchar](255),
--     [prompt_type] [nvarchar](255),
--     [shot_type] [nvarchar](255),
--     [is_test] [bit],
--     [test_type] [nvarchar](255),
--     [epoch] [int],
--     [confidence_percent] [int],
--     [scenario] [nvarchar](max),
--     [github_org] [nvarchar](255),
--     [reference] [nvarchar](max),
--     [data_source] [nvarchar](255),
--     [notes] [nvarchar](max)
-- ) AS csvData;
-- GO

-- Option 3: Manual insert of data from CSV
-- First few rows as examples:
INSERT INTO [dbo].[demos] VALUES 
(1, 20, 'programming', 'calculator', 'csharp', 'app-dev', 'devia delta', 'visual_studio', 'chat', 'multiple', 1, 'unit', 0, 70, 'create a basic .net 8.0 calculator with xunit testing', 'ms-mfg-community', 'programming/dotnet/csharp/workspace/src/prompts-calculator-solution.txt', 'pfs-sql-01.postgres.database.azure.com', ''),
(2, 13, 'databases', 'rdbms', 'postgresql', 'dba', 'ophelia oscar', 'vs_code', 'chat', 'one', 0, 'na', 0, 90, 'connect to postgresql database in azure', 'ms-mfg-community', 'databases\rdbms\workspace\src\postgresql\prompts-postgres.txt', 'pfs-sql-01.postgres.database.azure.com', ''),
(3, 8, 'databases', 'rdbms', 'postgresql', 'dba', 'ophelia oscar', 'vs_code', 'chat', 'one', 0, 'na', 0, 90, 'search the demo catalog to find the scenario for a basic calculator with .net 8.0', 'ms-mfg-community', 'databases\rdbms\workspace\src\postgresql\prompts-postgres.txt', 'pfs-sql-01.postgres.database.azure.com', ''),
(4, 40, 'databases', 'rdbms', 'mssql', 'dba', 'ophelia oscar', 'visual_studio', 'chat', 'one', 0, 'na', 0, 100, 'query the sql-asi-01 azure database', 'ms-mfg-community', 'databases\rdbms\workspace\src\azure-sql\prompts-sql.txt', 'pfs-sql-01.postgres.database.azure.com', ''),
(5, 40, 'databases', 'rdbms', 'mssql', 'dba', 'ophelia oscar', 'jetbrains_suite', 'chat', 'one', 0, 'na', 0, 100, 'query the postgresql database in azure with data grip', 'ms-mfg-community', 'databases\rdbms\workspace\src\postgresql\prompts-postgres.txt', 'pfs-sql-01.postgres.database.azure.com', ''),
(6, 40, 'programming', 'dotnet', 'csharp', 'app-dev', 'devia delta', 'visual_studio', 'chat', 'multiple', 1, 'na', 0, 10, 'create a country quiz using .net 9.0 with test cases (xunit)', 'ms-mfg-community', 'programming\dotnet\csharp\workspace\src\prompts-country-quiz.txt', 'pfs-sql-01.postgres.database.azure.com', ''),
(7, 40, 'programming', 'calculator', 'java', 'app-dev', 'devia delta', 'visual_studio', 'chat', 'multiple', 1, 'na', 0, 10, 'create basic calculator in java with visual studio 2022 with test cases (junit)', 'ms-mfg-community', 'programming\java\pnd-calculator-java-vs2022.md', 'pfs-sql-01.postgres.database.azure.com', ''),
(8, 40, 'programming', 'calculator', 'java', 'app-dev', 'devia delta', 'vs_code', 'chat', 'multiple', 1, 'na', 0, 10, 'create basic calculator in java with vscode with test cases (junit)', 'ms-mfg-community', 'programming\java\pnd-calculator-java-vs2022.md', 'pfs-sql-01.postgres.database.azure.com', ''),
(9, 40, 'programming', 'calculator', 'java', 'app-dev', 'devia delta', 'jetbrains_suite', 'chat', 'multiple', 1, 'na', 0, 10, 'create basic calculator in java with intellij idea with test cases (junit)', 'ms-mfg-community', 'programming\java\pnd-calculator-java-intellij.md', 'pfs-sql-01.postgres.database.azure.com', '');
-- Continue adding remaining rows...

-- Verify the data was imported correctly
SELECT COUNT(*) AS TotalImportedRecords FROM [dbo].[demos];
SELECT TOP 10 * FROM [dbo].[demos];
GO