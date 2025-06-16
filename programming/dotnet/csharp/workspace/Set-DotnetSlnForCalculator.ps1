# Set-DotnetSlnForCalculator.ps1
# Script to set up a .NET 8 solution with a console app and xUnit test project for a calculator

# 1. Create a new folder for the solution named calculator-xunit-testing.
Write-Host "Creating solution directory 'calculator-xunit-testing'..." -ForegroundColor Cyan
$solutionDir = Join-Path -Path $PSScriptRoot -ChildPath "calculator-xunit-testing"
New-Item -Path $solutionDir -ItemType Directory -Force | Out-Null

# 2. Change into the newly created solution directory.
Write-Host "Changing to solution directory..." -ForegroundColor Cyan
Push-Location -Path $solutionDir

try {
    # 3. Create a new solution named calculator-xunit-testing.
    Write-Host "Creating new solution 'calculator-xunit-testing.sln'..." -ForegroundColor Cyan
    dotnet new sln --name calculator-xunit-testing
    
    # 4. Create a .NET 8 console application project named calculator without an explicit Main method and change the Program.cs filename to Calculator.cs
    Write-Host "Creating .NET 8 console application 'calculator'..." -ForegroundColor Cyan
    $calculatorDir = Join-Path -Path $solutionDir -ChildPath "calculator"
    dotnet new console --output calculator --framework net8.0 --use-program-main false
    
    # Rename Program.cs to Calculator.cs
    Write-Host "Renaming Program.cs to Calculator.cs..." -ForegroundColor Cyan
    $programPath = Join-Path -Path $calculatorDir -ChildPath "Program.cs"
    $calculatorPath = Join-Path -Path $calculatorDir -ChildPath "Calculator.cs"
    
    # Check if Program.cs exists before trying to rename
    if (Test-Path -Path $programPath) {
        Rename-Item -Path $programPath -NewName "Calculator.cs"
    } elseif (-not (Test-Path -Path $calculatorPath)) {
        # Create Calculator.cs if neither file exists
        Write-Host "Program.cs not found. Creating Calculator.cs..." -ForegroundColor Yellow
        @"
// Calculator.cs
Console.WriteLine("Hello, Calculator!");
"@ | Out-File -FilePath $calculatorPath
    }
    
    # 5. Add the calculator project to the solution.
    Write-Host "Adding calculator project to solution..." -ForegroundColor Cyan
    dotnet sln add calculator
    
    # 6. Create a new xUnit test project named calculator.tests, targeting .NET 8 and change the default cs name from UnitTest1.cs to CalculatorTest.cs
    Write-Host "Creating xUnit test project 'calculator.tests'..." -ForegroundColor Cyan
    dotnet new xunit --output calculator.tests --framework net8.0
    
    # Rename UnitTest1.cs to CalculatorTest.cs
    Write-Host "Renaming UnitTest1.cs to CalculatorTest.cs..." -ForegroundColor Cyan
    $unitTestPath = Join-Path -Path (Join-Path -Path $solutionDir -ChildPath "calculator.tests") -ChildPath "UnitTest1.cs"
    $calcTestPath = Join-Path -Path (Join-Path -Path $solutionDir -ChildPath "calculator.tests") -ChildPath "CalculatorTest.cs"
    
    # Check if UnitTest1.cs exists before trying to rename
    if (Test-Path -Path $unitTestPath) {
        Rename-Item -Path $unitTestPath -NewName "CalculatorTest.cs"
    } elseif (-not (Test-Path -Path $calcTestPath)) {
        # Create CalculatorTest.cs if neither file exists
        Write-Host "UnitTest1.cs not found. Creating CalculatorTest.cs..." -ForegroundColor Yellow
        @"
using Xunit;

public class CalculatorTest
{
    [Fact]
    public void Test1()
    {
        Assert.True(true);
    }
}
"@ | Out-File -FilePath $calcTestPath
    }
    
    # 7. Add a project reference from calculator.tests to calculator.
    Write-Host "Adding project reference from calculator.tests to calculator..." -ForegroundColor Cyan
    dotnet add calculator.tests reference calculator
    
    # 8. Add the calculator.tests project to the solution.
    Write-Host "Adding calculator.tests project to solution..." -ForegroundColor Cyan
    dotnet sln add calculator.tests
    
    # Verify the solution setup
    Write-Host "Solution setup completed. Projects in solution:" -ForegroundColor Green
    dotnet sln list
    
    # Build the solution to verify everything works
    Write-Host "Building solution to verify setup..." -ForegroundColor Cyan
    dotnet build
    
    # Summary
    Write-Host "`nSetup Complete!" -ForegroundColor Green
    Write-Host "Solution: $solutionDir\calculator-xunit-testing.sln" -ForegroundColor Green
    Write-Host "Calculator Project: $calculatorDir" -ForegroundColor Green
    Write-Host "Tests Project: $solutionDir\calculator.tests" -ForegroundColor Green
}
finally {
    # Return to the original directory
    Pop-Location
}