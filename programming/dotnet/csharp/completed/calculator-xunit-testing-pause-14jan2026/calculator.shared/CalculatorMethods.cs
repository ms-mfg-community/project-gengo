namespace calculator.shared;

/// <summary>
/// Static class containing calculator operation methods.
/// All methods are public to allow testing and service usage.
/// </summary>
public static class CalculatorMethods
{
    /// <summary>
    /// Adds two numbers together.
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>Sum of a and b</returns>
    public static double Add(double a, double b)
    {
        return a + b;
    }

    /// <summary>
    /// Subtracts the second number from the first.
    /// </summary>
    /// <param name="a">First operand (minuend)</param>
    /// <param name="b">Second operand (subtrahend)</param>
    /// <returns>Difference of a and b</returns>
    public static double Subtract(double a, double b)
    {
        return a - b;
    }

    /// <summary>
    /// Multiplies two numbers together.
    /// </summary>
    /// <param name="a">First operand</param>
    /// <param name="b">Second operand</param>
    /// <returns>Product of a and b</returns>
    public static double Multiply(double a, double b)
    {
        return a * b;
    }

    /// <summary>
    /// Divides the first number by the second.
    /// </summary>
    /// <param name="a">First operand (dividend)</param>
    /// <param name="b">Second operand (divisor)</param>
    /// <returns>Quotient of a divided by b, or Infinity if b is 0</returns>
    public static double Divide(double a, double b)
    {
        if (b == 0)
        {
            return double.PositiveInfinity;
        }
        return a / b;
    }

    /// <summary>
    /// Calculates the modulo (remainder) of two numbers.
    /// </summary>
    /// <param name="a">First operand (dividend)</param>
    /// <param name="b">Second operand (divisor)</param>
    /// <returns>Remainder of a divided by b, or NaN if b is 0</returns>
    public static double Modulo(double a, double b)
    {
        if (b == 0)
        {
            return double.NaN;
        }
        return a % b;
    }

    /// <summary>
    /// Raises the first number to the power of the second.
    /// </summary>
    /// <param name="a">Base (first operand)</param>
    /// <param name="b">Exponent (second operand)</param>
    /// <returns>a raised to the power of b</returns>
    public static double Exponent(double a, double b)
    {
        return Math.Pow(a, b);
    }
}
