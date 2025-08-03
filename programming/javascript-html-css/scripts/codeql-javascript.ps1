param(
    [string]$sourcePath = "$(git rev-parse --show-toplevel)\programming\javascript-html-css\workspace\calculator", # Path to the JavaScript source code to analyze
    [string]$databasePath = "$(git rev-parse --show-toplevel)\programming\javascript-html-css\scripts\js-db", # Path where the CodeQL database will be created (temporary)
    [string]$outputPath = ".\codeql-results.sarif", # Output file path for SARIF results
    [string]$language = "javascript", # Programming language to analyze
    [string]$desiredQuerySuite = "javascript-security-and-quality.qls",
    [string]$customQueryPath = ".\custom-security.ql", # Custom query file to use for analysis
    [string]$qlsPath = "$env:USERPROFILE\.codeql", # Path to search for CodeQL query suites
    [string]$sarifCategory = "javascript-analysis", # Category tag for the SARIF output
    [ValidateSet("sarif-latest", "csv", "json", "table")]
    [string]$format = "sarif-latest",
    [switch]$includeCustomQuery # Switch to use only the custom query file instead of the query suite
)

# create the codeql database
codeql database create $databasePath --language=$language --source-root=$sourcePath --overwrite --verbose

# Ensure JavaScript queries are downloaded
Write-Host "Downloading CodeQL JavaScript queries..." -ForegroundColor Cyan
codeql pack download codeql/javascript-queries
codeql pack download codeql/javascript-all

# return the path of the $fullQlsPath
$queryFile = Get-ChildItem -Path "$qlsPath" -Recurse -Filter $desiredQuerySuite -ErrorAction SilentlyContinue | Select-Object -First 1
if ($queryFile) {
    $fullQlsPath = $queryFile.FullName
    Write-Host "Found query suite at: $fullQlsPath"
} else {
    Write-Error "Query suite '$desiredQuerySuite' not found in CodeQL packages at path: $qlsPath"
    # download javascript query suites
    codeql pack download codeql/javascript-queries
}

# Set output file extension based on format
$outputExtension = switch ($format) {
    "sarif-latest" { ".sarif" }
    "csv" { ".csv" }
    "json" { ".json" }
    "table" { ".txt" }
    default { ".sarif" }
}

$outputPath = $outputPath -replace '\.[^.]+$', $outputExtension
Write-Host "Output will be saved to: $outputPath" -ForegroundColor Yellow

# run codeql analysis
if ($includeCustomQuery) {
    Write-Host "Including custom query with standard queries: $customQueryPath" -ForegroundColor Cyan
    # Check if custom query file exists
    if (Test-Path $customQueryPath) {
        try {
            codeql database analyze $databasePath $fullQlsPath $customQueryPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
        }
        catch {
            Write-Warning "Custom query failed. Falling back to standard JavaScript security queries."
            codeql database analyze $databasePath "codeql/javascript-queries:codeql-suites/javascript-security-and-quality.qls" --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
        }
    } else {
        Write-Warning "Custom query file not found at: $customQueryPath. Using standard queries only."
        codeql database analyze $databasePath $fullQlsPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
    }
} else {
    Write-Host "Using query suite: $fullQlsPath" -ForegroundColor Cyan
    codeql database analyze $databasePath $fullQlsPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose
}

# remove database directory to cleanup
Remove-Item -Path $databasePath -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Database directory cleaned up: $databasePath" -ForegroundColor Yellow

# show the results
Write-Host "=== CodeQL Analysis Results ===" -ForegroundColor Green
$sarifContent = Get-Content $outputPath | ConvertFrom-Json
Write-Host "Tool: $($sarifContent.runs[0].tool.driver.name)" -ForegroundColor Cyan
Write-Host "Version: $($sarifContent.runs[0].tool.driver.version)" -ForegroundColor Cyan
Write-Host "Results Count: $($sarifContent.runs[0].results.Count)" -ForegroundColor Yellow

if ($sarifContent.runs[0].results.Count -gt 0) {
    Write-Host "`n=== Issues Found ===" -ForegroundColor Red
    foreach ($result in $sarifContent.runs[0].results) {
        Write-Host "Rule ID: $($result.ruleId)" -ForegroundColor Magenta
        Write-Host "Level: $($result.level)" -ForegroundColor Yellow
        Write-Host "Message: $($result.message.text)" -ForegroundColor White
        if ($result.locations) {
            $location = $result.locations[0].physicalLocation
            Write-Host "File: $($location.artifactLocation.uri)" -ForegroundColor Cyan
            Write-Host "Line: $($location.region.startLine)" -ForegroundColor Cyan
        }
        Write-Host "---" -ForegroundColor Gray
    }
} else {
    Write-Host "`n✅ No issues found!" -ForegroundColor Green
}



