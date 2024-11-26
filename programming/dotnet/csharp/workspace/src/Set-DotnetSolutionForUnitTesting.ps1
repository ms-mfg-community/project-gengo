    # Create a new solution for the calculator project
    dotnet new sln -o calculator-xunit-testing

    # Change directory to the newly created solution directory
    cd calculator-xunit-testing

    # Create a new console application project named 'calculator' targeting .NET 8.0
    dotnet new console -o calculator -f net8.0 --use-program-main false

    # Add the 'calculator' project to the solution
    dotnet sln add ./calculator/calculator.csproj

    # Create a new xUnit test project named 'calculator.tests' targeting .NET 8.0
    dotnet new xunit -o calculator.tests -f net8.0

    # Add a reference to the 'calculator' project in the 'calculator.tests' project
    dotnet add ./calculator.tests/calculator.tests.csproj reference ./calculator/calculator.csproj

    # Add the 'calculator.tests' project to the solution
    dotnet sln add ./calculator.tests/calculator.tests.csproj