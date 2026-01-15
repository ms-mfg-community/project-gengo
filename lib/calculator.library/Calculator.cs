namespace CalculatorApp;

/// <summary>
/// Calculator class providing basic arithmetic operations.
/// Pure math logic with no console dependencies.
/// </summary>
public class Calculator
{
    /// <summary>Adds two numbers and returns the sum.</summary>
    public double Add(double firstOperand, double secondOperand) => firstOperand + secondOperand;

    /// <summary>Subtracts the second number from the first.</summary>
    public double Subtract(double firstOperand, double secondOperand) => firstOperand - secondOperand;

    /// <summary>Multiplies two numbers and returns the product.</summary>
    public double Multiply(double firstOperand, double secondOperand) => firstOperand * secondOperand;

    /// <summary>Divides the first number by the second.</summary>
    /// <exception cref="ArgumentException">Thrown when attempting to divide by zero</exception>
    public double Divide(double firstOperand, double secondOperand)
    {
        if (secondOperand == 0)
            throw new ArgumentException("Cannot divide by zero.");
        return firstOperand / secondOperand;
    }

    /// <summary>Calculates the remainder of division (modulo operation).</summary>
    /// <exception cref="ArgumentException">Thrown when attempting modulo by zero</exception>
    public double Modulo(double firstOperand, double secondOperand)
    {
        if (secondOperand == 0)
            throw new ArgumentException("Cannot perform modulo by zero.");
        return firstOperand % secondOperand;
    }

    /// <summary>Raises the first operand to the power of the second operand.</summary>
    public double Power(double firstOperand, double secondOperand) => Math.Pow(firstOperand, secondOperand);

    /// <summary>Performs a universal arithmetic operation based on the operator symbol.</summary>
    /// <exception cref="ArgumentException">Thrown when operator is null, empty, or unknown</exception>
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
