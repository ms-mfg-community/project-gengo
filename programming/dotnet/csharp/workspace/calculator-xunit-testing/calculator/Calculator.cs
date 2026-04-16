#nullable enable

namespace calculator;

/// <summary>
/// Provides basic arithmetic operations for the calculator application.
/// </summary>
public static class Calculator
{
    /// <summary>
    /// Adds two numbers.
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>The sum of a and b</returns>
    public static double Add(double a, double b)
    {
        return a + b;
    }

    /// <summary>
    /// Subtracts the second number from the first.
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>The difference of a and b</returns>
    public static double Subtract(double a, double b)
    {
        return a - b;
    }

    /// <summary>
    /// Multiplies two numbers.
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>The product of a and b</returns>
    public static double Multiply(double a, double b)
    {
        return a * b;
    }

    /// <summary>
    /// Divides the first number by the second.
    /// </summary>
    /// <param name="a">Dividend</param>
    /// <param name="b">Divisor</param>
    /// <returns>The quotient of a divided by b</returns>
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
    /// Computes the remainder of dividing the first number by the second.
    /// </summary>
    /// <param name="a">Dividend</param>
    /// <param name="b">Divisor</param>
    /// <returns>The remainder of a divided by b</returns>
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
    /// Raises the first number to the power of the second.
    /// </summary>
    /// <param name="a">Base</param>
    /// <param name="b">Exponent</param>
    /// <returns>a raised to the power of b</returns>
    public static double Power(double a, double b)
    {
        return Math.Pow(a, b);
    }

    /// <summary>
    /// Performs a calculation based on the specified operator.
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <param name="op">Operator (+, -, *, /, %, ^)</param>
    /// <returns>The result of the calculation</returns>
    /// <exception cref="ArgumentException">Thrown when an invalid operator is provided</exception>
    /// <exception cref="DivideByZeroException">Thrown when dividing or modulo by zero</exception>
    public static double Calculate(double a, double b, string op)
    {
        if (string.IsNullOrWhiteSpace(op))
        {
            throw new ArgumentException("Operator cannot be null or empty.", nameof(op));
        }

        return op switch
        {
            "+" => Add(a, b),
            "-" => Subtract(a, b),
            "*" => Multiply(a, b),
            "/" => Divide(a, b),
            "%" => Modulo(a, b),
            "^" => Power(a, b),
            _ => throw new ArgumentException($"Invalid operator: '{op}'. Supported operators: +, -, *, /, %, ^", nameof(op))
        };
    }
}
