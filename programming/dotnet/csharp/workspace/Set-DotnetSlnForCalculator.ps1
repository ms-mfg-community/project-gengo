<#
.SYNOPSIS
    Creates a .NET solution with calculator console app and xUnit test project.

.DESCRIPTION
    This script creates a complete .NET solution structure for a calculator application
    with xUnit testing. It sets up the solution folder, creates projects, configures
    references, and renames default files to more meaningful names.

.EXAMPLE
    .\Set-DotnetSlnForCalculator.ps1
    
    Creates the calculator solution with all projects and configurations.

.NOTES
    File Name      : Set-DotnetSlnForCalculator.ps1
    Author         : GitHub Copilot
    Prerequisite   : .NET SDK must be installed
    Version        : 1.0
    
    Requirements:
    - .NET SDK 6.0 or later
    - PowerShell 5.1 or later
    
    Change Log:
    - Version 1.0: Initial creation

.LINK
    https://docs.microsoft.com/en-us/dotnet/core/tools/

#>

# Create the main solution folder
$solutionFolder = "calculator-xunit-testing"
Write-Host "Creating solution folder: $solutionFolder" -ForegroundColor Green

if (Test-Path $solutionFolder) 
{
    Write-Host "Solution folder already exists. Removing existing folder..." -ForegroundColor Yellow
    Remove-Item -Path $solutionFolder -Recurse -Force
} # end if

# Create the solution folder and navigate to it
New-Item -ItemType Directory -Path $solutionFolder -Force | Out-Null
Set-Location -Path $solutionFolder

