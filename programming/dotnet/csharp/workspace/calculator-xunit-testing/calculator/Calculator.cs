// Simple Calculator Program
// This program performs basic arithmetic operations: addition, subtraction, multiplication, and division.

using System;

// Create instance of CalculatorOperations for performing calculations
var calculator = new CalculatorOperations();

// Clear the screen at program start
Console.Clear();

// Main calculator loop
bool continueCalculating = true;

while (continueCalculating)
{
    Console.WriteLine("Simple Calculator");
    Console.WriteLine("----------------");
      // Get first operand
    Console.Write("Enter first number: ");
    string? firstInput = Console.ReadLine();
    
    // Try to parse the first input
    if (!double.TryParse(firstInput, out double firstNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }
      // Get second operand
    Console.Write("Enter second number: ");
    string? secondInput = Console.ReadLine();
    
    // Try to parse the second input
    if (!double.TryParse(secondInput, out double secondNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }      // Get operator
    Console.Write("Enter operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();
      // Calculate and display result
    double result = 0;
    bool validOperation = true;
      // Check if operator input is valid
    if (string.IsNullOrWhiteSpace(operatorInput))
    {
        Console.WriteLine("Invalid operator. Please use +, -, *, /, %, or ^.");
        validOperation = false;
    }
    else
    {
        try
        {
            switch (operatorInput)
            {
                case "+":
                    result = calculator.Add(firstNumber, secondNumber);
                    break;
                case "-":
                    result = calculator.Subtract(firstNumber, secondNumber);
                    break;
                case "*":
                    result = calculator.Multiply(firstNumber, secondNumber);
                    break;                case "/":
                    result = calculator.Divide(firstNumber, secondNumber);
                    break;
                case "%":
                    result = calculator.Modulo(firstNumber, secondNumber);
                    break;
                case "^":
                    result = calculator.Power(firstNumber, secondNumber);
                    break;
                default:
                    Console.WriteLine("Invalid operator. Please use +, -, *, /, %, or ^.");
                    validOperation = false;
                    break;
            }        }
        catch (DivideByZeroException)
        {
            Console.WriteLine("Error: Division by zero is not allowed.");
            validOperation = false;
        }
        catch (ArgumentOutOfRangeException ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            validOperation = false;
        }
    }
      // Display the result if operation was valid
    if (validOperation)
    {
        Console.WriteLine($"Result: {result}");
    }
    
    // Ask if the user wants to perform another calculation
    Console.Write("Do you want to perform another calculation? (yes/no): ");
    string? userResponse = Console.ReadLine()?.ToLower();
    
    // Determine if the calculator should continue running
    continueCalculating = userResponse == "yes" || userResponse == "y";
    
    // Clear screen after each calculation or before exit
    if (continueCalculating)
    {
        Console.Clear();
    }
    else
    {
        Console.Clear();
    }
}

// Display exit message
Console.WriteLine("Thank you for using the Simple Calculator. Goodbye!");

/// <summary>
/// Provides basic arithmetic operations for the calculator
/// </summary>
public class CalculatorOperations
{
    /// <summary>
    /// Adds two numbers
    /// </summary>
    /// <param name="a">First number</param>
    /// <param name="b">Second number</param>
    /// <returns>Sum of the two numbers</returns>
    public double Add(double a, double b)
    {
        return a + b;
    }
    
    /// <summary>
    /// Subtracts the second number from the first number
    /// </summary>
    /// <param name="a">First number (minuend)</param>
    /// <param name="b">Second number (subtrahend)</param>
    /// <returns>Difference of the two numbers</returns>
    public double Subtract(double a, double b)
    {
        return a - b;
    }
    
    /// <summary>
    /// Multiplies two numbers
    /// </summary>
    /// <param name="a">First number</param>
    /// <param name="b">Second number</param>
    /// <returns>Product of the two numbers</returns>
    public double Multiply(double a, double b)
    {
        return a * b;
    }
      /// <summary>
    /// Divides the first number by the second number
    /// </summary>
    /// <param name="a">Dividend</param>
    /// <param name="b">Divisor</param>
    /// <returns>Quotient of the division</returns>
    /// <exception cref="DivideByZeroException">Thrown when divisor is zero</exception>
    public double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero");
        }
        return a / b;
    }
    
    /// <summary>
    /// Calculates the modulo (remainder) of the first number divided by the second number
    /// </summary>
    /// <param name="a">Dividend</param>
    /// <param name="b">Divisor</param>
    /// <returns>Remainder of the division</returns>
    /// <exception cref="DivideByZeroException">Thrown when divisor is zero</exception>
    public double Modulo(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot perform modulo with zero divisor");
        }
        return a % b;
    }
    
    /// <summary>
    /// Raises the first number to the power of the second number
    /// </summary>
    /// <param name="baseNumber">Base number</param>
    /// <param name="exponent">Exponent</param>
    /// <returns>Result of base raised to the power of exponent</returns>
    /// <exception cref="ArgumentOutOfRangeException">Thrown when result would be infinite or invalid</exception>
    public double Power(double baseNumber, double exponent)
    {
        double result = Math.Pow(baseNumber, exponent);
        if (double.IsInfinity(result) || double.IsNaN(result))
        {
            throw new ArgumentOutOfRangeException(nameof(exponent), "Result is infinite or not a valid number");
        }
        return result;
    }
}