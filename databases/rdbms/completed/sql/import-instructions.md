# Instructions for Importing CSV to Azure SQL Database

\n\nOption 1: Using Azure Data Studio Import Wizard (Recommended)

\n\nOpen Azure Data Studio
\n\nConnect to your Azure SQL Database server `svr-asi-01.database.windows.net` and the `ghc` database
\n\nRight-click on the database and select "New Query"
\n\nRun the following SQL to create the table (if it doesn't exist):

```sql

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

```text
text

\n\nIn the Object Explorer, right-click on the `demos` table
\n\nSelect "Import Wizard"
\n\nIn the Import Wizard:
\n\nSelect the CSV file: Browse to `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\ghc_demos.csv`
\n\nSelect "Comma" as the field separator
\n\nCheck the "First row is column headers" option
\n\nPreview the data to make sure it looks correct
\n\nClick "Next"
\n\nMap the columns from the CSV to the table columns
\n\nClick "Next" and then "Finish"
\n\nAfter the import completes, verify the data with:

```sql

SELECT COUNT(*) AS TotalImportedRecords FROM [dbo].[demos];

SELECT TOP 10 * FROM [dbo].[demos];

```text
text

\n\nOption 2: Using the PowerShell Script

\n\nOpen a PowerShell window with administrative privileges
\n\nNavigate to the directory where the script is located:

```text

cd "C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql"

```text
text

\n\nRun the script:

```text

.\import-ghc-demos.ps1

```text
text

\n\nEnter your SQL Server username and password when prompted
\n\nThe script will create the table if it doesn't exist and import the data

\n\nOption 3: Using the SQL Script in SSMS

\n\nOpen SQL Server Management Studio (SSMS)
\n\nConnect to your Azure SQL Database server `svr-asi-01.database.windows.net` and the `ghc` database
\n\nOpen the SQL script file: `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\import-ghc-demos.sql`
\n\nEdit the script to uncomment and configure one of the import methods:
\n\nOption 1: BULK INSERT (requires SQL Server to have access to the file)
\n\nOption 2: OPENROWSET with Azure Blob Storage (requires uploading the CSV to Azure Blob Storage)
\n\nOption 3: Manual INSERT statements (already included for the first few rows)
\n\nExecute the script
\n\nVerify the import with the SELECT statements at the end of the script

\n\nTroubleshooting

\n\nCommon Issues:

\n\n**Connection Issues**: Make sure you're connecting with the correct credentials and server name.
\n\n**File Access Issues**: For BULK INSERT, SQL Server must have access to the file path. This may not work with Azure SQL Database.
\n\n**Formatting Issues**: CSV format might have special characters that need escaping.
\n\n**Permission Issues**: Make sure your SQL login has permissions to create tables and insert data.

\n\nIf Using Azure Blob Storage Method:

\n\nUse Azure Storage Explorer to upload the CSV file to a blob container
\n\nGenerate a SAS token with read permissions for the blob
\n\nUpdate the script with the container URL and SAS token
\n\nExecute the updated script

\n
