// Simple calculator program using top-level statements

// Clear screen at start
Console.Clear();

// Main program logic
bool continueCalculating = true;

Console.WriteLine("Simple Calculator");
Console.WriteLine("----------------");

while (continueCalculating)
{
    // Get first operand
    Console.Write("Enter first number: ");
    string? firstInput = Console.ReadLine();
    
    if (!double.TryParse(firstInput, out double firstNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }
    
    // Get second operand
    Console.Write("Enter second number: ");
    string? secondInput = Console.ReadLine();
    
    if (!double.TryParse(secondInput, out double secondNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }
    
    // Get operator
    Console.Write("Enter operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();
    
    // Calculate result based on operator
    double result = 0;
    bool validOperation = true;
    
    try
    {
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
                result = CalculatorOperations.Divide(firstNumber, secondNumber);
                break;
            case "%":
                result = CalculatorOperations.Modulo(firstNumber, secondNumber);
                break;
            case "^":
                result = CalculatorOperations.Power(firstNumber, secondNumber);
                break;
            default:
                Console.WriteLine("Invalid operator. Please use +, -, *, /, %, or ^.");
                validOperation = false;
                break;
        }
        
        // Display result if operation was valid
        if (validOperation)
        {
            Console.WriteLine($"Result: {result}");
        }
    }
    catch (DivideByZeroException)
    {
        Console.WriteLine("Error: Cannot divide by zero.");
    }
    catch (ArgumentException ex)
    {
        Console.WriteLine($"Error: {ex.Message}");
    }
    
    // Ask if user wants to perform another calculation
    Console.Write("Do you want to perform another calculation? (yes/no): ");
    string? userResponse = Console.ReadLine()?.ToLower() ?? "";
    
    continueCalculating = (userResponse == "yes" || userResponse == "y");
    
    if (continueCalculating)
    {
        // Clear screen for next calculation
        Console.Clear();
        Console.WriteLine("Simple Calculator");
        Console.WriteLine("----------------");
    }
    else
    {
        // Clear screen before displaying goodbye message
        Console.Clear();
    }
}

Console.WriteLine("Thank you for using the calculator. Goodbye!");

// Define calculator operations class for testing
public class CalculatorOperations
{
    public static double Add(double a, double b) => a + b;

    public static double Subtract(double a, double b) => a - b;

    public static double Multiply(double a, double b) => a * b;

    public static double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero.");
        }
        return a / b;
    }
    
    public static double Modulo(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot find modulo with zero divisor.");
        }
        return a % b;
    }
    
    public static double Power(double a, double b)
    {
        return Math.Pow(a, b);
    }
}