#nullable enable

using calculator;

namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit test suite for the Calculator class.
/// Combines CSV-driven tests for main operations with focused tests for edge cases and error conditions.
/// </summary>
public class CalculatorTest
{
    private const double Tolerance = 0.0001;
    
    private static readonly string TestDataPath = Path.Combine(
        AppContext.BaseDirectory,
        "TestData",
        "CalculatorTestData.csv"
    );

    /// <summary>
    /// Loads test data from CSV file and yields test cases as object arrays for MemberData-driven tests.
    /// </summary>
    public static IEnumerable<object[]> LoadTestDataFromCsv()
    {
        if (!File.Exists(TestDataPath))
            throw new FileNotFoundException($"Test data file not found at: {TestDataPath}");

        var lines = File.ReadAllLines(TestDataPath);
        foreach (var line in lines.Skip(1))
        {
            if (string.IsNullOrWhiteSpace(line)) continue;
            var parts = line.Split(',');
            if (parts.Length < 5) continue;

            if (!double.TryParse(parts[0].Trim(), out var firstNumber)) continue;
            if (!double.TryParse(parts[1].Trim(), out var secondNumber)) continue;
            var operatorSymbol = parts[2].Trim();
            if (!double.TryParse(parts[3].Trim(), out var expectedResult)) continue;
            var description = parts[4].Trim();

            yield return new object[] { firstNumber, secondNumber, operatorSymbol, expectedResult, description };
        }
    }

    #region CSV-Driven Tests

    /// <summary>
    /// Data-driven test that executes all calculator operations using test data from CSV file.
    /// Combines all operations in a single parameterized test for comprehensive coverage.
    /// The testDescription parameter is used to provide context when a test fails.
    /// </summary>
    [Theory]
    [MemberData(nameof(LoadTestDataFromCsv))]
    public void Calculate_WithCsvData_ReturnsExpectedResult(
        double firstNumber, 
        double secondNumber, 
        string operatorSymbol, 
        double expectedResult, 
        string testDescription)
    {
        // Act
        double result = Calculator.Calculate(firstNumber, secondNumber, operatorSymbol);
        
        // Assert with precision handling for floating-point operations
        if (operatorSymbol == "^" || operatorSymbol == "/")
        {
            Assert.Equal(expectedResult, result, precision: 10);
        }
        else
        {
            Assert.Equal(expectedResult, result, Tolerance);
        }
        
        // Context: testDescription is available for debugging test failures
        _ = testDescription;  // Suppress unused parameter warning
    }

    #endregion

    #region Error Condition Tests

    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Divide(10.5, 0));
    }

    [Fact]
    public void Modulo_ByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Modulo(10.5, 0));
    }

    [Fact]
    public void Calculate_DivisionByZero_ThrowsDivideByZeroException()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10.5, 0, "/"));
    }

    [Fact]
    public void Calculate_UnknownOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => Calculator.Calculate(5.5, 3.2, "?"));
    }

    [Fact]
    public void Calculate_NullOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => Calculator.Calculate(5.5, 3.2, null!));
    }

    [Fact]
    public void Calculate_EmptyOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => Calculator.Calculate(5.5, 3.2, ""));
    }

    [Fact]
    public void Calculate_OperatorWithWhitespace_StillWorks()
    {
        // Verify whitespace handling - should still accept " + " as valid operator
        double result = Calculator.Calculate(5.5, 3.2, " + ");
        Assert.Equal(8.7, result, Tolerance);
    }

    #endregion

    #region Edge Case Tests

    [Fact]
    public void Add_WithZero_ReturnsOtherNumber()
    {
        Assert.Equal(5.5, Calculator.Add(5.5, 0), Tolerance);
    }

    [Fact]
    public void Multiply_ByZero_ReturnsZero()
    {
        Assert.Equal(0, Calculator.Multiply(5.5, 0), Tolerance);
    }

    [Fact]
    public void Division_ResultsInDecimal_ReturnsDecimalValue()
    {
        Assert.Equal(2.333333, Calculator.Divide(7.0, 3.0), Tolerance);
    }

    [Fact]
    public void Power_WithZeroExponent_ReturnsOne()
    {
        Assert.Equal(1.0, Calculator.Power(5.5, 0), Tolerance);
    }

    [Fact]
    public void Power_WithNegativeExponent_ReturnsReciprocal()
    {
        Assert.Equal(0.25, Calculator.Power(2.0, -2.0), Tolerance);
    }

    #endregion
}
