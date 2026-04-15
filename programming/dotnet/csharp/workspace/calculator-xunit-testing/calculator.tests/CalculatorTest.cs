#nullable enable

namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit tests for the Calculator class using CSV-driven and individual tests.
/// Tests all arithmetic operations with normal cases, edge cases, and error conditions.
/// CSV-driven tests: 38 tests covering all operations with various inputs
/// Error/Edge case tests: 10 tests for error conditions and special cases
/// Total: 48 tests covering all calculator functionality.
/// </summary>
public class CalculatorTest
{
    /// <summary>
    /// Path to the CSV test data file. Uses AppContext.BaseDirectory to locate the file
    /// in the output directory after the build process.
    /// </summary>
    private static readonly string TestDataPath = Path.Combine(
        AppContext.BaseDirectory,
        "TestData",
        "CalculatorTestData.csv"
    );

    /// <summary>
    /// Loads test data from CSV file and yields test cases for MemberData.
    /// CSV columns: firstNumber, secondNumber, operator, expectedResult, testDescription
    /// 
    /// This method is public and static as required by xUnit's MemberData attribute.
    /// </summary>
    /// <returns>Enumerable of object arrays containing test parameters</returns>
    /// <exception cref="FileNotFoundException">Thrown when CSV file is not found</exception>
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

            // Parse CSV columns: firstNumber, secondNumber, operator, expectedResult, testDescription
            double firstNumber = double.Parse(parts[0].Trim());
            double secondNumber = double.Parse(parts[1].Trim());
            string op = parts[2].Trim();
            double expectedResult = double.Parse(parts[3].Trim());
            string testDescription = parts[4].Trim();

            yield return new object[]
            {
                firstNumber,
                secondNumber,
                op,
                expectedResult,
                testDescription
            };
        }
    }

    #region CSV-Driven Calculator Tests

    /// <summary>
    /// Theory test that uses CSV data to validate all calculator operations.
    /// Handles floating-point precision for division and power operations.
    /// 
    /// Test parameters from CSV:
    /// - firstNumber: First operand
    /// - secondNumber: Second operand
    /// - op: Operation (+, -, *, /, %, ^)
    /// - expectedResult: Expected calculation result
    /// - testDescription: Human-readable test description
    /// </summary>
    [Theory]
    [MemberData(nameof(LoadTestDataFromCsv))]
    public void Calculate_WithCsvData_ReturnsExpectedResult(
        double firstNumber,
        double secondNumber,
        string op,
        double expectedResult,
        string testDescription)
    {
        // Act
        double result = Calculator.Calculate(firstNumber, secondNumber, op);

        // Assert - Use precision for division and power operations due to floating-point precision
        if (op == "^" || op == "/")
        {
            Assert.Equal(expectedResult, result, precision: 10);
        }
        else
        {
            Assert.Equal(expectedResult, result);
        }
    }

    #endregion

    #region Error Condition Tests

    /// <summary>
    /// Tests that division by zero throws DivideByZeroException.
    /// This error condition cannot be easily tested via CSV and requires explicit testing.
    /// </summary>
    [Fact]
    public void Calculate_DivideByZero_ThrowsDivideByZeroException()
    {
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10, 0, "/"));
    }

    /// <summary>
    /// Tests that modulo by zero throws DivideByZeroException.
    /// This error condition cannot be easily tested via CSV and requires explicit testing.
    /// </summary>
    [Fact]
    public void Calculate_ModuloByZero_ThrowsDivideByZeroException()
    {
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10, 0, "%"));
    }

    /// <summary>
    /// Tests that null operator throws ArgumentException with appropriate message.
    /// </summary>
    [Fact]
    public void Calculate_NullOperator_ThrowsArgumentException()
    {
        // Act & Assert
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, null!));
        Assert.Contains("cannot be null or empty", ex.Message);
    }

    /// <summary>
    /// Tests that empty operator throws ArgumentException with appropriate message.
    /// </summary>
    [Fact]
    public void Calculate_EmptyOperator_ThrowsArgumentException()
    {
        // Act & Assert
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, ""));
        Assert.Contains("cannot be null or empty", ex.Message);
    }

    /// <summary>
    /// Tests that invalid operator throws ArgumentException with appropriate message.
    /// </summary>
    [Fact]
    public void Calculate_InvalidOperator_ThrowsArgumentException()
    {
        // Act & Assert
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, "&"));
        Assert.Contains("Invalid operator", ex.Message);
    }

    #endregion

    #region Individual Operation Tests (Supplementary)

    /// <summary>
    /// Tests the Add operation directly.
    /// Supplementary test to verify operation isolation from Calculate method.
    /// </summary>
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 5;
        double b = 3;

        // Act
        double result = Calculator.Add(a, b);

        // Assert
        Assert.Equal(8, result);
    }

    /// <summary>
    /// Tests the Subtract operation directly.
    /// Supplementary test to verify operation isolation from Calculate method.
    /// </summary>
    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = 5;
        double b = 3;

        // Act
        double result = Calculator.Subtract(a, b);

        // Assert
        Assert.Equal(2, result);
    }

    /// <summary>
    /// Tests the Multiply operation directly.
    /// Supplementary test to verify operation isolation from Calculate method.
    /// </summary>
    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = 5;
        double b = 3;

        // Act
        double result = Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(15, result);
    }

    /// <summary>
    /// Tests the Divide operation directly.
    /// Supplementary test to verify operation isolation from Calculate method.
    /// </summary>
    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = 6;
        double b = 2;

        // Act
        double result = Calculator.Divide(a, b);

        // Assert
        Assert.Equal(3, result);
    }

    /// <summary>
    /// Tests the Modulo operation directly.
    /// Supplementary test to verify operation isolation from Calculate method.
    /// </summary>
    [Fact]
    public void Modulo_TwoNumbers_ReturnsCorrectRemainder()
    {
        // Arrange
        double a = 7;
        double b = 3;

        // Act
        double result = Calculator.Modulo(a, b);

        // Assert
        Assert.Equal(1, result);
    }

    /// <summary>
    /// Tests the Power operation directly.
    /// Supplementary test to verify operation isolation from Calculate method.
    /// </summary>
    [Fact]
    public void Power_BaseAndExponent_ReturnsCorrectPower()
    {
        // Arrange
        double baseNum = 2;
        double exponent = 3;

        // Act
        double result = Calculator.Power(baseNum, exponent);

        // Assert
        Assert.Equal(8, result);
    }

    #endregion
}
