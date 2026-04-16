namespace calculator.tests;

/// <summary>
/// Verifies the calculator console workflow and arithmetic behavior.
/// </summary>
public class CalculatorTest
{
    [Fact]
    public void Run_PromptsForOperandsBeforeOperator()
    {
        using StringReader input = new("4\n5\n+\n");
        using StringWriter output = new();

        CalculatorConsole.Run(input, output);

        string consoleOutput = output.ToString();
        int firstOperandPromptIndex = consoleOutput.IndexOf("Enter the first operand: ", StringComparison.Ordinal);
        int secondOperandPromptIndex = consoleOutput.IndexOf("Enter the second operand: ", StringComparison.Ordinal);
        int operatorPromptIndex = consoleOutput.IndexOf("Enter an operator (+, -, *, /, %, ^): ", StringComparison.Ordinal);

        Assert.True(firstOperandPromptIndex >= 0);
        Assert.True(secondOperandPromptIndex > firstOperandPromptIndex);
        Assert.True(operatorPromptIndex > secondOperandPromptIndex);
        Assert.Contains("Result: 4 + 5 = 9", consoleOutput, StringComparison.Ordinal);
    }

    [Fact]
    public void Run_WithInvalidFirstOperand_ThrowsArgumentException()
    {
        using StringReader input = new("abc\n");
        using StringWriter output = new();

        ArgumentException exception = Assert.Throws<ArgumentException>(() => CalculatorConsole.Run(input, output));

        Assert.Equal("Invalid operand. Please enter a valid number.", exception.Message);
    }

    [Fact]
    public void Calculate_WithOperatorAsThirdArgument_ReturnsExpectedResult()
    {
        double result = Calculator.Calculate(10, 2, "-");

        Assert.Equal(8, result);
    }
}
