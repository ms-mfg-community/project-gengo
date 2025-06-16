// Simple calculator program using top-level statements
// This program implements a basic calculator with support for addition, subtraction,
// multiplication, division, modulo, and power operations using a console interface.
// It demonstrates error handling, user input validation, and clean UI design.

// Clear screen at start to provide a clean interface
Console.Clear();

// Main program logic - This flag controls the calculation loop
bool continueCalculating = true;

// Display welcome message and header
Console.WriteLine("Simple Calculator");
Console.WriteLine("----------------");

// Main calculator loop - continues until the user chooses to exit
while (continueCalculating)
{
    // Get first operand with error checking
    // We use nullable strings (string?) to handle potential null returns from Console.ReadLine()
    Console.Write("Enter first number: ");
    string? firstInput = Console.ReadLine();
    
    // TryParse is used instead of Parse to avoid exceptions for invalid input
    // If parsing fails, we show an error message and restart the loop
    if (!double.TryParse(firstInput, out double firstNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue; // Skip to next iteration, asking for input again
    }
    
    // Get second operand with the same error checking pattern
    Console.Write("Enter second number: ");
    string? secondInput = Console.ReadLine();
    
    if (!double.TryParse(secondInput, out double secondNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }
    
    // Get the operation to perform
    // Supported operators: +, -, *, /, %, ^
    Console.Write("Enter operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();
    
    // Initialize result and valid operation flag
    double result = 0;
    bool validOperation = true;
    
    // Use a try-catch block to handle potential exceptions from operations
    try
    {
        // Process the operation based on the provided operator
        switch (operatorInput)
        {
            case "+":
                result = CalculatorOperations.Add(firstNumber, secondNumber);
                break;
            case "-":
                result = CalculatorOperations.Subtract(firstNumber, secondNumber);
                break;
            case "*":
                result = CalculatorOperations.Multiply(firstNumber, secondNumber);
                break;
            case "/":
                // Division may throw DivideByZeroException if secondNumber is zero
                result = CalculatorOperations.Divide(firstNumber, secondNumber);
                break;
            case "%":
                // Modulo also throws DivideByZeroException if secondNumber is zero
                result = CalculatorOperations.Modulo(firstNumber, secondNumber);
                break;
            case "^":
                // Power uses Math.Pow which has specific edge cases:
                // - 0^0 returns 1, following mathematical convention
                // - negative base with fractional exponent can return NaN
                result = CalculatorOperations.Power(firstNumber, secondNumber);
                break;
            default:
                // Handle invalid operator input
                Console.WriteLine("Invalid operator. Please use +, -, *, /, %, or ^.");
                validOperation = false;
                break;
        }
        
        // Display the result only if the operation was valid
        if (validOperation)
        {
            Console.WriteLine($"Result: {result}");
        }
    }
    catch (DivideByZeroException)
    {
        // Special handling for division by zero
        Console.WriteLine("Error: Cannot divide by zero.");
    }
    catch (ArgumentException ex)
    {
        // Handle other argument exceptions that might occur in the operations
        Console.WriteLine($"Error: {ex.Message}");
    }
    
    // Ask if the user wants to perform another calculation
    Console.Write("Do you want to perform another calculation? (yes/no): ");
    
    // Use null-conditional (?.) and null-coalescing (??) operators to prevent NullReferenceException
    // If ReadLine() returns null or the user inputs nothing, default to empty string
    string? userResponse = Console.ReadLine()?.ToLower() ?? "";
    
    // Accept both "yes" and "y" as affirmative responses
    continueCalculating = (userResponse == "yes" || userResponse == "y");
    
    if (continueCalculating)
    {
        // Clear screen and redisplay header for the next calculation
        // This improves user experience by removing clutter
        Console.Clear();
        Console.WriteLine("Simple Calculator");
        Console.WriteLine("----------------");
    }
    else
    {
        // Clear screen before displaying goodbye message
        // This provides a clean exit experience
        Console.Clear();
    }
}

// Display farewell message
Console.WriteLine("Thank you for using the calculator. Goodbye!");

/// <summary>
/// Contains static methods for basic calculator operations.
/// All methods are designed to be testable independently.
/// </summary>
public class CalculatorOperations
{
    /// <summary>
    /// Adds two double values.
    /// </summary>
    /// <param name="a">First number</param>
    /// <param name="b">Second number</param>
    /// <returns>Sum of the two numbers</returns>
    /// <remarks>
    /// This method handles the full range of double values including negatives.
    /// Edge cases:
    /// - Adding very large numbers may result in double.PositiveInfinity
    /// - Adding very small negatives to very large positives may lose precision
    /// </remarks>
    public static double Add(double a, double b) => a + b;

    /// <summary>
    /// Subtracts the second double value from the first.
    /// </summary>
    /// <param name="a">Number to subtract from</param>
    /// <param name="b">Number to subtract</param>
    /// <returns>Difference between the two numbers</returns>
    /// <remarks>
    /// This method handles the full range of double values including negatives.
    /// Edge cases:
    /// - Subtracting a negative is the same as addition and may overflow
    /// - Subtracting very close numbers may result in precision issues
    /// </remarks>
    public static double Subtract(double a, double b) => a - b;

    /// <summary>
    /// Multiplies two double values.
    /// </summary>
    /// <param name="a">First number</param>
    /// <param name="b">Second number</param>
    /// <returns>Product of the two numbers</returns>
    /// <remarks>
    /// This method handles the full range of double values including negatives.
    /// Edge cases:
    /// - Multiplying by zero always returns zero
    /// - Multiplying large numbers may result in double.PositiveInfinity
    /// - Sign rules apply (negative * negative = positive)
    /// </remarks>
    public static double Multiply(double a, double b) => a * b;

    /// <summary>
    /// Divides the first double value by the second.
    /// </summary>
    /// <param name="a">Numerator</param>
    /// <param name="b">Denominator</param>
    /// <returns>Quotient of the division</returns>
    /// <exception cref="DivideByZeroException">Thrown when divisor is zero</exception>
    /// <remarks>
    /// Edge cases:
    /// - Division by zero throws DivideByZeroException
    /// - Division of zero by any non-zero number returns zero
    /// - Sign rules apply (negative / negative = positive)
    /// - Division by very small numbers can result in very large results
    /// </remarks>
    public static double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero.");
        }
        return a / b;
    }
    
    /// <summary>
    /// Calculates the remainder of dividing the first value by the second.
    /// </summary>
    /// <param name="a">Numerator</param>
    /// <param name="b">Denominator</param>
    /// <returns>Remainder of the division</returns>
    /// <exception cref="DivideByZeroException">Thrown when divisor is zero</exception>
    /// <remarks>
    /// Edge cases:
    /// - Modulo by zero throws DivideByZeroException
    /// - In C#, the modulo of negative numbers follows the sign of the dividend (a)
    ///   (e.g., -7 % 3 = -1, which differs from some other languages)
    /// - Modulo with floating point numbers returns the floating-point remainder
    /// </remarks>
    public static double Modulo(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot find modulo with zero divisor.");
        }
        return a % b;
    }
    
    /// <summary>
    /// Raises the first value to the power of the second value.
    /// </summary>
    /// <param name="a">Base number</param>
    /// <param name="b">Exponent</param>
    /// <returns>The result of raising a to the power of b</returns>
    /// <remarks>
    /// This method uses Math.Pow internally, which has several edge cases:
    /// - 0^0 returns 1 (mathematical convention)
    /// - Any number raised to 0 returns 1
    /// - 0 raised to any positive power returns 0
    /// - Negative numbers raised to fractional powers return NaN
    /// - Very large results might return double.PositiveInfinity
    /// - NaN inputs result in NaN output
    /// </remarks>
    public static double Power(double a, double b)
    {
        return Math.Pow(a, b);
    }
}