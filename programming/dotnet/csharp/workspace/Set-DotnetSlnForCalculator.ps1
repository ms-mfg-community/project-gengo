<#
.SYNOPSIS
    Sets up the .NET calculator solution structure with xUnit testing.

.DESCRIPTION
    Creates a new solution folder, console application project, and xUnit test project.
    Configures project references and renames default files for better organization.

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1

.NOTES
    This script creates the following structure:
    - calculator-xunit-testing/
      - calculator/
        - Calculator.cs
      - calculator.tests/
        - CalculatorTest.cs
#>

# Get the repository root
$repoRoot = git rev-parse --show-toplevel
$workspacePath = Join-Path $repoRoot "programming\dotnet\csharp\workspace"
$solutionPath = Join-Path $workspacePath "calculator-xunit-testing"

Write-Host "Repository root: $repoRoot" -ForegroundColor Gray
Write-Host "Workspace path: $workspacePath" -ForegroundColor Gray

# Create the solution folder
Write-Host "Creating solution folder at $solutionPath..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $solutionPath -Force | Out-Null
Push-Location $solutionPath

# Create the solution
Write-Host "Creating new solution..." -ForegroundColor Cyan
& dotnet new sln -n calculator-xunit-testing --force

# Create console application project
Write-Host "Creating console application project..." -ForegroundColor Cyan
& dotnet new console -n calculator --force -f net8.0

# Rename Program.cs to Calculator.cs
if (Test-Path "calculator\Program.cs") {
    Remove-Item "calculator\Program.cs" -Force
}
New-Item -Path "calculator\Calculator.cs" -ItemType File -Value '// Calculator implementation' -Force | Out-Null

# Create xUnit test project
Write-Host "Creating xUnit test project..." -ForegroundColor Cyan
& dotnet new xunit -n calculator.tests --force -f net8.0

# Rename UnitTest1.cs to CalculatorTest.cs
if (Test-Path "calculator.tests\UnitTest1.cs") {
    Remove-Item "calculator.tests\UnitTest1.cs" -Force
}
New-Item -Path "calculator.tests\CalculatorTest.cs" -ItemType File -Value 'using Xunit;' -Force | Out-Null

# Find the solution file (could be .sln or .slnx)
$slnFile = Get-ChildItem -Path (Get-Location) -Filter "calculator-xunit-testing.*" | Where-Object { $_.Extension -in @('.sln', '.slnx') } | Select-Object -First 1

if ($slnFile) {
    Write-Host "Solution file found: $($slnFile.Name)" -ForegroundColor Green
    
    # Add projects to solution
    Write-Host "Adding projects to solution..." -ForegroundColor Cyan
    & dotnet sln $slnFile.Name add calculator\calculator.csproj
    & dotnet sln $slnFile.Name add calculator.tests\calculator.tests.csproj
    
    # Add project reference from test project to console application
    Write-Host "Configuring project references..." -ForegroundColor Cyan
    & dotnet add calculator.tests\calculator.tests.csproj reference calculator\calculator.csproj
    
    Write-Host "Solution projects added successfully!" -ForegroundColor Green
} else {
    Write-Host "Warning: Solution file not found" -ForegroundColor Yellow
}

Pop-Location

Write-Host "Solution setup complete!" -ForegroundColor Green
Write-Host "Solution location: $solutionPath" -ForegroundColor Green
Write-Host "" -ForegroundColor Gray
Write-Host "Project structure:" -ForegroundColor Gray
Get-ChildItem $solutionPath -Recurse -Include "*.cs" | ForEach-Object { 
    $relativePath = $_.FullName.Replace($solutionPath, "").TrimStart("\")
    Write-Host "  - $relativePath" 
}
