/// <summary>
/// Calculator class providing arithmetic operations with comprehensive error handling.
/// Supports addition, subtraction, multiplication, division, modulo, and exponentiation.
/// </summary>
public class Calculator
{
    /// <summary>
    /// Adds two numbers together.
    /// </summary>
    /// <param name="firstOperand">The first number to add.</param>
    /// <param name="secondOperand">The second number to add.</param>
    /// <returns>The sum of the two operands.</returns>
    public double Add(double firstOperand, double secondOperand)
    {
        return firstOperand + secondOperand;
    }

    /// <summary>
    /// Subtracts the second operand from the first operand.
    /// </summary>
    /// <param name="firstOperand">The number to subtract from.</param>
    /// <param name="secondOperand">The number to subtract.</param>
    /// <returns>The difference between the operands.</returns>
    public double Subtract(double firstOperand, double secondOperand)
    {
        return firstOperand - secondOperand;
    }

    /// <summary>
    /// Multiplies two numbers together.
    /// </summary>
    /// <param name="firstOperand">The first number to multiply.</param>
    /// <param name="secondOperand">The second number to multiply.</param>
    /// <returns>The product of the two operands.</returns>
    public double Multiply(double firstOperand, double secondOperand)
    {
        return firstOperand * secondOperand;
    }

    /// <summary>
    /// Divides the first operand by the second operand.
    /// </summary>
    /// <param name="firstOperand">The dividend (number to be divided).</param>
    /// <param name="secondOperand">The divisor (number to divide by).</param>
    /// <returns>The quotient of the division.</returns>
    /// <exception cref="ArgumentException">Thrown when attempting to divide by zero.</exception>
    public double Divide(double firstOperand, double secondOperand)
    {
        if (secondOperand == 0)
            throw new ArgumentException("Cannot divide by zero.");
        return firstOperand / secondOperand;
    }

    /// <summary>
    /// Calculates the remainder of dividing the first operand by the second operand.
    /// </summary>
    /// <param name="firstOperand">The dividend (number to be divided).</param>
    /// <param name="secondOperand">The divisor (number to divide by).</param>
    /// <returns>The remainder of the division.</returns>
    /// <exception cref="ArgumentException">Thrown when attempting to use modulo with zero.</exception>
    public double Modulo(double firstOperand, double secondOperand)
    {
        if (secondOperand == 0)
            throw new ArgumentException("Cannot perform modulo with zero.");
        return firstOperand % secondOperand;
    }

    /// <summary>
    /// Raises the first operand to the power of the second operand.
    /// </summary>
    /// <param name="firstOperand">The base number.</param>
    /// <param name="secondOperand">The exponent (power).</param>
    /// <returns>The result of raising the base to the exponent.</returns>
    public double Power(double firstOperand, double secondOperand)
    {
        return Math.Pow(firstOperand, secondOperand);
    }

    /// <summary>
    /// Performs the specified arithmetic operation on two operands.
    /// </summary>
    /// <param name="firstOperand">The first operand.</param>
    /// <param name="secondOperand">The second operand.</param>
    /// <param name="operatorSymbol">The operator symbol (+, -, *, /, %, ^).</param>
    /// <returns>The result of the operation.</returns>
    /// <exception cref="ArgumentException">Thrown when the operator is not recognized or operation is invalid.</exception>
    public double Operate(double firstOperand, double secondOperand, string operatorSymbol)
    {
        if (string.IsNullOrWhiteSpace(operatorSymbol))
            throw new ArgumentException("Operator cannot be null or empty.");

        return operatorSymbol switch
        {
            "+" => Add(firstOperand, secondOperand),
            "-" => Subtract(firstOperand, secondOperand),
            "*" => Multiply(firstOperand, secondOperand),
            "/" => Divide(firstOperand, secondOperand),
            "%" => Modulo(firstOperand, secondOperand),
            "^" => Power(firstOperand, secondOperand),
            _ => throw new ArgumentException($"Unknown operator: {operatorSymbol}")
        };
    }
}
