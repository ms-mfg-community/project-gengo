# Instructions for Importing CSV to Azure SQL Database

## Option 1: Using Azure Data Studio Import Wizard (Recommended)

1. Open Azure Data Studio
2. Connect to your Azure SQL Database server `svr-asi-01.database.windows.net` and the `ghc` database
3. Right-click on the database and select "New Query"
4. Run the following SQL to create the table (if it doesn't exist):

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
```

5. In the Object Explorer, right-click on the `demos` table
6. Select "Import Wizard"
7. In the Import Wizard:
   - Select the CSV file: Browse to `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\ghc_demos.csv`
   - Select "Comma" as the field separator
   - Check the "First row is column headers" option
   - Preview the data to make sure it looks correct
   - Click "Next"
   - Map the columns from the CSV to the table columns
   - Click "Next" and then "Finish"
8. After the import completes, verify the data with:

```sql
SELECT COUNT(*) AS TotalImportedRecords FROM [dbo].[demos];
SELECT TOP 10 * FROM [dbo].[demos];
```

## Option 2: Using the PowerShell Script

1. Open a PowerShell window with administrative privileges
2. Navigate to the directory where the script is located:
```
cd "C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql"
```
3. Run the script:
```
.\import-ghc-demos.ps1
```
4. Enter your SQL Server username and password when prompted
5. The script will create the table if it doesn't exist and import the data

## Option 3: Using the SQL Script in SSMS

1. Open SQL Server Management Studio (SSMS)
2. Connect to your Azure SQL Database server `svr-asi-01.database.windows.net` and the `ghc` database
3. Open the SQL script file: `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\import-ghc-demos.sql`
4. Edit the script to uncomment and configure one of the import methods:
   - Option 1: BULK INSERT (requires SQL Server to have access to the file)
   - Option 2: OPENROWSET with Azure Blob Storage (requires uploading the CSV to Azure Blob Storage)
   - Option 3: Manual INSERT statements (already included for the first few rows)
5. Execute the script
6. Verify the import with the SELECT statements at the end of the script

## Troubleshooting

### Common Issues:

1. **Connection Issues**: Make sure you're connecting with the correct credentials and server name.
2. **File Access Issues**: For BULK INSERT, SQL Server must have access to the file path. This may not work with Azure SQL Database.
3. **Formatting Issues**: CSV format might have special characters that need escaping.
4. **Permission Issues**: Make sure your SQL login has permissions to create tables and insert data.

### If Using Azure Blob Storage Method:

1. Use Azure Storage Explorer to upload the CSV file to a blob container
2. Generate a SAS token with read permissions for the blob
3. Update the script with the container URL and SAS token
4. Execute the updated script