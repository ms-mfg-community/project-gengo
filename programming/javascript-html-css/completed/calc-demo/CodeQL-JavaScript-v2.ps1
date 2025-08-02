# Fixed CodeQL Analysis Script for JavaScript - Updated with correct query suite path
param(
    [string]$SourcePath = ".",
    [string]$DatabasePath = "js-db",
    [string]$OutputPath = "codeql-results.sarif",
    [string]$GitHubToken = $env:GITHUB_TOKEN
)

Write-Host "=== CodeQL JavaScript Security Analysis ===" -ForegroundColor Green

# Set proper paths
$CodeQLPath = "C:\apps\code-ql\codeql\codeql.exe"
$QuerySuitePath = "$env:USERPROFILE\.codeql\packages\codeql\javascript-queries\2.0.0\codeql-suites\javascript-security-and-quality.qls"

Write-Host "Source Path: $SourcePath" -ForegroundColor Cyan
Write-Host "Database Path: $DatabasePath" -ForegroundColor Cyan
Write-Host "Output Path: $OutputPath" -ForegroundColor Cyan
Write-Host "Query Suite: $QuerySuitePath" -ForegroundColor Cyan

# Verify query suite exists
if (-not (Test-Path $QuerySuitePath)) {
    Write-Error "Query suite not found at: $QuerySuitePath"
    Write-Host "Please ensure CodeQL packages are properly installed" -ForegroundColor Yellow
    exit 1
}

