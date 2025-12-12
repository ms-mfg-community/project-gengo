namespace CalculatorApp;

/// <summary>
/// Calculator class that provides arithmetic operations and user interaction
/// </summary>
public class Calculator
{
    /// <summary>
    /// Main entry point for the calculator application
    /// </summary>
    public static void Main()
    {
        bool continueCalculating = true;

        while (continueCalculating)
        {
            Console.Clear();
            Console.WriteLine("=== Simple Calculator ===");
            
            // Get first operand
            double firstOperand = GetNumericInput("Enter first operand: ");
            
            // Get second operand
            double secondOperand = GetNumericInput("Enter second operand: ");
            
            // Get operator
            string? op = GetOperator("Enter operator (+, -, *, /, %, ^): ");
            
            // Perform calculation
            double result = PerformCalculation(firstOperand, op, secondOperand);
            
            if (double.IsNaN(result))
            {
                Console.WriteLine("Error: Invalid operation");
            }
            else
            {
                Console.WriteLine($"\nResult: {firstOperand} {op} {secondOperand} = {result}");
            }
            
            // Ask if user wants to continue
            Console.Write("\nDo you want to perform another calculation? (yes/no): ");
            string? response = Console.ReadLine()?.ToLower();
            continueCalculating = response == "yes" || response == "y";
        }

        Console.WriteLine("\nThank you for using the calculator. Goodbye!");
    }

    /// <summary>
    /// Gets numeric input from the user with validation
    /// </summary>
    private static double GetNumericInput(string prompt)
    {
        while (true)
        {
            Console.Write(prompt);
            if (double.TryParse(Console.ReadLine(), out double result))
            {
                return result;
            }
            Console.WriteLine("Invalid input. Please enter a valid number.");
        }
    }

    /// <summary>
    /// Gets and validates operator input from the user
    /// </summary>
    private static string? GetOperator(string prompt)
    {
        while (true)
        {
            Console.Write(prompt);
            string? input = Console.ReadLine()?.Trim();
            
            if (string.IsNullOrEmpty(input))
            {
                Console.WriteLine("Invalid operator. Please enter +, -, *, /, %, or ^");
                continue;
            }
            
            if (input == "+" || input == "-" || input == "*" || input == "/" || input == "%" || input == "^")
            {
                return input;
            }
            Console.WriteLine("Invalid operator. Please enter +, -, *, /, %, or ^");
        }
    }

    /// <summary>
    /// Performs the calculation based on the operation
    /// </summary>
    private static double PerformCalculation(double first, string? op, double second)
    {
        if (string.IsNullOrEmpty(op))
        {
            return double.NaN;
        }
        
        return op switch
        {
            "+" => Add(first, second),
            "-" => Subtract(first, second),
            "*" => Multiply(first, second),
            "/" => second == 0 ? HandleDivisionByZero() : Divide(first, second),
            "%" => Modulo(first, second),
            "^" => Exponent(first, second),
            _ => double.NaN
        };
    }

    /// <summary>
    /// Adds two numbers
    /// </summary>
    public static double Add(double first, double second)
    {
        return first + second;
    }

    /// <summary>
    /// Subtracts two numbers
    /// </summary>
    public static double Subtract(double first, double second)
    {
        return first - second;
    }

    /// <summary>
    /// Multiplies two numbers
    /// </summary>
    public static double Multiply(double first, double second)
    {
        return first * second;
    }

    /// <summary>
    /// Divides two numbers
    /// </summary>
    public static double Divide(double first, double second)
    {
        if (second == 0)
        {
            return HandleDivisionByZero();
        }
        return first / second;
    }

    /// <summary>
    /// Performs modulo operation on two numbers
    /// </summary>
    public static double Modulo(double first, double second)
    {
        if (second == 0)
        {
            Console.WriteLine("Error: Cannot perform modulo by zero.");
            return double.NaN;
        }
        return first % second;
    }

    /// <summary>
    /// Raises the first number to the power of the second number
    /// </summary>
    public static double Exponent(double first, double second)
    {
        return Math.Pow(first, second);
    }

    /// <summary>
    /// Handles division by zero error
    /// </summary>
    private static double HandleDivisionByZero()
    {
        Console.WriteLine("Error: Cannot divide by zero.");
        return double.NaN;
    }
}
