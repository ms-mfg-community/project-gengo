# Set-DotnetSlnForCalculator.ps1

# 1. Create a new folder for the solution named calculator-xunit-testing.
$solutionDir = "calculator-xunit-testing"
New-Item -ItemType Directory -Path $solutionDir

# 2. Change into the newly created solution directory.
Set-Location -Path $solutionDir

# 3. Create a new solution named calculator-xunit-testing.
dotnet new sln -n calculator-xunit-testing

# 4. Create a .NET 8 console application project named calculator without an explicit Main method and change the Program.cs filename to Calculator.cs
dotnet new console -n calculator --framework net8.0 --use-program-main false
Rename-Item -Path "calculator/Program.cs" -NewName "Calculator.cs"

# 5. Add the calculator project to the solution.
dotnet sln add calculator/calculator.csproj

# 6. Create a new xUnit test project named calculator.tests, targeting .NET 8 and change the default cs name from UnitTest1.cs to CalculatorTest.cs
dotnet new xunit -n calculator.tests --framework net8.0
Rename-Item -Path "calculator.tests/UnitTest1.cs" -NewName "CalculatorTest.cs"

# 7. Add a project reference from calculator.tests to calculator.
dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj

# 8. Add the calculator.tests project to the solution.
dotnet sln add calculator.tests/calculator.tests.csproj

#end FunctionName
