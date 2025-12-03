<#
.SYNOPSIS
    Sets up a .NET solution for a calculator application with xUnit testing.

.DESCRIPTION
    This script creates a complete .NET 8 solution structure including:
    - A solution folder named 'calculator-xunit-testing'
    - A console application project named 'calculator'
    - An xUnit test project named 'calculator.tests'
    - Appropriate project references
    - Renamed default files (Program.cs to Calculator.cs, UnitTest1.cs to CalculatorTest.cs)

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    
    Creates the calculator solution structure in the current directory.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : .NET 8 SDK must be installed
    Version        : 1.0
    
    Requirements:
    - .NET 8 SDK
    - PowerShell 5.1 or higher
    
    Change Log:
    - Version 1.0: Initial creation

#>

# Get the repository root path and set the workspace path
$repoRoot = git rev-parse --show-toplevel
$workspacePath = Join-Path -Path $repoRoot -ChildPath "programming\dotnet\csharp\workspace"

# Define solution and project names
$solutionFolder = "calculator-xunit-testing"
$solutionName = "calculator"
$consoleProjectName = "calculator"
$testProjectName = "calculator.tests"

# Set the working directory to the workspace path
Set-Location -Path $workspacePath

# Create the solution folder
Write-Host "Creating solution folder: $solutionFolder" -ForegroundColor Cyan
New-Item -ItemType Directory -Path $solutionFolder -Force | Out-Null

# Navigate into the solution folder
Set-Location -Path $solutionFolder

# Create a new solution
Write-Host "Creating solution: $solutionName.sln" -ForegroundColor Cyan
dotnet new sln -n $solutionName

# Create the console application project
Write-Host "Creating console application project: $consoleProjectName" -ForegroundColor Cyan
dotnet new console -n $consoleProjectName -f net8.0

# Create the xUnit test project
Write-Host "Creating xUnit test project: $testProjectName" -ForegroundColor Cyan
dotnet new xunit -n $testProjectName -f net8.0

# Add projects to the solution
Write-Host "Adding projects to solution" -ForegroundColor Cyan
dotnet sln add "$consoleProjectName\$consoleProjectName.csproj"
dotnet sln add "$testProjectName\$testProjectName.csproj"

# Add project reference from test project to console project
Write-Host "Adding project reference from test project to console project" -ForegroundColor Cyan
dotnet add "$testProjectName\$testProjectName.csproj" reference "$consoleProjectName\$consoleProjectName.csproj"

# Rename Program.cs to Calculator.cs in the console project
Write-Host "Renaming Program.cs to Calculator.cs" -ForegroundColor Cyan
$programPath = Join-Path -Path $consoleProjectName -ChildPath "Program.cs"
$calculatorPath = Join-Path -Path $consoleProjectName -ChildPath "Calculator.cs"
if (Test-Path -Path $programPath)
{
    Rename-Item -Path $programPath -NewName "Calculator.cs"
} #end if

# Rename UnitTest1.cs to CalculatorTest.cs in the test project
Write-Host "Renaming UnitTest1.cs to CalculatorTest.cs" -ForegroundColor Cyan
$unitTest1Path = Join-Path -Path $testProjectName -ChildPath "UnitTest1.cs"
$calculatorTestPath = Join-Path -Path $testProjectName -ChildPath "CalculatorTest.cs"
if (Test-Path -Path $unitTest1Path)
{
    Rename-Item -Path $unitTest1Path -NewName "CalculatorTest.cs"
    
    # Update the class name in the CalculatorTest.cs file
    $testContent = Get-Content -Path $calculatorTestPath -Raw
    $testContent = $testContent -replace 'public class UnitTest1', 'public class CalculatorTest'
    Set-Content -Path $calculatorTestPath -Value $testContent
} #end if

# Build the solution to ensure everything is set up correctly
Write-Host "`nBuilding solution to verify setup" -ForegroundColor Cyan
dotnet build

Write-Host "`nSolution setup completed successfully!" -ForegroundColor Green
Write-Host "Solution location: $workspacePath\$solutionFolder" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Navigate to: cd $solutionFolder" -ForegroundColor White
Write-Host "2. Implement calculator logic in: $consoleProjectName\Calculator.cs" -ForegroundColor White
Write-Host "3. Write tests in: $testProjectName\CalculatorTest.cs" -ForegroundColor White
Write-Host "4. Run tests with: dotnet test" -ForegroundColor White
Write-Host "5. Run the calculator with: dotnet run --project $consoleProjectName" -ForegroundColor White
