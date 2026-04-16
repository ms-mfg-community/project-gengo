#nullable enable

namespace calculator;

/// <summary>
/// Provides a console workflow for collecting calculator input.
/// </summary>
public static class CalculatorConsole
{
    /// <summary>
    /// Runs a single calculator interaction using first operand, second operand, then operator input order.
    /// </summary>
    /// <param name="input">The input source that supplies calculator values.</param>
    /// <param name="output">The output target used for prompts and results.</param>
    /// <exception cref="ArgumentNullException">Thrown when <paramref name="input"/> or <paramref name="output"/> is null.</exception>
    /// <exception cref="ArgumentException">Thrown when an operand or operator is invalid.</exception>
    /// <exception cref="DivideByZeroException">Thrown when the provided operation divides by zero.</exception>
    /// <example>
    /// <code>
    /// using var input = new StringReader("4\n5\n+\n");
    /// using var output = new StringWriter();
    /// CalculatorConsole.Run(input, output);
    /// </code>
    /// </example>
    public static void Run(TextReader input, TextWriter output)
    {
        ArgumentNullException.ThrowIfNull(input);
        ArgumentNullException.ThrowIfNull(output);

        double firstOperand = ReadOperand(input, output, "Enter the first operand: ");
        double secondOperand = ReadOperand(input, output, "Enter the second operand: ");
        string operation = ReadOperator(input, output);

        double result = Calculator.Calculate(firstOperand, secondOperand, operation);
        output.WriteLine($"Result: {firstOperand} {operation} {secondOperand} = {result}");
    }

    private static double ReadOperand(TextReader input, TextWriter output, string prompt)
    {
        output.Write(prompt);

        string? rawValue = input.ReadLine();
        if (string.IsNullOrWhiteSpace(rawValue) || !double.TryParse(rawValue, out double operand))
        {
            throw new ArgumentException("Invalid operand. Please enter a valid number.");
        }

        return operand;
    }

    private static string ReadOperator(TextReader input, TextWriter output)
    {
        output.Write("Enter an operator (+, -, *, /, %, ^): ");

        string? operation = input.ReadLine();
        if (string.IsNullOrWhiteSpace(operation))
        {
            throw new ArgumentException("Operator cannot be null or empty.", nameof(input));
        }

        return operation.Trim();
    }
}
