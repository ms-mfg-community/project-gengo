namespace calculator.shared;

/// <summary>
/// Interface for calculator service operations.
/// Provides abstraction for dependency injection and testing with Playwright.
/// </summary>
public interface ICalculatorService
{
    /// <summary>
    /// Performs an arithmetic operation on two operands.
    /// </summary>
    /// <param name="firstOperand">First number</param>
    /// <param name="secondOperand">Second number</param>
    /// <param name="operatorSymbol">Operator: +, -, *, /, %, ^</param>
    /// <returns>Result of the operation, or special values (Infinity, NaN) for errors</returns>
    double Calculate(double firstOperand, double secondOperand, string operatorSymbol);

    /// <summary>
    /// Validates if a string is a supported operator.
    /// </summary>
    /// <param name="operatorSymbol">Operator to validate</param>
    /// <returns>True if operator is supported</returns>
    bool IsValidOperator(string operatorSymbol);

    /// <summary>
    /// Gets all supported operators.
    /// </summary>
    /// <returns>Array of supported operator strings</returns>
    string[] GetSupportedOperators();
}

/// <summary>
/// Implementation of ICalculatorService.
/// Provides wrapper functionality around CalculatorMethods for dependency injection
/// and Playwright testing support.
/// </summary>
public class CalculatorService : ICalculatorService
{
    /// <summary>
    /// Array of supported operators.
    /// </summary>
    private static readonly string[] SupportedOperators = { "+", "-", "*", "/", "%", "^" };

    /// <summary>
    /// Performs an arithmetic operation on two operands.
    /// </summary>
    /// <param name="firstOperand">First number</param>
    /// <param name="secondOperand">Second number</param>
    /// <param name="operatorSymbol">Operator: +, -, *, /, %, ^</param>
    /// <returns>Result of the operation, or special values (Infinity, NaN) for errors</returns>
    public double Calculate(double firstOperand, double secondOperand, string operatorSymbol)
    {
        if (string.IsNullOrWhiteSpace(operatorSymbol))
        {
            return double.NaN;
        }

        return operatorSymbol.Trim() switch
        {
            "+" => CalculatorMethods.Add(firstOperand, secondOperand),
            "-" => CalculatorMethods.Subtract(firstOperand, secondOperand),
            "*" => CalculatorMethods.Multiply(firstOperand, secondOperand),
            "/" => CalculatorMethods.Divide(firstOperand, secondOperand),
            "%" => CalculatorMethods.Modulo(firstOperand, secondOperand),
            "^" => CalculatorMethods.Exponent(firstOperand, secondOperand),
            _ => double.NaN // Invalid operator
        };
    }

    /// <summary>
    /// Validates if a string is a supported operator.
    /// </summary>
    /// <param name="operatorSymbol">Operator to validate</param>
    /// <returns>True if operator is supported</returns>
    public bool IsValidOperator(string operatorSymbol)
    {
        if (string.IsNullOrWhiteSpace(operatorSymbol))
        {
            return false;
        }

        return SupportedOperators.Contains(operatorSymbol.Trim());
    }

    /// <summary>
    /// Gets all supported operators.
    /// </summary>
    /// <returns>Array of supported operator strings</returns>
    public string[] GetSupportedOperators()
    {
        return (string[])SupportedOperators.Clone();
    }
}
