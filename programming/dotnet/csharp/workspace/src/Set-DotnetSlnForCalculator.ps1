# 1. Create a new solution named calculator-xunit-testing.
dotnet new sln -n calculator-xunit-testing

# 2. Change into the newly created solution directory.
Set-Location calculator-xunit-testing

# 3. Create a .NET 8 console application project named calculator without an explicit Main method and rename Program.cs to Calculator.cs.
dotnet new console -o calculator -f net8.0 --use-program-main false
Rename-Item .\calculator\Program.cs .\calculator\Calculator.cs

# 4. Add the calculator project to the solution.
dotnet sln add .\calculator\calculator.csproj

# 5. Create a new xUnit test project named calculator.tests, targeting .NET 8.
dotnet new xunit -o calculator.tests -f net8.0

# 6. Add a project reference from calculator.tests to calculator.
dotnet add .\calculator.tests\calculator.tests.csproj reference .\calculator\calculator.csproj

# 7. Add the calculator.tests project to the solution.
dotnet sln add .\calculator.tests\calculator.tests.csproj
