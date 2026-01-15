namespace calculator.library;

/// <summary>
/// Calculator class providing basic arithmetic operations.
/// Pure math logic with no console dependencies.
/// </summary>
public class Calculator
{
    /// <summary>Adds two numbers and returns the sum.</summary>
    public decimal Add(decimal firstOperand, decimal secondOperand) => firstOperand + secondOperand;

    /// <summary>Subtracts the second number from the first.</summary>
    public decimal Subtract(decimal firstOperand, decimal secondOperand) => firstOperand - secondOperand;

    /// <summary>Multiplies two numbers and returns the product.</summary>
    public decimal Multiply(decimal firstOperand, decimal secondOperand) => firstOperand * secondOperand;

    /// <summary>Divides the first number by the second.</summary>
    /// <exception cref="ArgumentException">Thrown when attempting to divide by zero</exception>
    public decimal Divide(decimal firstOperand, decimal secondOperand)
    {
        if (secondOperand == 0)
            throw new ArgumentException("Cannot divide by zero.");
        return firstOperand / secondOperand;
    }

    /// <summary>Calculates the remainder of division (modulo operation).</summary>
    /// <exception cref="ArgumentException">Thrown when attempting modulo by zero</exception>
    public decimal Modulo(decimal firstOperand, decimal secondOperand)
    {
        if (secondOperand == 0)
            throw new ArgumentException("Cannot perform modulo by zero.");
        return firstOperand % secondOperand;
    }

    /// <summary>Raises the first operand to the power of the second operand.</summary>
    public decimal Power(decimal firstOperand, decimal secondOperand) => (decimal)Math.Pow((double)firstOperand, (double)secondOperand);

    /// <summary>Performs a universal arithmetic operation based on the operator symbol.</summary>
    /// <exception cref="ArgumentException">Thrown when operator is null, empty, or unknown</exception>
    public decimal Operate(decimal firstOperand, decimal secondOperand, char operatorSymbol)
    {
        return operatorSymbol switch
        {
            '+' => Add(firstOperand, secondOperand),
            '-' => Subtract(firstOperand, secondOperand),
            '*' => Multiply(firstOperand, secondOperand),
            '/' => Divide(firstOperand, secondOperand),
            '%' => Modulo(firstOperand, secondOperand),
            '^' => Power(firstOperand, secondOperand),
            _ => throw new ArgumentException($"Unknown operator: {operatorSymbol}")
        };
    }
}
