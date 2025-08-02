param(
    [string]$sourcePath = "$(git rev-parse --show-toplevel)\programming\javascript-html-css\workspace\calculator",        # Path to the JavaScript source code to analyze
    [string]$databasePath = "$(git rev-parse --show-toplevel)\programming\javascript-html-css\scripts\js-db",            # Path where the CodeQL database will be created (temporary)
    [string]$outputPath = ".\codeql-results.sarif",                                                                       # Output file path for SARIF results
    [string]$language = "javascript",                                                                                     # Programming language to analyze
    [string]$desiredQuerySuite = "javascript-security-and-quality.qls",                                                  # Query suite file to use for analysis
    [string]$qlsPath = "$env:USERPROFILE\.codeql",                                                                        # Path to search for CodeQL query suites
    [string]$sarifCategory = "javascript-analysis",                                                                         # Category tag for the SARIF output
    [ValidateSet("sarif-latest", "csv", "json", "table")]
    [string]$format = "sarif-latest",                                                                                     # Output format for CodeQL results
)

# create the codeql database
codeql database create $databasePath --language=$language --source-root=$sourcePath --overwrite --verbose

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

# Prompt user to select output format
Write-Host "`n=== Select Output Format ===" -ForegroundColor Cyan
Write-Host "1. SARIF Latest (recommended)" -ForegroundColor White
Write-Host "2. CSV" -ForegroundColor White
Write-Host "3. JSON" -ForegroundColor White
Write-Host "4. Table" -ForegroundColor White

do {
    $choice = Read-Host "`nEnter your choice (1-4)"
    switch ($choice) {
        "1" { $format = "sarif-latest"; $validChoice = $true }
        "2" { $format = "csv"; $validChoice = $true }
        "3" { $format = "json"; $validChoice = $true }
        "4" { $format = "table"; $validChoice = $true }
        default { 
            Write-Host "Invalid choice. Please enter 1, 2, 3, or 4." -ForegroundColor Red
            $validChoice = $false
        }
    }
} while (-not $validChoice)

Write-Host "Selected format: $format" -ForegroundColor Green

# Update output file extension based on format
$outputExtension = switch ($format) {
    "sarif-latest" { ".sarif" }
    "csv" { ".csv" }
    "json" { ".json" }
    "table" { ".txt" }
}
$outputPath = $outputPath -replace '\.[^.]+$', $outputExtension
Write-Host "Output will be saved to: $outputPath" -ForegroundColor Yellow


# run codeql analysis
codeql database analyze $databasePath $fullQlsPath --format=$format --output=$outputPath --sarif-category=$sarifCategory --verbose

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



