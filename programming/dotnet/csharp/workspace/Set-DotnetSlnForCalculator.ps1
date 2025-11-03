<#
.SYNOPSIS
    Sets up the .NET solution structure for the calculator application with xUnit testing.

.DESCRIPTION
    This script creates a complete .NET 8 solution structure including:
    - A solution folder named 'calculator-xunit-testing'
    - A console application project named 'calculator'
    - An xUnit test project named 'calculator.tests'
    - Proper project references between the test and application projects
    - Renaming of default files to Calculator.cs and CalculatorTest.cs

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    
    Creates the calculator solution structure in the workspace directory.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : .NET 8 SDK must be installed
    Version        : 1.0
    
    Requirements:
    - .NET 8 SDK or later
    - PowerShell 5.1 or later
    - Write permissions in the workspace directory
#>

# Get the repository root path
$repoRoot = git rev-parse --show-toplevel
if (-not $repoRoot) {
    Write-Error "Failed to determine repository root. Ensure you are in a git repository."
    exit 1
} # end if

# Set the workspace path
$workspacePath = Join-Path $repoRoot "programming\dotnet\csharp\workspace"

# Create solution directory
$solutionDir = Join-Path $workspacePath "calculator-xunit-testing"

Write-Host "Creating solution structure at: $solutionDir" -ForegroundColor Cyan

# Create the solution directory if it doesn't exist
if (Test-Path $solutionDir) {
    Write-Warning "Solution directory already exists. Removing it first..."
    Remove-Item -Path $solutionDir -Recurse -Force
} # end if

New-Item -Path $solutionDir -ItemType Directory -Force | Out-Null

# Change to the solution directory
Set-Location $solutionDir

try {
    # Create the solution
    Write-Host "Creating solution..." -ForegroundColor Green
    dotnet new sln -n calculator-xunit-testing
    
    # Create the console application project
    Write-Host "Creating console application project 'calculator'..." -ForegroundColor Green
    dotnet new console -n calculator -f net8.0
    
    # Create the xUnit test project
    Write-Host "Creating xUnit test project 'calculator.tests'..." -ForegroundColor Green
    dotnet new xunit -n calculator.tests -f net8.0
    
    # Add projects to the solution
    Write-Host "Adding projects to solution..." -ForegroundColor Green
    dotnet sln add calculator/calculator.csproj
    dotnet sln add calculator.tests/calculator.tests.csproj
    
    # Add project reference from test project to application project
    Write-Host "Adding project reference..." -ForegroundColor Green
    dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj
    
    # Rename Program.cs to Calculator.cs
    Write-Host "Renaming Program.cs to Calculator.cs..." -ForegroundColor Green
    $programPath = Join-Path $solutionDir "calculator/Program.cs"
    $calculatorPath = Join-Path $solutionDir "calculator/Calculator.cs"
    if (Test-Path $programPath) {
        Move-Item -Path $programPath -Destination $calculatorPath -Force
    } # end if
    
    # Rename UnitTest1.cs to CalculatorTest.cs
    Write-Host "Renaming UnitTest1.cs to CalculatorTest.cs..." -ForegroundColor Green
    $unitTestPath = Join-Path $solutionDir "calculator.tests/UnitTest1.cs"
    $calculatorTestPath = Join-Path $solutionDir "calculator.tests/CalculatorTest.cs"
    if (Test-Path $unitTestPath) {
        Move-Item -Path $unitTestPath -Destination $calculatorTestPath -Force
    } # end if
    
    Write-Host "`nSolution structure created successfully!" -ForegroundColor Green
    Write-Host "Solution location: $solutionDir" -ForegroundColor Cyan
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "1. Navigate to: cd $solutionDir" -ForegroundColor White
    Write-Host "2. Build the solution: dotnet build" -ForegroundColor White
    Write-Host "3. Run tests: dotnet test" -ForegroundColor White
    Write-Host "4. Run the calculator: dotnet run --project calculator" -ForegroundColor White
}
catch {
    Write-Error "An error occurred while setting up the solution: $_"
    exit 1
}
finally {
    # Return to the original directory
    Set-Location $workspacePath
}
# end try-catch-finally

Write-Host "`nSetup complete!" -ForegroundColor Green
