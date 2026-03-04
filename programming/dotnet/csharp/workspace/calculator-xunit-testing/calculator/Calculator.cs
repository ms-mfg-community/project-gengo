#nullable enable

namespace calculator;

/// <summary>
/// A simple calculator class that performs basic arithmetic operations.
/// Supports addition, subtraction, multiplication, division, modulo, and power operations.
/// </summary>
public class Calculator
{
    /// <summary>
    /// Adds two numbers together.
    /// </summary>
    /// <param name="a">The first number</param>
    /// <param name="b">The second number</param>
    /// <returns>The sum of a and b</returns>
    /// <example>
    /// <code>
    /// double result = Calculator.Add(5.5, 3.2);
    /// // result = 8.7
    /// </code>
    /// </example>
    public static double Add(double a, double b)
    {
        return a + b;
    }

    /// <summary>
    /// Subtracts the second number from the first number.
    /// </summary>
    /// <param name="a">The first number (minuend)</param>
    /// <param name="b">The second number (subtrahend)</param>
    /// <returns>The difference of a minus b</returns>
    /// <example>
    /// <code>
    /// double result = Calculator.Subtract(10.5, 3.2);
    /// // result = 7.3
    /// </code>
    /// </example>
    public static double Subtract(double a, double b)
    {
        return a - b;
    }

    /// <summary>
    /// Multiplies two numbers together.
    /// </summary>
    /// <param name="a">The first number (multiplicand)</param>
    /// <param name="b">The second number (multiplier)</param>
    /// <returns>The product of a and b</returns>
    /// <example>
    /// <code>
    /// double result = Calculator.Multiply(5.5, 3.2);
    /// // result = 17.6
    /// </code>
    /// </example>
    public static double Multiply(double a, double b)
    {
        return a * b;
    }

    /// <summary>
    /// Divides the first number by the second number.
    /// </summary>
    /// <param name="a">The first number (dividend)</param>
    /// <param name="b">The second number (divisor); must not be zero</param>
    /// <returns>The quotient of a divided by b</returns>
    /// <exception cref="DivideByZeroException">Thrown when divisor (b) is zero</exception>
    /// <example>
    /// <code>
    /// double result = Calculator.Divide(10.5, 2.5);
    /// // result = 4.2
    /// </code>
    /// </example>
    public static double Divide(double a, double b)
    {
        if (b == 0)
            throw new DivideByZeroException("Cannot divide by zero.");
        return a / b;
    }

    /// <summary>
    /// Calculates the remainder (modulo) of division of the first number by the second number.
    /// </summary>
    /// <param name="a">The first number (dividend)</param>
    /// <param name="b">The second number (divisor); must not be zero</param>
    /// <returns>The remainder of a divided by b</returns>
    /// <exception cref="DivideByZeroException">Thrown when divisor (b) is zero</exception>
    /// <example>
    /// <code>
    /// double result = Calculator.Modulo(10.5, 3.2);
    /// // result = 1.1
    /// </code>
    /// </example>
    public static double Modulo(double a, double b)
    {
        if (b == 0)
            throw new DivideByZeroException("Cannot calculate modulo with zero.");
        return a % b;
    }

    /// <summary>
    /// Raises the first number to the power of the second number (exponentiation).
    /// </summary>
    /// <param name="a">The base number</param>
    /// <param name="b">The exponent; can be positive, negative, or zero</param>
    /// <returns>The result of a raised to the power of b</returns>
    /// <example>
    /// <code>
    /// double result = Calculator.Power(2.5, 3);
    /// // result = 15.625
    /// </code>
    /// </example>
    public static double Power(double a, double b)
    {
        return Math.Pow(a, b);
    }

    /// <summary>
    /// Performs a calculation based on the operator provided.
    /// Supports: + (addition), - (subtraction), * (multiplication), / (division), % (modulo), ^ (power).
    /// </summary>
    /// <param name="operand1">The first operand</param>
    /// <param name="operand2">The second operand</param>
    /// <param name="operator">The operator symbol as a string ("+", "-", "*", "/", "%", "^")</param>
    /// <returns>The result of the operation</returns>
    /// <exception cref="ArgumentException">Thrown when operator is not recognized</exception>
    /// <exception cref="DivideByZeroException">Thrown for division or modulo by zero</exception>
    /// <example>
    /// <code>
    /// double result = Calculator.Calculate(10.5, 5.2, "+");
    /// // result = 15.7
    /// </code>
    /// </example>
    public static double Calculate(double operand1, double operand2, string @operator)
    {
        if (string.IsNullOrWhiteSpace(@operator))
            throw new ArgumentException("Operator cannot be null or empty.", nameof(@operator));

        return @operator.Trim() switch
        {
            "+" => Add(operand1, operand2),
            "-" => Subtract(operand1, operand2),
            "*" => Multiply(operand1, operand2),
            "/" => Divide(operand1, operand2),
            "%" => Modulo(operand1, operand2),
            "^" => Power(operand1, operand2),
            _ => throw new ArgumentException($"Unknown operator: {@operator}", nameof(@operator))
        };
    }
}
