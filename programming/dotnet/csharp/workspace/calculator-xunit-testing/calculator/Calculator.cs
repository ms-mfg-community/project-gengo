// Simple Calculator using top-level statements
// This program provides a basic interactive calculator supporting +, -, *, /, %, ^ operations.
// It handles invalid input, division/modulo by zero, and allows repeated calculations.
while (true)
{
    // Clear the screen at the start of each calculation for a clean user experience
    Console.Clear();

    // Prompt for the first operand and validate input
    Console.Write("Enter the first number: ");
    if (!double.TryParse(Console.ReadLine(), out double num1))
    {
        // If input is not a valid number, inform the user and restart the loop
        Console.WriteLine("Invalid input. Please enter a valid number.");
        Console.WriteLine("Press Enter to continue...");
        Console.ReadLine();
        continue;
    }

    // Prompt for the second operand and validate input
    Console.Write("Enter the second number: ");
    if (!double.TryParse(Console.ReadLine(), out double num2))
    {
        // If input is not a valid number, inform the user and restart the loop
        Console.WriteLine("Invalid input. Please enter a valid number.");
        Console.WriteLine("Press Enter to continue...");
        Console.ReadLine();
        continue;
    }

    // Prompt for the operator, supporting +, -, *, /, %, ^
    Console.Write("Enter the operator (+, -, *, /, %, ^): ");
    string op = Console.ReadLine();
    double result = 0;
    bool valid = true;
    switch (op)
    {
        case "+":
            // Addition
            result = CalculatorOperations.Add(num1, num2);
            break;
        case "-":
            // Subtraction
            result = CalculatorOperations.Subtract(num1, num2);
            break;
        case "*":
            // Multiplication
            result = CalculatorOperations.Multiply(num1, num2);
            break;
        case "/":
            // Division, handle divide by zero exception
            try
            {
                result = CalculatorOperations.Divide(num1, num2);
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("Cannot divide by zero.");
                valid = false;
            }
            break;
        case "%":
            // Modulo, handle divide by zero exception
            try
            {
                result = CalculatorOperations.Modulo(num1, num2);
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("Cannot modulo by zero.");
                valid = false;
            }
            break;
        case "^":
            // Exponentiation (a^b)
            result = CalculatorOperations.Exponent(num1, num2);
            break;
        default:
            // Handle unsupported operator
            Console.WriteLine("Invalid operator. Please enter one of +, -, *, /, %, ^");
            valid = false;
            break;
    }
    if (valid)
        // Display the result if the operation was valid
        Console.WriteLine($"Result: {num1} {op} {num2} = {result}");

    // Ask the user if they want to perform another calculation
    Console.Write("Do you want to perform another calculation? (yes/no): ");
    string again = Console.ReadLine()?.Trim().ToLower();
    if (again != "yes" && again != "y")
    {
        // Clear the screen before displaying the exit message
        Console.Clear();
        Console.WriteLine("Thank you for using the calculator. Goodbye!");
        break;
    }
}

// CalculatorOperations class for unit testing
// Each method implements a basic arithmetic operation and is public for xUnit testability.
public static class CalculatorOperations
{
    /// <summary>
    /// Returns the sum of two numbers.
    /// </summary>
    public static double Add(double a, double b) => a + b;

    /// <summary>
    /// Returns the difference of two numbers (a - b).
    /// </summary>
    public static double Subtract(double a, double b) => a - b;

    /// <summary>
    /// Returns the product of two numbers.
    /// </summary>
    public static double Multiply(double a, double b) => a * b;

    /// <summary>
    /// Returns the quotient of two numbers (a / b).
    /// Throws DivideByZeroException if b is zero.
    /// </summary>
    public static double Divide(double a, double b)
    {
        if (b == 0) throw new DivideByZeroException(); // Prevent division by zero
        return a / b;
    }

    /// <summary>
    /// Returns the remainder of division (a % b).
    /// Throws DivideByZeroException if b is zero.
    /// </summary>
    public static double Modulo(double a, double b)
    {
        if (b == 0) throw new DivideByZeroException(); // Prevent modulo by zero
        return a % b;
    }

    /// <summary>
    /// Returns a raised to the power of b (a^b).
    /// Uses Math.Pow for exponentiation.
    /// </summary>
    public static double Exponent(double a, double b) => Math.Pow(a, b);
}
