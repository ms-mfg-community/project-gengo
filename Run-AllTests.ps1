<#
.SYNOPSIS
    Run all tests across the project-gengo repository

.DESCRIPTION
    This script executes tests for Python, .NET, Node.js, and Go projects
    across the entire project-gengo polyglot repository.

.EXAMPLE
    .\Run-AllTests.ps1
    
    Runs all tests and displays results with color-coded output.

.NOTES
    File Name      : Run-AllTests.ps1
    Prerequisite   : Python (with pytest), .NET SDK, Node.js (with npm), Go
    Version        : 1.0
    
    Requirements:
    - pytest for Python tests
    - .NET SDK for xUnit tests
    - Node.js and npm for Jest tests
    - Go for Go tests
#>

# Set error action preference
$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Blue
Write-Host "Project Gengo - Comprehensive Test Suite" -ForegroundColor Blue
Write-Host "========================================" -ForegroundColor Blue
Write-Host ""

# Counter for test results
$totalPassed = 0
$totalFailed = 0
$testResults = @()

# Function to print section header
function Write-SectionHeader {
    param([string]$Title)
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Blue
    Write-Host $Title -ForegroundColor Blue
    Write-Host "========================================" -ForegroundColor Blue
} # end Write-SectionHeader

# Function to report test results
function Report-TestResults {
    param(
        [bool]$Success,
        [int]$TestCount,
        [string]$TestName
    )
    
    if ($Success) {
        Write-Host "✓ Tests passed: $TestCount" -ForegroundColor Green
        $script:totalPassed += $TestCount
        $script:testResults += [PSCustomObject]@{
            TestSuite = $TestName
            Status = "PASSED"
            Count = $TestCount
        }
    } else {
        Write-Host "✗ Tests failed" -ForegroundColor Red
        $script:totalFailed++
        $script:testResults += [PSCustomObject]@{
            TestSuite = $TestName
            Status = "FAILED"
            Count = $TestCount
        }
    } # end if
} # end Report-TestResults

# Get repository root
$repoRoot = Split-Path -Parent $PSScriptRoot
if (-not $repoRoot) {
    $repoRoot = $PSScriptRoot
} # end if

# Python Tests
Write-SectionHeader "Running Python Tests (pytest)"

Write-Host "1. Calculator tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\python\completed\src\calculator"
try {
    python -m pytest test_calculator.py -v --tb=short
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 7 -TestName "Python Calculator"
} catch {
    Report-TestResults -Success $false -TestCount 7 -TestName "Python Calculator"
} # end try
Pop-Location

Write-Host ""
Write-Host "2. Rock-Paper-Scissors game tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\python\completed\src\rps-demo-py"
try {
    python -m pytest test_game.py -v --tb=short
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 9 -TestName "Python RPS Game"
} catch {
    Report-TestResults -Success $false -TestCount 9 -TestName "Python RPS Game"
} # end try
Pop-Location

Write-Host ""
Write-Host "3. Calculator tests (DotNet workspace - Python)..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\dotnet\csharp\workspace\calculator-xunit-testing\python"
try {
    python -m pytest tests/test_calculator.py -v --tb=short
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 32 -TestName "Python Calculator (DotNet Workspace)"
} catch {
    Report-TestResults -Success $false -TestCount 32 -TestName "Python Calculator (DotNet Workspace)"
} # end try
Pop-Location

Write-Host ""
Write-Host "4. Calculator tests (DotNet experimental - Python)..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\dotnet\csharp\experimental\calculator-xunit-testing\python"
try {
    python -m pytest tests/test_calculator.py -v --tb=short
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 32 -TestName "Python Calculator (DotNet Experimental)"
} catch {
    Report-TestResults -Success $false -TestCount 32 -TestName "Python Calculator (DotNet Experimental)"
} # end try
Pop-Location

# .NET Tests
Write-SectionHeader "Running .NET Tests (xUnit)"

Write-Host "1. Calculator workspace tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\dotnet\csharp\workspace\calculator-xunit-testing"
try {
    dotnet test calculator.tests\calculator.tests.csproj --verbosity quiet
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 32 -TestName ".NET Calculator Workspace"
} catch {
    Report-TestResults -Success $false -TestCount 32 -TestName ".NET Calculator Workspace"
} # end try
Pop-Location

Write-Host ""
Write-Host "2. Calculator experimental tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\dotnet\csharp\experimental\calculator-xunit-testing"
try {
    dotnet test calculator.tests\calculator.tests.csproj --verbosity quiet
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 32 -TestName ".NET Calculator Experimental"
} catch {
    Report-TestResults -Success $false -TestCount 32 -TestName ".NET Calculator Experimental"
} # end try
Pop-Location

Write-Host ""
Write-Host "3. Calculator completed tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\dotnet\csharp\completed\calculator-xunit-testing"
try {
    dotnet test calculator.tests\calculator.tests.csproj --verbosity quiet
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 39 -TestName ".NET Calculator Completed"
} catch {
    Report-TestResults -Success $false -TestCount 39 -TestName ".NET Calculator Completed"
} # end try
Pop-Location

# Node.js Tests
Write-SectionHeader "Running Node.js Tests (Jest)"

Write-Host "1. Calculator tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\node\completed\calculator"
try {
    npm test
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 20 -TestName "Node.js Calculator"
} catch {
    Report-TestResults -Success $false -TestCount 20 -TestName "Node.js Calculator"
} # end try
Pop-Location

# Go Tests
Write-SectionHeader "Running Go Tests"

Write-Host "1. Statistics tests..." -ForegroundColor Cyan
Push-Location "$repoRoot\programming\go\completed\src"
try {
    go test -v ./...
    Report-TestResults -Success ($LASTEXITCODE -eq 0) -TestCount 5 -TestName "Go Statistics"
} catch {
    Report-TestResults -Success $false -TestCount 5 -TestName "Go Statistics"
} # end try
Pop-Location

# Summary
Write-SectionHeader "Test Execution Summary"
Write-Host ""

# Display results table
$testResults | Format-Table -AutoSize

Write-Host ""
Write-Host "Total tests passed: $totalPassed" -ForegroundColor Cyan
Write-Host "Total test suites failed: $totalFailed" -ForegroundColor Cyan
Write-Host ""

if ($totalFailed -eq 0) {
    Write-Host "✓ All test suites passed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "✗ Some test suites failed" -ForegroundColor Red
    exit 1
} # end if
