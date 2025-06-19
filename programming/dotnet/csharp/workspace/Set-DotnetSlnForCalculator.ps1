# Set-DotnetSlnForCalculator.ps1
# This script sets up a .NET 8 solution with a console app and an xUnit test project for a calculator application.

# 1. Create a new folder for the solution named `calculator-xunit-testing`.
Write-Host "Creating solution directory: calculator-xunit-testing" -ForegroundColor Green
New-Item -ItemType Directory -Path "calculator-xunit-testing" -Force | Out-Null

# 2. Change into the newly created solution directory.
Write-Host "Changing to solution directory" -ForegroundColor Green
Set-Location -Path "calculator-xunit-testing"

# 3. Create a new solution named `calculator-xunit-testing`.
Write-Host "Creating new solution: calculator-xunit-testing.sln" -ForegroundColor Green
dotnet new sln --name "calculator-xunit-testing"

# 4. Create a .NET 8 console application project named `calculator` without an explicit Main method and change the `Program.cs` filename to `Calculator.cs`
Write-Host "Creating console application project: calculator" -ForegroundColor Green
dotnet new console --name "calculator" --framework "net8.0" --use-program-main false

# Rename Program.cs to Calculator.cs
Write-Host "Renaming Program.cs to Calculator.cs" -ForegroundColor Green
$programFile = Join-Path -Path "calculator" -ChildPath "Program.cs"
$calculatorFile = Join-Path -Path "calculator" -ChildPath "Calculator.cs"

if (Test-Path $programFile) {
    Rename-Item -Path $programFile -NewName "Calculator.cs"
} else {
    Write-Warning "Program.cs not found. This might be due to changes in .NET 8 templates. Please verify the file structure."
}

# 5. Add the calculator project to the solution.
Write-Host "Adding calculator project to the solution" -ForegroundColor Green
dotnet sln add "calculator/calculator.csproj"

# 6. Create a new xUnit test project named `calculator.tests`, targeting .NET 8 and change the default cs name from `UnitTest1.cs` to `CalculatorTest.cs`
Write-Host "Creating xUnit test project: calculator.tests" -ForegroundColor Green
dotnet new xunit --name "calculator.tests" --framework "net8.0"

# Rename UnitTest1.cs to CalculatorTest.cs
Write-Host "Renaming UnitTest1.cs to CalculatorTest.cs" -ForegroundColor Green
$unitTestFile = Join-Path -Path "calculator.tests" -ChildPath "UnitTest1.cs"
$calculatorTestFile = Join-Path -Path "calculator.tests" -ChildPath "CalculatorTest.cs"

if (Test-Path $unitTestFile) {
    Rename-Item -Path $unitTestFile -NewName "CalculatorTest.cs"
} else {
    Write-Warning "UnitTest1.cs not found. This might be due to changes in xUnit templates. Please verify the file structure."
}

# 7. Add a project reference from `calculator.tests` to `calculator`.
Write-Host "Adding project reference from calculator.tests to calculator" -ForegroundColor Green
dotnet add "calculator.tests/calculator.tests.csproj" reference "calculator/calculator.csproj"

# 8. Add the `calculator.tests` project to the solution.
Write-Host "Adding calculator.tests project to the solution" -ForegroundColor Green
dotnet sln add "calculator.tests/calculator.tests.csproj"

# Return to the original directory
Set-Location -Path ".."

Write-Host "`nSolution setup completed successfully!" -ForegroundColor Green
Write-Host "Solution structure:" -ForegroundColor Yellow
Write-Host "- calculator-xunit-testing.sln" -ForegroundColor White
Write-Host "- calculator/" -ForegroundColor White
Write-Host "  - calculator.csproj" -ForegroundColor White
Write-Host "  - Calculator.cs" -ForegroundColor White
Write-Host "- calculator.tests/" -ForegroundColor White
Write-Host "  - calculator.tests.csproj" -ForegroundColor White
Write-Host "  - CalculatorTest.cs" -ForegroundColor White

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Navigate to the calculator project: cd calculator-xunit-testing/calculator" -ForegroundColor White
Write-Host "2. Edit Calculator.cs to implement the calculator functionality" -ForegroundColor White
Write-Host "3. Edit calculator.tests/CalculatorTest.cs to add unit tests" -ForegroundColor White
Write-Host "4. Build and run the solution with: dotnet build ../calculator-xunit-testing.sln" -ForegroundColor White