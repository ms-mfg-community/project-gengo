# Install the npgsql module if not already installed
Install-Package -Name Npgsql -Source nuget.org
# Load the CSV data
$topLevelGitPath = $(git rev-parse --show-toplevel)
$relativeTargetPath = "databases\rdbms\workspace\src\postgresql\ghc-skills-matrix-demo-catalog.csv"
$targetPath = Join-Path -Path $topLevelGitPath -ChildPath $relativeTargetPath
$sourceData = Import-Csv -Path $targetPath

# PostgreSQL connection details
$psqlHost = "pfs-sql-01.postgres.database.azure.com"
$username = "ztmadmin"
$database = "ghc_prompts"
$password = Read-Host -Prompt "Enter the password" -AsSecureString
$plainTextPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

# Load the Npgsql assembly
Add-Type -Path (Join-Path -Path (Get-Package -Name Npgsql).Source -ChildPath "lib/netstandard2.0/Npgsql.dll")

# Create a connection string
$connectionString = "Host=$psqlHost;Username=$username;Password=$plainTextPassword;Database=$database"

# Create a new Npgsql connection
$connection = New-Object Npgsql.NpgsqlConnection($connectionString)
$connection.Open()

# Iterate over the CSV data and insert it into the PostgreSQL table
foreach ($row in $sourceData) {
    $commandText = @"
    INSERT INTO demo_catalog (category, sub_category, language, prompt_type, shot_type, is_test, test_type, epoch, confidence_percent, scenario, reference, notes_feedback)
    VALUES ('$($row.category)', '$($row.'sub-category')', '$($row.language)', '$($row.prompt_type)', '$($row.shot_type)', $($row.is_test), '$($row.test_type)', $($row.epoch), $($row.confidence_percent), '$($row.scenario)', '$($row.reference)', '$($row.notes_feedback)');
"@
    $command = New-Object Npgsql.NpgsqlCommand($commandText, $connection)
    $command.ExecuteNonQuery()
}

# Close the connection
$connection.Close()

# Clear the plain text password from memory
$plainTextPassword = $null