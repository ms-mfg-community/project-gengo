param(
    [string]$sourcePath = "$(git rev-parse --show-toplevel)\programming\javascript-html-css\workspace\calculator",
    [string]$databasePath = "$(git rev-parse --show-toplevel)\programming\javascript-html-css\scripts\js-db",
    [string]$outputPath = ".\codeql-results.sarif",
    [string]$language = "javascript",
    [string]$desiredQuerySuite = "javascript-security-and-quality.qls",
    [string]$codeqlQLSPath = "$env:USERPROFILE\.codeql"
)

# create the codeql database
codeql database create $databasePath --language=$language --source-root=$sourcePath --overwrite --verbose

# return the path of the $desiredQuerySuite
$queryFile = Get-ChildItem -Path "$codeqlQLSPath" -Recurse -Filter $desiredQuerySuite -ErrorAction SilentlyContinue | Select-Object -First 1
if ($queryFile) {
    $desiredQuerySuitePath = $queryFile.FullName
    Write-Host "Found query suite at: $desiredQuerySuitePath"
} else {
    Write-Error "Query suite '$desiredQuerySuite' not found in CodeQL packages at path: $codeqlQLSPath"
    # download javascript query suites
    codeql pack download codeql/javascript-queries
}

# run codeql analysis
codeql database analyze $databasePath $desiredQuerySuitePath --format=sarif-latest --output=$outputPath --sarif-category="javascript-analysis" --verbose

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



