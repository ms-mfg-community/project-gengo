$sourcePath = "."
$databasePath = "js-db"
$language = "javascript"
$outputPath = "codql-results.sarif"
$desiredQuerySuite = "javascript-security-and-quality.qls"
$qlsPath = "$env:USERPROFILE\.codeql"
$queryFile = Get-ChildItem -Path "$qlsPath" -Recurse -Filter $desiredQuerySuite -ErrorAction SilentlyContinue | Select-Object -First 1
$fullQlsPath = $queryFile.FullName
$sarifCategory = "javascript-analysis"

# create-db 
codeql database create $databasePath --language=$language --source-root=$sourcePath --overwrite --verbose

# analyse-db 
codeql database analyze $databasePath $fullQlsPath --format-sarif-latest --output=$outputPath --sarif-category=$sarifCategory --verbose

# show-results 
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
 










