namespace CalculatorApp;

/// <summary>
/// Calculator class that provides arithmetic operations
/// </summary>
public class Calculator
{
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
            return double.NaN;
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
    /// Performs the calculation based on the operation
    /// </summary>
    public static double PerformCalculation(double first, string? op, double second)
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
            "/" => Divide(first, second),
            "%" => Modulo(first, second),
            "^" => Exponent(first, second),
            _ => double.NaN
        };
    }
}
