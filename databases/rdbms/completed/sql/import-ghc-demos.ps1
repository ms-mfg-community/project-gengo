# Script to import CSV file into Azure SQL Database

# Configuration
$server = "svr-asi-01.database.windows.net"
$database = "ghc"
$csvPath = "C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\ghc_demos.csv"
$tableName = "demos"

# Prompt for SQL authentication
$userName = Read-Host -Prompt "Enter your SQL Server username"
$securePassword = Read-Host -Prompt "Enter your SQL Server password" -AsSecureString
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

# Create a temporary SQL script to create the table
$tempSqlFile = [System.IO.Path]::GetTempFileName()
@"
-- Create the demos table if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[$tableName]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[$tableName](
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
"@ | Out-File -FilePath $tempSqlFile

# Execute the SQL script to create the table
Write-Host "Creating table if it doesn't exist..."
sqlcmd -S $server -d $database -U $userName -P $password -i $tempSqlFile

# Create temporary format file for bulk import
$formatFile = [System.IO.Path]::GetTempFileName()
@"
14.0
19
1       SQLCHAR       0       50      ","      1     id               ""
2       SQLCHAR       0       50      ","      2     points           ""
3       SQLCHAR       0       255     ","      3     category         ""
4       SQLCHAR       0       255     ","      4     sub_category     ""
5       SQLCHAR       0       255     ","      5     language         ""
6       SQLCHAR       0       255     ","      6     role             ""
7       SQLCHAR       0       255     ","      7     person           ""
8       SQLCHAR       0       255     ","      8     ide_type         ""
9       SQLCHAR       0       255     ","      9     prompt_type      ""
10      SQLCHAR       0       255     ","      10    shot_type        ""
11      SQLCHAR       0       10      ","      11    is_test          ""
12      SQLCHAR       0       255     ","      12    test_type        ""
13      SQLCHAR       0       50      ","      13    epoch            ""
14      SQLCHAR       0       50      ","      14    confidence_percent ""
15      SQLCHAR       0       4000    ","      15    scenario         ""
16      SQLCHAR       0       255     ","      16    github_org       ""
17      SQLCHAR       0       4000    ","      17    reference        ""
18      SQLCHAR       0       255     ","      18    data_source      ""
19      SQLCHAR       0       4000    "\r\n"   19    notes            ""
"@ | Out-File -FilePath $formatFile

# Create SQL script for BCP import
$importSqlFile = [System.IO.Path]::GetTempFileName()
@"
-- First, delete any existing data to avoid duplicates
DELETE FROM [dbo].[$tableName];
-- BCP import statement
DECLARE @BcpCommand NVARCHAR(4000);
SET @BcpCommand = 'bcp [dbo].[$tableName] in "$csvPath" -f "$formatFile" -S "$server" -d $database -U $userName -P "' + '$password' + '" -F 2 -c -t,';
EXEC master.dbo.xp_cmdshell @BcpCommand;
-- Show record count
SELECT COUNT(*) AS ImportedRecords FROM [dbo].[$tableName];
"@ -replace '\$password', $password | Out-File -FilePath $importSqlFile

# Execute the import
Write-Host "Importing data from CSV file..."
try {
    sqlcmd -S $server -d $database -U $userName -P $password -i $importSqlFile
    Write-Host "Import completed successfully." -ForegroundColor Green
}
catch {
    Write-Host "Error during import: $_" -ForegroundColor Red
}
finally {
    # Clean up temporary files
    Remove-Item -Path $tempSqlFile -ErrorAction SilentlyContinue
    Remove-Item -Path $formatFile -ErrorAction SilentlyContinue
    Remove-Item -Path $importSqlFile -ErrorAction SilentlyContinue
}