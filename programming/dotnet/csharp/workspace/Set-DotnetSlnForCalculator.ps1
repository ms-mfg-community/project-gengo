# Set-DotnetSlnForCalculator.ps1
# 1. Create a new folder for the solution named calculator-xunit-testing.
$solutionDir = "calculator-xunit-testing"
New-Item -ItemType Directory -Path $solutionDir -Force | Out-Null

# 2. Change into the newly created solution directory.
Set-Location $solutionDir

# 3. Create a new solution named calculator-xunit-testing.
dotnet new sln -n calculator-xunit-testing

# 4. Create a .NET 8 console application project named calculator (without an explicit Main method).
dotnet new console -n calculator --framework net8.0

# 5. Rename Program.cs to Calculator.cs.
Rename-Item -Path .\calculator\Program.cs -NewName Calculator.cs

# 6. Add the calculator project to the solution.
dotnet sln add .\calculator\calculator.csproj

# 7. Create a new xUnit test project named calculator.tests, targeting .NET 8.
dotnet new xunit -n calculator.tests --framework net8.0

# 8. Rename UnitTest1.cs to CalculatorTest.cs.
Rename-Item -Path .\calculator.tests\UnitTest1.cs -NewName CalculatorTest.cs

# 9. Add a project reference from calculator.tests to calculator.
dotnet add .\calculator.tests\calculator.tests.csproj reference .\calculator\calculator.csproj

# 10. Add the calculator.tests project to the solution.
dotnet sln add .\calculator.tests\calculator.tests.csproj
