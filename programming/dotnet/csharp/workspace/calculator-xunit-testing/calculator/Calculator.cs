namespace calculator;

/// <summary>
/// Provides basic arithmetic operations for calculator functionality.
/// </summary>
/// <remarks>
/// This class implements core arithmetic operations as public static methods
/// to enable testability from the xUnit test project.
/// All methods follow a consistent pattern: operands are validated,
/// the operation is performed, and the result is returned.
/// </remarks>
public class Calculator
{
    /// <summary>
    /// Adds two numbers together.
    /// </summary>
    /// <param name="firstNumber">The first operand</param>
    /// <param name="secondNumber">The second operand</param>
    /// <returns>The sum of firstNumber and secondNumber</returns>
    /// <example>
    /// <code>
    /// int result = Calculator.Add(5, 3);
    /// // result is 8
    /// </code>
    /// </example>
    public static int Add(int firstNumber, int secondNumber)
    {
        return firstNumber + secondNumber;
    }

    /// <summary>
    /// Subtracts the second number from the first number.
    /// </summary>
    /// <param name="firstNumber">The minuend (number being subtracted from)</param>
    /// <param name="secondNumber">The subtrahend (number being subtracted)</param>
    /// <returns>The difference between firstNumber and secondNumber</returns>
    /// <example>
    /// <code>
    /// int result = Calculator.Subtract(10, 4);
    /// // result is 6
    /// </code>
    /// </example>
    public static int Subtract(int firstNumber, int secondNumber)
    {
        return firstNumber - secondNumber;
    }

    /// <summary>
    /// Multiplies two numbers together.
    /// </summary>
    /// <param name="firstNumber">The first operand (multiplicand)</param>
    /// <param name="secondNumber">The second operand (multiplier)</param>
    /// <returns>The product of firstNumber and secondNumber</returns>
    /// <example>
    /// <code>
    /// int result = Calculator.Multiply(5, 3);
    /// // result is 15
    /// </code>
    /// </example>
    public static int Multiply(int firstNumber, int secondNumber)
    {
        return firstNumber * secondNumber;
    }

    /// <summary>
    /// Divides the first number by the second number.
    /// </summary>
    /// <param name="firstNumber">The dividend (number being divided)</param>
    /// <param name="secondNumber">The divisor (number dividing the first)</param>
    /// <returns>The quotient of firstNumber divided by secondNumber</returns>
    /// <exception cref="DivideByZeroException">
    /// Thrown when secondNumber is zero
    /// </exception>
    /// <example>
    /// <code>
    /// int result = Calculator.Divide(20, 4);
    /// // result is 5
    /// </code>
    /// </example>
    public static int Divide(int firstNumber, int secondNumber)
    {
        if (secondNumber == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero. Please enter a non-zero divisor.");
        }
        return firstNumber / secondNumber;
    }

    /// <summary>
    /// Calculates the remainder of dividing the first number by the second number.
    /// </summary>
    /// <param name="firstNumber">The dividend (number being divided)</param>
    /// <param name="secondNumber">The divisor (number dividing the first)</param>
    /// <returns>The remainder (modulo) of firstNumber divided by secondNumber</returns>
    /// <exception cref="DivideByZeroException">
    /// Thrown when secondNumber is zero
    /// </exception>
    /// <example>
    /// <code>
    /// int result = Calculator.Modulo(17, 5);
    /// // result is 2
    /// </code>
    /// </example>
    public static int Modulo(int firstNumber, int secondNumber)
    {
        if (secondNumber == 0)
        {
            throw new DivideByZeroException("Cannot calculate modulo with zero divisor. Please enter a non-zero divisor.");
        }
        return firstNumber % secondNumber;
    }

    /// <summary>
    /// Raises the first number to the power of the second number.
    /// </summary>
    /// <param name="firstNumber">The base</param>
    /// <param name="secondNumber">The exponent</param>
    /// <returns>The result of firstNumber raised to the power of secondNumber</returns>
    /// <remarks>
    /// Uses Math.Pow for calculation and converts result to int.
    /// Negative exponents will result in 0 due to integer truncation.
    /// </remarks>
    /// <example>
    /// <code>
    /// int result = Calculator.Power(2, 3);
    /// // result is 8
    /// </code>
    /// </example>
    public static int Power(int firstNumber, int secondNumber)
    {
        return (int)Math.Pow(firstNumber, secondNumber);
    }

    /// <summary>
    /// Performs a calculation based on the provided operator.
    /// </summary>
    /// <param name="firstNumber">The first operand</param>
    /// <param name="secondNumber">The second operand</param>
    /// <param name="operatorSymbol">The operator: '+', '-', '*', '/', '%', or '^'</param>
    /// <returns>The result of the calculation</returns>
    /// <exception cref="ArgumentException">
    /// Thrown when the operator is not recognized
    /// </exception>
    /// <exception cref="DivideByZeroException">
    /// Thrown when attempting division or modulo by zero
    /// </exception>
    /// <example>
    /// <code>
    /// int result = Calculator.Calculate(10, 3, "+");
    /// // result is 13
    /// </code>
    /// </example>
    public static int Calculate(int firstNumber, int secondNumber, string operatorSymbol)
    {
        // Input validation
        if (string.IsNullOrWhiteSpace(operatorSymbol))
        {
            throw new ArgumentException("Operator cannot be null or empty.", nameof(operatorSymbol));
        }

        // Perform operation based on operator
        return operatorSymbol switch
        {
            "+" => Add(firstNumber, secondNumber),
            "-" => Subtract(firstNumber, secondNumber),
            "*" => Multiply(firstNumber, secondNumber),
            "/" => Divide(firstNumber, secondNumber),
            "%" => Modulo(firstNumber, secondNumber),
            "^" => Power(firstNumber, secondNumber),
            _ => throw new ArgumentException($"Unknown operator '{operatorSymbol}'. Valid operators are: +, -, *, /, %, ^", nameof(operatorSymbol))
        };
    }
}