try {
    # Step 1: Create CodeQL database
    Write-Host "`n[1/4] Creating CodeQL database..." -ForegroundColor Yellow
    & $CodeQLPath database create $DatabasePath --language=javascript --source-root=$SourcePath --overwrite
    
    if ($LASTEXITCODE -ne 0) {
        throw "Database creation failed with exit code $LASTEXITCODE"
    }
    
    # Step 2: Run security queries using the correct query suite path
    Write-Host "`n[2/4] Running JavaScript security analysis..." -ForegroundColor Yellow
    Write-Host "Using query suite: $QuerySuitePath" -ForegroundColor Cyan
    
    & $CodeQLPath database analyze $DatabasePath `
        $QuerySuitePath `
        --format=sarif-latest `
        --output=$OutputPath `
        --sarif-category="javascript-analysis"
    
    if ($LASTEXITCODE -ne 0) {
        throw "Analysis failed with exit code $LASTEXITCODE"
    }
    
    # Step 3: Display results
    Write-Host "`n[3/4] Analysis completed successfully!" -ForegroundColor Green
    
    if (Test-Path $OutputPath) {
        $sarifContent = Get-Content $OutputPath | ConvertFrom-Json
        $resultCount = if ($sarifContent.runs -and $sarifContent.runs[0].results) { 
            $sarifContent.runs[0].results.Count 
        } else { 
            0 
        }
        Write-Host "Found $resultCount security findings" -ForegroundColor Cyan
        
        # Show summary of findings
        if ($resultCount -gt 0) {
            Write-Host "`nSecurity Findings Summary:" -ForegroundColor Yellow
            $sarifContent.runs[0].results | ForEach-Object {
                $severity = if ($_.level) { $_.level } else { "note" }
                $ruleId = if ($_.ruleId) { $_.ruleId } else { "unknown-rule" }
                $message = if ($_.message.text) { $_.message.text } else { "No message" }
                Write-Host "  [$severity] $ruleId - $message" -ForegroundColor White
            }
        } else {
            Write-Host "Great! No security issues found in your calculator code." -ForegroundColor Green
        }
    }
    
    # Step 4: Upload to GitHub (if token provided)
    if ($GitHubToken -and (Test-Path $OutputPath)) {
        Write-Host "`n[4/4] Uploading results to GitHub..." -ForegroundColor Yellow
        
        $env:GITHUB_TOKEN = $GitHubToken
        & $CodeQLPath github upload-results `
            --repository="ms-mfg-community/project-gengo" `
            --ref="refs/heads/main" `
            --commit=(git rev-parse HEAD) `
            --sarif=$OutputPath `
            --github-auth-stdin
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Results uploaded to GitHub successfully!" -ForegroundColor Green
        } else {
            Write-Warning "Failed to upload to GitHub (exit code: $LASTEXITCODE)"
        }
    } else {
        Write-Host "`n[4/4] Skipping GitHub upload (no token provided)" -ForegroundColor Gray
        Write-Host "To upload results, set GITHUB_TOKEN environment variable" -ForegroundColor Gray
    }
    
        # Display detailed SARIF results using PowerShell
    if (Test-Path $OutputPath) {
        Write-Host "`n=== SARIF Analysis Results Viewer ===" -ForegroundColor Blue
        
        try {
            $sarifData = Get-Content $OutputPath | ConvertFrom-Json
            $run = $sarifData.runs[0]
            
            # Tool Information
            Write-Host "`n📊 Analysis Summary" -ForegroundColor Green
            Write-Host "  Tool: $($run.tool.driver.name) v$($run.tool.driver.semanticVersion)" -ForegroundColor White
            Write-Host "  Organization: $($run.tool.driver.organization)" -ForegroundColor White
            Write-Host "  Analysis Date: $(Get-Date)" -ForegroundColor White
            
            # Files Analyzed
            Write-Host "`n📁 Files Analyzed ($($run.artifacts.Count) files)" -ForegroundColor Green
            $run.artifacts | ForEach-Object {
                Write-Host "  ✓ $($_.location.uri)" -ForegroundColor Cyan
            }
            
            # Security Rules Summary
            $totalRules = $run.tool.driver.rules.Count
            Write-Host "`n🔍 Security Rules Applied" -ForegroundColor Green
            Write-Host "  Total security patterns checked: $totalRules" -ForegroundColor White
            
            # Results
            $findings = $run.results
            $findingCount = if ($findings) { $findings.Count } else { 0 }
            
            if ($findingCount -eq 0) {
                Write-Host "`n✅ Security Results" -ForegroundColor Green
                Write-Host "  🎉 EXCELLENT! No security vulnerabilities found!" -ForegroundColor Green
                Write-Host "  Your JavaScript code passed all $totalRules security checks." -ForegroundColor White
            } else {
                Write-Host "`n⚠️  Security Findings ($findingCount issues)" -ForegroundColor Red
                
                # Group findings by severity
                $criticalCount = ($findings | Where-Object { $_.level -eq "error" -or $_.properties."security-severity" -ge 9.0 }).Count
                $highCount = ($findings | Where-Object { $_.level -eq "error" -and $_.properties."security-severity" -lt 9.0 -and $_.properties."security-severity" -ge 7.0 }).Count
                $mediumCount = ($findings | Where-Object { $_.level -eq "warning" -and $_.properties."security-severity" -ge 4.0 }).Count
                $lowCount = $findingCount - $criticalCount - $highCount - $mediumCount
                
                Write-Host "  🔴 Critical: $criticalCount" -ForegroundColor Red
                Write-Host "  🟠 High: $highCount" -ForegroundColor Yellow
                Write-Host "  🟡 Medium: $mediumCount" -ForegroundColor Yellow
                Write-Host "  🟢 Low: $lowCount" -ForegroundColor White
                
                # Display detailed findings
                Write-Host "`n📋 Detailed Findings:" -ForegroundColor Yellow
                $findings | ForEach-Object -Begin { $counter = 1 } -Process {
                    $severity = if ($_.level) { $_.level } else { "info" }
                    $ruleId = if ($_.ruleId) { $_.ruleId } else { "unknown" }
                    $message = if ($_.message.text) { $_.message.text } else { "No description" }
                    $securitySeverity = if ($_.properties."security-severity") { $_.properties."security-severity" } else { "N/A" }
                    
                    $severityIcon = switch ($severity) {
                        "error" { "🔴" }
                        "warning" { "🟡" }
                        default { "ℹ️" }
                    }
                    
                    Write-Host "`n  $severityIcon Finding #$counter - $severity" -ForegroundColor White
                    Write-Host "     Rule: $ruleId" -ForegroundColor Cyan
                    Write-Host "     Security Score: $securitySeverity/10" -ForegroundColor Cyan
                    Write-Host "     Description: $message" -ForegroundColor White
                    
                    # Show location if available
                    if ($_.locations -and $_.locations[0].physicalLocation) {
                        $location = $_.locations[0].physicalLocation
                        $file = $location.artifactLocation.uri
                        $line = if ($location.region.startLine) { $location.region.startLine } else { "N/A" }
                        Write-Host "     Location: $file (line $line)" -ForegroundColor Gray
                    }
                    $counter++
                }
            }
            
            # Code Metrics
            if ($run.properties.metricResults) {
                Write-Host "`n📈 Code Metrics" -ForegroundColor Green
                $run.properties.metricResults | ForEach-Object {
                    $metricName = ($_.ruleId -split '/')[-1] -replace '-', ' ' | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) }
                    Write-Host "  ${metricName}: $($_.value)" -ForegroundColor White
                }
            }
            
            # Additional Information
            Write-Host "`n🔧 Additional Information" -ForegroundColor Green
            Write-Host "  SARIF Version: $($sarifData.version)" -ForegroundColor White
            Write-Host "  Schema: $($sarifData.'$schema')" -ForegroundColor White
            Write-Host "  Full Results: $((Get-Item $OutputPath).FullName)" -ForegroundColor Cyan
            
        } catch {
            Write-Warning "Failed to parse SARIF results: $_"
            Write-Host "Raw SARIF file available at: $OutputPath" -ForegroundColor Gray
        }
    }

} catch {
    Write-Error "CodeQL analysis failed: $_"
    exit 1
} finally {
    # Cleanup
    Write-Host "`nCleaning up temporary files..." -ForegroundColor Gray
    if (Test-Path $DatabasePath) {
        Remove-Item $DatabasePath -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "`n=== Analysis Complete ===" -ForegroundColor Green
Write-Host "Results saved to: $OutputPath" -ForegroundColor Cyan
