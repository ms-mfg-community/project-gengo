// Basic Calculator Application with Top-Level Statements
// Demonstrates arithmetic operations and user interaction

string? continueCalculating = "y";

while (continueCalculating?.ToLower() == "y")
{
    // Clear screen for better user experience
    Console.Clear();
    
    // Prompt for first operand
    Console.Write("Enter the first operand: ");
    string? firstInput = Console.ReadLine();
    
    // Validate and parse first operand
    if (string.IsNullOrWhiteSpace(firstInput) || !double.TryParse(firstInput, out double firstOperand))
    {
        Console.WriteLine("Invalid input for first operand. Please enter a valid number.");
        continue;
    }
    
    // Prompt for second operand
    Console.Write("Enter the second operand: ");
    string? secondInput = Console.ReadLine();
    
    // Validate and parse second operand
    if (string.IsNullOrWhiteSpace(secondInput) || !double.TryParse(secondInput, out double secondOperand))
    {
        Console.WriteLine("Invalid input for second operand. Please enter a valid number.");
        continue;
    }
    
    // Prompt for operator
    Console.Write("Enter the operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();
    
    // Validate operator input
    if (string.IsNullOrWhiteSpace(operatorInput))
    {
        Console.WriteLine("Invalid operator. Please enter one of: +, -, *, /, %, ^");
        continue;
    }
    
    // Perform calculation based on operator using refactored methods
    double result;
    
    switch (operatorInput.Trim())
    {
        case "+":
            result = CalculatorOperations.Add(firstOperand, secondOperand);
            Console.WriteLine($"Result: {firstOperand} + {secondOperand} = {result}");
            break;
        case "-":
            result = CalculatorOperations.Subtract(firstOperand, secondOperand);
            Console.WriteLine($"Result: {firstOperand} - {secondOperand} = {result}");
            break;
        case "*":
            result = CalculatorOperations.Multiply(firstOperand, secondOperand);
            Console.WriteLine($"Result: {firstOperand} * {secondOperand} = {result}");
            break;
        case "/":
            if (secondOperand == 0)
            {
                Console.WriteLine("Error: Division by zero is not allowed.");
            }
            else
            {
                result = CalculatorOperations.Divide(firstOperand, secondOperand);
                Console.WriteLine($"Result: {firstOperand} / {secondOperand} = {result}");
            }
            break;
        case "%":
            if (secondOperand == 0)
            {
                Console.WriteLine("Error: Modulo by zero is not allowed.");
            }
            else
            {
                result = CalculatorOperations.Modulo(firstOperand, secondOperand);
                Console.WriteLine($"Result: {firstOperand} % {secondOperand} = {result}");
            }
            break;
        case "^":
            result = CalculatorOperations.Exponent(firstOperand, secondOperand);
            Console.WriteLine($"Result: {firstOperand} ^ {secondOperand} = {result}");
            break;
        default:
            Console.WriteLine($"Invalid operator: {operatorInput}. Please use +, -, *, /, %, or ^");
            break;
    }
    
    // Ask if user wants to perform another calculation
    Console.Write("\nDo you want to perform another calculation? (y/n): ");
    continueCalculating = Console.ReadLine();
}

Console.Clear();
Console.WriteLine("Thank you for using the calculator. Goodbye!");

/// <summary>
/// Public class containing all calculator operations as testable methods
/// </summary>
public static class CalculatorOperations
{
    /// <summary>
    /// Adds two numbers
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>Sum of a and b</returns>
    public static double Add(double a, double b)
    {
        return a + b;
    }
    
    /// <summary>
    /// Subtracts the second number from the first
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>Difference of a and b</returns>
    public static double Subtract(double a, double b)
    {
        return a - b;
    }
    
    /// <summary>
    /// Multiplies two numbers
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>Product of a and b</returns>
    public static double Multiply(double a, double b)
    {
        return a * b;
    }
    
    /// <summary>
    /// Divides the first number by the second
    /// </summary>
    /// <param name="a">First operand (dividend)</param>
    /// <param name="b">Second operand (divisor)</param>
    /// <returns>Quotient of a and b</returns>
    /// <exception cref="DivideByZeroException">Thrown when b is zero</exception>
    public static double Divide(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero.");
        }
        return a / b;
    }
    
    /// <summary>
    /// Calculates the modulo (remainder) of dividing the first number by the second
    /// </summary>
    /// <param name="a">First operand (dividend)</param>
    /// <param name="b">Second operand (divisor)</param>
    /// <returns>Remainder of a divided by b</returns>
    /// <exception cref="DivideByZeroException">Thrown when b is zero</exception>
    public static double Modulo(double a, double b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot perform modulo by zero.");
        }
        return a % b;
    }
    
    /// <summary>
    /// Raises the first number to the power of the second
    /// </summary>
    /// <param name="a">Base</param>
    /// <param name="b">Exponent</param>
    /// <returns>a raised to the power of b</returns>
    public static double Exponent(double a, double b)
    {
        return Math.Pow(a, b);
    }
}
