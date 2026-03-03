#nullable enable

using System.Collections.Generic;
using System.IO;
using System.Linq;
using Xunit;
using Calculator;

namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit tests for the Calculator class.
/// Tests cover normal cases, edge cases, and error conditions.
/// </summary>
public class CalculatorTest
{
    #region Add Operation Tests

    [Fact]
    public void Add_WithPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 5;
        double b = 3;
        double expected = 8;

        // Act
        double result = Calculator.Calculator.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Add_WithNegativeNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = -5;
        double b = -3;
        double expected = -8;

        // Act
        double result = Calculator.Calculator.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Add_WithMixedSignNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 10;
        double b = -3;
        double expected = 7;

        // Act
        double result = Calculator.Calculator.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(1, 1, 2)]
    [InlineData(2.5, 2.5, 5)]
    [InlineData(100, 200, 300)]
    [InlineData(-10, -20, -30)]
    [InlineData(15.75, 24.25, 40)]
    public void Add_WithVariousInputs_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Calculator.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    #endregion

    #region Subtract Operation Tests

    [Fact]
    public void Subtract_WithPositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = 10;
        double b = 3;
        double expected = 7;

        // Act
        double result = Calculator.Calculator.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Subtract_WithNegativeNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = -10;
        double b = -3;
        double expected = -7;

        // Act
        double result = Calculator.Calculator.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Subtract_WithMixedSignNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = 10;
        double b = -5;
        double expected = 15;

        // Act
        double result = Calculator.Calculator.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(5, 2, 3)]
    [InlineData(10.5, 3.5, 7)]
    [InlineData(100, 50, 50)]
    [InlineData(-5, 5, -10)]
    [InlineData(25.75, 10.25, 15.5)]
    public void Subtract_WithVariousInputs_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Calculator.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    #endregion

    #region Multiply Operation Tests

    [Fact]
    public void Multiply_WithPositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = 4;
        double b = 5;
        double expected = 20;

        // Act
        double result = Calculator.Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Multiply_WithNegativeNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = -4;
        double b = -5;
        double expected = 20;

        // Act
        double result = Calculator.Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Multiply_WithMixedSignNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = -4;
        double b = 5;
        double expected = -20;

        // Act
        double result = Calculator.Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Multiply_WithZero_ReturnsZero()
    {
        // Arrange
        double a = 100;
        double b = 0;
        double expected = 0;

        // Act
        double result = Calculator.Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(1, 1, 1)]
    [InlineData(3, 4, 12)]
    [InlineData(2.5, 2, 5)]
    [InlineData(10, 10, 100)]
    [InlineData(-2, 3, -6)]
    public void Multiply_WithVariousInputs_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    #endregion

    #region Divide Operation Tests

    [Fact]
    public void Divide_WithPositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = 20;
        double b = 4;
        double expected = 5;

        // Act
        double result = Calculator.Calculator.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Divide_WithNegativeNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = -20;
        double b = -4;
        double expected = 5;

        // Act
        double result = Calculator.Calculator.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Divide_WithMixedSignNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = 20;
        double b = -4;
        double expected = -5;

        // Act
        double result = Calculator.Calculator.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double a = 10;
        double b = 0;

        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculator.Divide(a, b));
    }

    [Fact]
    public void Divide_ZeroByNumber_ReturnsZero()
    {
        // Arrange
        double a = 0;
        double b = 5;
        double expected = 0;

        // Act
        double result = Calculator.Calculator.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(10, 2, 5)]
    [InlineData(15, 3, 5)]
    [InlineData(100, 10, 10)]
    [InlineData(7.5, 2.5, 3)]
    [InlineData(-10, 2, -5)]
    public void Divide_WithVariousInputs_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Calculator.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    #endregion

    #region Modulo Operation Tests

    [Fact]
    public void Modulo_WithPositiveNumbers_ReturnsCorrectRemainder()
    {
        // Arrange
        double a = 10;
        double b = 3;
        double expected = 1;

        // Act
        double result = Calculator.Calculator.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Modulo_WithNegativeNumbers_ReturnsCorrectRemainder()
    {
        // Arrange
        double a = -10;
        double b = 3;
        double expected = -1;

        // Act
        double result = Calculator.Calculator.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Modulo_BytZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double a = 10;
        double b = 0;

        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculator.Modulo(a, b));
    }

    [Fact]
    public void Modulo_WhenDivisible_ReturnsZero()
    {
        // Arrange
        double a = 10;
        double b = 5;
        double expected = 0;

        // Act
        double result = Calculator.Calculator.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(10, 3, 1)]
    [InlineData(17, 5, 2)]
    [InlineData(20, 4, 0)]
    [InlineData(15, 6, 3)]
    public void Modulo_WithVariousInputs_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Calculator.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    #endregion

    #region Power Operation Tests

    [Fact]
    public void Power_WithPositiveExponent_ReturnsCorrectResult()
    {
        // Arrange
        double a = 2;
        double b = 3;
        double expected = 8;

        // Act
        double result = Calculator.Calculator.Power(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Power_WithZeroExponent_ReturnsOne()
    {
        // Arrange
        double a = 5;
        double b = 0;
        double expected = 1;

        // Act
        double result = Calculator.Calculator.Power(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Power_WithNegativeExponent_ReturnsCorrectResult()
    {
        // Arrange
        double a = 2;
        double b = -2;
        double expected = 0.25;

        // Act
        double result = Calculator.Calculator.Power(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Power_BaseOfOne_ReturnsOne()
    {
        // Arrange
        double a = 1;
        double b = 100;
        double expected = 1;

        // Act
        double result = Calculator.Calculator.Power(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(2, 1, 2)]
    [InlineData(2, 2, 4)]
    [InlineData(3, 2, 9)]
    [InlineData(5, 3, 125)]
    [InlineData(10, 2, 100)]
    public void Power_WithVariousInputs_ReturnsCorrectResult(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Calculator.Power(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    #endregion

    #region Calculate Dispatcher Tests

    [Fact]
    public void Calculate_WithAddOperator_CallsAddAndReturnsCorrectResult()
    {
        // Arrange
        double a = 10;
        double b = 5;
        string operatorSymbol = "+";
        double expected = 15;

        // Act
        double result = Calculator.Calculator.Calculate(a, b, operatorSymbol);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_WithSubtractOperator_CallsSubtractAndReturnsCorrectResult()
    {
        // Arrange
        double a = 10;
        double b = 5;
        string operatorSymbol = "-";
        double expected = 5;

        // Act
        double result = Calculator.Calculator.Calculate(a, b, operatorSymbol);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_WithMultiplyOperator_CallsMultiplyAndReturnsCorrectResult()
    {
        // Arrange
        double a = 10;
        double b = 5;
        string operatorSymbol = "*";
        double expected = 50;

        // Act
        double result = Calculator.Calculator.Calculate(a, b, operatorSymbol);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_WithDivideOperator_CallsDivideAndReturnsCorrectResult()
    {
        // Arrange
        double a = 10;
        double b = 5;
        string operatorSymbol = "/";
        double expected = 2;

        // Act
        double result = Calculator.Calculator.Calculate(a, b, operatorSymbol);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_WithModuloOperator_CallsModuloAndReturnsCorrectResult()
    {
        // Arrange
        double a = 10;
        double b = 3;
        string operatorSymbol = "%";
        double expected = 1;

        // Act
        double result = Calculator.Calculator.Calculate(a, b, operatorSymbol);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_WithPowerOperator_CallsPowerAndReturnsCorrectResult()
    {
        // Arrange
        double a = 2;
        double b = 3;
        string operatorSymbol = "^";
        double expected = 8;

        // Act
        double result = Calculator.Calculator.Calculate(a, b, operatorSymbol);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_WithNullOperator_ThrowsArgumentException()
    {
        // Arrange
        double a = 10;
        double b = 5;
        string? operatorSymbol = null;

        // Act & Assert
        Assert.Throws<ArgumentException>(() => Calculator.Calculator.Calculate(a, b, operatorSymbol));
    }

    [Fact]
    public void Calculate_WithUnknownOperator_ThrowsArgumentException()
    {
        // Arrange
        double a = 10;
        double b = 5;
        string operatorSymbol = "&";

        // Act & Assert
        Assert.Throws<ArgumentException>(() => Calculator.Calculator.Calculate(a, b, operatorSymbol));
    }

    [Fact]
    public void Calculate_WithDivisionByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double a = 10;
        double b = 0;
        string operatorSymbol = "/";

        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculator.Calculate(a, b, operatorSymbol));
    }

    #endregion

    #region CSV Data-Driven Tests

    /// <summary>
    /// Path to the CSV test data file.
    /// Uses AppContext.BaseDirectory to locate the file in the output directory.
    /// </summary>
    private static readonly string TestDataPath = Path.Combine(
        AppContext.BaseDirectory,
        "TestData",
        "CalculatorTestData.csv"
    );

    /// <summary>
    /// Loads test data from the CalculatorTestData.csv file.
    /// CSV format: firstNumber, secondNumber, operator, expectedResult, testDescription
    /// </summary>
    /// <returns>IEnumerable of object arrays containing test data</returns>
    /// <exception cref="FileNotFoundException">Thrown if CSV file is not found</exception>
    public static IEnumerable<object[]> LoadTestDataFromCsv()
    {
        if (!File.Exists(TestDataPath))
            throw new FileNotFoundException($"Test data file not found: {TestDataPath}");

        var lines = File.ReadAllLines(TestDataPath);

        foreach (var line in lines.Skip(1))
        {
            if (string.IsNullOrWhiteSpace(line))
                continue;

            var parts = line.Split(',');
            if (parts.Length < 5)
                continue;

            yield return new object[]
            {
                double.Parse(parts[0].Trim()),
                double.Parse(parts[1].Trim()),
                parts[2].Trim(),
                double.Parse(parts[3].Trim()),
                parts[4].Trim()
            };
        }
    }

    /// <summary>
    /// CSV-driven theory test that validates all calculator operations using data from CalculatorTestData.csv.
    /// Tests cover addition, subtraction, multiplication, division, modulo, and power operations.
    /// Handles floating-point precision for division and power operations.
    /// </summary>
    /// <param name="firstNumber">First operand</param>
    /// <param name="secondNumber">Second operand</param>
    /// <param name="op">Operator symbol (+, -, *, /, %, ^)</param>
    /// <param name="expectedResult">Expected calculation result</param>
    /// <param name="testDescription">Description of the test case for clarity in test output and debugging</param>
#pragma warning disable xUnit1026 // testDescription is intentionally included for test identification and xUnit output
    [Theory]
    [MemberData(nameof(LoadTestDataFromCsv))]
    public void Calculate_WithCsvData_ReturnsCorrectResult(
        double firstNumber,
        double secondNumber,
        string op,
        double expectedResult,
        string testDescription)
    {
        // testDescription parameter is intentionally kept for xUnit theory data display
        _ = testDescription;

        // Act
        double result = Calculator.Calculator.Calculate(firstNumber, secondNumber, op);

        // Assert - Use precision handling for floating-point operations
        if (op == "^" || op == "/")
        {
            Assert.Equal(expectedResult, result, precision: 10);
        }
        else
        {
            Assert.Equal(expectedResult, result);
        }
    }
#pragma warning restore xUnit1026

    #endregion
}