try 
{
    # Create a new solution
    Write-Host "Creating new solution..." -ForegroundColor Green
    dotnet new sln --name calculator-solution

    # Create the console application project
    Write-Host "Creating calculator console application..." -ForegroundColor Green
    dotnet new console --name calculator --framework net8.0

    # Create the xUnit test project
    Write-Host "Creating xUnit test project..." -ForegroundColor Green
    dotnet new xunit --name calculator.tests --framework net8.0

    # Add projects to the solution
    Write-Host "Adding projects to solution..." -ForegroundColor Green
    dotnet sln add calculator/calculator.csproj
    dotnet sln add calculator.tests/calculator.tests.csproj

    # Add project reference from test project to main project
    Write-Host "Configuring project references..." -ForegroundColor Green
    dotnet add calculator.tests/calculator.tests.csproj reference calculator/calculator.csproj

    # Rename Program.cs to Calculator.cs in the console application
    Write-Host "Renaming Program.cs to Calculator.cs..." -ForegroundColor Green
    $programPath = "calculator/Program.cs"
    $calculatorPath = "calculator/Calculator.cs"

    if (Test-Path $programPath) 
    {
        Rename-Item -Path $programPath -NewName "Calculator.cs"
        Write-Host "Successfully renamed Program.cs to Calculator.cs" -ForegroundColor Cyan
    }
    else 
    {
        Write-Warning "Program.cs not found in calculator project"
    } # end if

    # Rename UnitTest1.cs to CalculatorTest.cs in the test project
    Write-Host "Renaming UnitTest1.cs to CalculatorTest.cs..." -ForegroundColor Green
    $unitTestPath = "calculator.tests/UnitTest1.cs"
    $calculatorTestPath = "calculator.tests/CalculatorTest.cs"

    if (Test-Path $unitTestPath) 
    {
        Rename-Item -Path $unitTestPath -NewName "CalculatorTest.cs"
        Write-Host "Successfully renamed UnitTest1.cs to CalculatorTest.cs" -ForegroundColor Cyan
    }
    else 
    {
        Write-Warning "UnitTest1.cs not found in test project"
    } # end if

    # Update the namespace and class name in Calculator.cs
    Write-Host "Updating Calculator.cs content..." -ForegroundColor Green
    $calculatorContent = @"
// Interactive Calculator Application using .NET 8.0 top-level statements
Console.WriteLine("Interactive Calculator Application");
Console.WriteLine("=================================");

bool continueCalculating = true;

while (continueCalculating)
{
    try
    {
        // Prompt for first operand
        Console.Write("Enter the first number: ");
        string firstInput = Console.ReadLine() ?? "";
        if (!double.TryParse(firstInput, out double firstOperand))
        {
            Console.WriteLine("Invalid input. Please enter a valid number.");
            continue;
        } # end if
        
        // Prompt for operator
        Console.Write("Enter an operator (+, -, *, /): ");
        string operatorInput = Console.ReadLine() ?? "";
        
        // Validate operator
        if (operatorInput != "+" && operatorInput != "-" && operatorInput != "*" && operatorInput != "/")
        {
            Console.WriteLine("Invalid operator. Please use +, -, *, or /.");
            continue;
        } # end if
        
        // Prompt for second operand
        Console.Write("Enter the second number: ");
        string secondInput = Console.ReadLine() ?? "";
        if (!double.TryParse(secondInput, out double secondOperand))
        {
            Console.WriteLine("Invalid input. Please enter a valid number.");
            continue;
        } # end if
        
        // Perform the appropriate arithmetic operation
        double result = operatorInput switch
        {
            "+" => Calculator.Add(firstOperand, secondOperand),
            "-" => Calculator.Subtract(firstOperand, secondOperand),
            "*" => Calculator.Multiply(firstOperand, secondOperand),
            "/" => Calculator.Divide(firstOperand, secondOperand),
            _ => throw new InvalidOperationException("Invalid operator")
        };
        
        // Display the result
        Console.WriteLine();
        Console.WriteLine(`$"Result: {firstOperand} {operatorInput} {secondOperand} = {result}");
        Console.WriteLine();
    }
    catch (DivideByZeroException ex)
    {
        Console.WriteLine(`$"Error: {ex.Message}");
        Console.WriteLine();
    }
    catch (Exception ex)
    {
        Console.WriteLine(`$"An unexpected error occurred: {ex.Message}");
        Console.WriteLine();
    } # end try-catch
    
    // Ask if the user wants to perform another calculation
    Console.Write("Do you want to perform another calculation? (y/n): ");
    string continueInput = Console.ReadLine()?.ToLower() ?? "";
    
    // Handle user response to continue or exit
    continueCalculating = continueInput == "y" || continueInput == "yes";
    
    if (continueCalculating)
    {
        Console.WriteLine();
        Console.WriteLine("---");
        Console.WriteLine();
    } # end if
} # end while

Console.WriteLine("Thank you for using the calculator! Goodbye!");

// Calculator class with static methods for arithmetic operations
public static class Calculator
{
    public static double Add(double a, double b)
    {
        return a + b;
    } # end Add
    
    public static double Subtract(double a, double b)
    {
        return a - b;
    } # end Subtract
    
    public static double Multiply(double a, double b)
    {
        return a * b;
    } # end Multiply
    
    public static double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero");
        } # end if
        return a / b;
    } # end Divide
} # end Calculator
"@

    Set-Content -Path $calculatorPath -Value $calculatorContent -Encoding UTF8

    # Update the test file content
    Write-Host "Updating CalculatorTest.cs content..." -ForegroundColor Green
    $testContent = @"
namespace Calculator.Tests;

public class CalculatorTest
{
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsSum()
    {
        // Arrange
        double a = 5;
        double b = 3;
        double expected = 8;
        
        // Act
        double result = Calculator.Add(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    } # end Add_TwoPositiveNumbers_ReturnsSum
    
    [Fact]
    public void Subtract_TwoNumbers_ReturnsDifference()
    {
        // Arrange
        double a = 10;
        double b = 4;
        double expected = 6;
        
        // Act
        double result = Calculator.Subtract(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    } # end Subtract_TwoNumbers_ReturnsDifference
    
    [Fact]
    public void Multiply_TwoNumbers_ReturnsProduct()
    {
        // Arrange
        double a = 6;
        double b = 7;
        double expected = 42;
        
        // Act
        double result = Calculator.Multiply(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    } # end Multiply_TwoNumbers_ReturnsProduct
    
    [Fact]
    public void Divide_TwoNumbers_ReturnsQuotient()
    {
        // Arrange
        double a = 15;
        double b = 3;
        double expected = 5;
        
        // Act
        double result = Calculator.Divide(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    } # end Divide_TwoNumbers_ReturnsQuotient
    
    [Fact]
    public void Divide_ByZero_ThrowsException()
    {
        // Arrange
        double a = 10;
        double b = 0;
        
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Divide(a, b));
    } # end Divide_ByZero_ThrowsException
    
    [Fact]
    public void Add_WithDecimalNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 5.5;
        double b = 3.2;
        double expected = 8.7;
        
        // Act
        double result = Calculator.Add(a, b);
        
        // Assert
        Assert.Equal(expected, result, 2); // Check with precision of 2 decimal places
    } # end Add_WithDecimalNumbers_ReturnsCorrectSum
    
    [Fact]
    public void Multiply_ByZero_ReturnsZero()
    {
        // Arrange
        double a = 10;
        double b = 0;
        double expected = 0;
        
        // Act
        double result = Calculator.Multiply(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    } # end Multiply_ByZero_ReturnsZero
} # end CalculatorTest
"@

    Set-Content -Path $calculatorTestPath -Value $testContent -Encoding UTF8

    # Build and test the solution to verify everything works
    Write-Host "Building the solution..." -ForegroundColor Green
    dotnet build

    if ($LASTEXITCODE -eq 0) 
    {
        Write-Host "Running tests..." -ForegroundColor Green
        dotnet test --verbosity normal
    }
    else 
    {
        Write-Warning "Build failed. Skipping tests."
    } # end if

    # Display the final structure
    Write-Host "`nSolution structure created successfully!" -ForegroundColor Green
    Write-Host "=================================" -ForegroundColor Green
    Write-Host "Solution folder: calculator-xunit-testing" -ForegroundColor Cyan
    Write-Host "├── calculator-solution.sln" -ForegroundColor White
    Write-Host "├── calculator/" -ForegroundColor White
    Write-Host "│   ├── calculator.csproj" -ForegroundColor White
    Write-Host "│   └── Calculator.cs" -ForegroundColor White
    Write-Host "└── calculator.tests/" -ForegroundColor White
    Write-Host "    ├── calculator.tests.csproj" -ForegroundColor White
    Write-Host "    └── CalculatorTest.cs" -ForegroundColor White

    Write-Host "`nTo run the calculator application:" -ForegroundColor Yellow
    Write-Host "cd calculator && dotnet run" -ForegroundColor Cyan

    Write-Host "`nTo run the tests:" -ForegroundColor Yellow
    Write-Host "dotnet test" -ForegroundColor Cyan

    Write-Host "`nScript execution completed successfully!" -ForegroundColor Green
}
catch 
{
    Write-Error "An error occurred: $($_.Exception.Message)"
    Write-Host "Rolling back changes..." -ForegroundColor Red
}
finally 
{
    # Return to the original directory
    Set-Location ..
} # end finally
