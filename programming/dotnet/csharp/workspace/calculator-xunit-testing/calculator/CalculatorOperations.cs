/// <summary>
/// Calculator class containing public methods for arithmetic operations.
/// These methods are designed to be testable from the xUnit test project.
/// </summary>
public class CalculatorOperations
{
    /// <summary>
    /// Performs the specified arithmetic operation on two operands.
    /// </summary>
    public static double Perform(double operand1, double operand2, char op)
    {
        return op switch
        {
            '+' => Add(operand1, operand2),
            '-' => Subtract(operand1, operand2),
            '*' => Multiply(operand1, operand2),
            '/' => Divide(operand1, operand2),
            '%' => Modulo(operand1, operand2),
            '^' => Exponent(operand1, operand2),
            _ => double.NaN
        };
    }

    /// <summary>
    /// Adds two numbers and returns the result.
    /// </summary>
    public static double Add(double a, double b) => a + b;

    /// <summary>
    /// Subtracts the second number from the first and returns the result.
    /// </summary>
    public static double Subtract(double a, double b) => a - b;

    /// <summary>
    /// Multiplies two numbers and returns the result.
    /// </summary>
    public static double Multiply(double a, double b) => a * b;

    /// <summary>
    /// Divides the first number by the second. Returns NaN if divisor is zero.
    /// </summary>
    public static double Divide(double a, double b) => b != 0 ? a / b : double.NaN;

    /// <summary>
    /// Performs modulo operation on two numbers. Returns NaN if divisor is zero.
    /// </summary>
    public static double Modulo(double a, double b) => b != 0 ? a % b : double.NaN;

    /// <summary>
    /// Raises the first number to the power of the second and returns the result.
    /// </summary>
    public static double Exponent(double a, double b) => Math.Pow(a, b);

    /// <summary>
    /// Displays the calculation result or error message.
    /// </summary>
    public static void DisplayResult(double operand1, double operand2, char op, double result)
    {
        if (double.IsNaN(result))
        {
            if (op == '/' || op == '%')
            {
                Console.WriteLine("\nError: Cannot divide or modulo by zero.");
            }
            else
            {
                Console.WriteLine("\nError: Invalid operator.");
            }
        }
        else
        {
            Console.WriteLine($"\nResult: {operand1} {op} {operand2} = {result}");
        }
    }
}
