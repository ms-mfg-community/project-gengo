<#
.SYNOPSIS
    Sets up a .NET 8 calculator solution with xUnit testing framework.

.DESCRIPTION
    Creates a complete solution structure for a calculator application with comprehensive xUnit testing.
    This script automates the setup of:
    - Solution folder named 'calculator-xunit-testing'
    - Console application project named 'calculator'
    - xUnit test project named 'calculator.tests'
    - Proper project references and configurations
    - Renamed default files for clarity

.PARAMETER WorkspacePath
    The base workspace path where the calculator solution will be created.
    If not provided, uses the current script's directory.

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1

    Creates the calculator solution in the script's directory.

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1 -WorkspacePath "c:\projects"

    Creates the calculator solution in the specified directory.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : .NET 8 SDK installed and available in PATH
    Version        : 1.0
    
    This script requires:
    - .NET 8 SDK or later
    - PowerShell 5.1 or higher
    - Write permissions to the workspace directory

.LINK
    https://docs.microsoft.com/en-us/dotnet/

#>

param(
    [Parameter(Mandatory = $false, HelpMessage = "Base workspace path for solution creation")]
    [string]$WorkspacePath = $PSScriptRoot
)

# Ensure the workspace path exists
if (-not (Test-Path -Path $WorkspacePath -PathType Container)) {
    Write-Host "Error: Workspace path does not exist: $WorkspacePath" -ForegroundColor Red
    exit 1
} # end if

Write-Host "Setting up .NET Calculator Solution with xUnit Testing" -ForegroundColor Cyan
Write-Host "Workspace Path: $WorkspacePath" -ForegroundColor Gray

# Define solution and project variables
$SolutionFolder = "calculator-xunit-testing"
$SolutionPath = Join-Path -Path $WorkspacePath -ChildPath $SolutionFolder
$ConsoleAppProject = "calculator"
$TestProject = "calculator.tests"

# Create solution folder
Write-Host "`nStep 1: Creating solution folder..." -ForegroundColor Yellow
if (Test-Path -Path $SolutionPath) {
    Write-Host "Solution folder already exists. Removing..." -ForegroundColor Cyan
    Remove-Item -Path $SolutionPath -Recurse -Force
} # end if
New-Item -Path $SolutionPath -ItemType Directory -Force | Out-Null
Write-Host "Solution folder created: $SolutionPath" -ForegroundColor Green

# Change to solution directory
Push-Location -Path $SolutionPath

try {
    # Create the solution file
    Write-Host "`nStep 2: Creating solution file..." -ForegroundColor Yellow
    dotnet new sln --name "Calculator" --force | Out-Null
    Write-Host "Solution file created: Calculator.sln" -ForegroundColor Green

    # Create console application project
    Write-Host "`nStep 3: Creating console application project..." -ForegroundColor Yellow
    dotnet new console --name $ConsoleAppProject --framework net8.0 | Out-Null
    Write-Host "Console application project created: $ConsoleAppProject" -ForegroundColor Green

    # Create xUnit test project
    Write-Host "`nStep 4: Creating xUnit test project..." -ForegroundColor Yellow
    dotnet new xunit --name $TestProject --framework net8.0 | Out-Null
    Write-Host "xUnit test project created: $TestProject" -ForegroundColor Green

    # Add projects to solution
    Write-Host "`nStep 5: Adding projects to solution..." -ForegroundColor Yellow
    dotnet sln add (Join-Path -Path $ConsoleAppProject -ChildPath "$ConsoleAppProject.csproj") | Out-Null
    dotnet sln add (Join-Path -Path $TestProject -ChildPath "$TestProject.csproj") | Out-Null
    Write-Host "Projects added to solution" -ForegroundColor Green

    # Add project reference (test project references calculator project)
    Write-Host "`nStep 6: Configuring project references..." -ForegroundColor Yellow
    Push-Location -Path $TestProject
    $CalcProjectRef = ".." | Join-Path -ChildPath $ConsoleAppProject | Join-Path -ChildPath "$ConsoleAppProject.csproj"
    dotnet add reference $CalcProjectRef | Out-Null
    Pop-Location
    Write-Host "Project references configured" -ForegroundColor Green

    # Rename default files
    Write-Host "`nStep 7: Renaming default files..." -ForegroundColor Yellow

    # Rename Program.cs to Calculator.cs
    $ConsoleAppProgramPath = Join-Path -Path $ConsoleAppProject -ChildPath "Program.cs"
    $ConsoleAppCalculatorPath = Join-Path -Path $ConsoleAppProject -ChildPath "Calculator.cs"
    if (Test-Path -Path $ConsoleAppProgramPath) {
        Rename-Item -Path $ConsoleAppProgramPath -NewName "Calculator.cs" -Force
        Write-Host "Renamed: Program.cs -> Calculator.cs" -ForegroundColor Green
    } # end if

    # Rename UnitTest1.cs to CalculatorTest.cs
    $TestProjectUnitTestPath = Join-Path -Path $TestProject -ChildPath "UnitTest1.cs"
    $TestProjectCalculatorTestPath = Join-Path -Path $TestProject -ChildPath "CalculatorTest.cs"
    if (Test-Path -Path $TestProjectUnitTestPath) {
        Rename-Item -Path $TestProjectUnitTestPath -NewName "CalculatorTest.cs" -Force
        Write-Host "Renamed: UnitTest1.cs -> CalculatorTest.cs" -ForegroundColor Green
    } # end if

    # Build the solution to verify everything is set up correctly
    Write-Host "`nStep 8: Building solution to verify setup..." -ForegroundColor Yellow
    dotnet build | Out-Null
    Write-Host "Solution built successfully" -ForegroundColor Green

    Write-Host "`n" + "=" * 60 -ForegroundColor Cyan
    Write-Host "Setup Complete!" -ForegroundColor Green
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "`nSolution Details:" -ForegroundColor Yellow
    Write-Host "  Location: $SolutionPath" -ForegroundColor Gray
    Write-Host "  Solution File: Calculator.sln" -ForegroundColor Gray
    Write-Host "  Console App: $ConsoleAppProject" -ForegroundColor Gray
    Write-Host "  Test Project: $TestProject" -ForegroundColor Gray
    Write-Host "`nNext Steps:" -ForegroundColor Yellow
    Write-Host "  1. Navigate to the solution folder: cd '$SolutionFolder'" -ForegroundColor Gray
    Write-Host "  2. Open in VS Code: code ." -ForegroundColor Gray
    Write-Host "  3. Review and edit Calculator.cs for application logic" -ForegroundColor Gray
    Write-Host "  4. Write tests in CalculatorTest.cs" -ForegroundColor Gray
    Write-Host "  5. Run tests: dotnet test" -ForegroundColor Gray
    Write-Host "`nUseful Commands:" -ForegroundColor Yellow
    Write-Host "  dotnet build          - Build the solution" -ForegroundColor Gray
    Write-Host "  dotnet run -p calculator - Run the calculator app" -ForegroundColor Gray
    Write-Host "  dotnet test           - Run all tests" -ForegroundColor Gray
    Write-Host "  dotnet watch test     - Watch for changes and run tests" -ForegroundColor Gray

} catch {
    Write-Host "Error during setup: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
} # end try catch finally

Write-Host "`n"
