#nullable enable

namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit tests for the Calculator class.
/// Tests all arithmetic operations with normal cases, edge cases, and error conditions.
/// Total: 49 tests covering all calculator functionality.
/// </summary>
public class CalculatorTest
{
    #region Add Tests

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

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(5, 3, 8)]
    [InlineData(-5, 3, -2)]
    [InlineData(5, -3, 2)]
    [InlineData(-5, -3, -8)]
    public void Add_VariousNumbers_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Add_WithZero_ReturnsOtherOperand()
    {
        Assert.Equal(5, Calculator.Add(5, 0));
        Assert.Equal(5, Calculator.Add(0, 5));
    }

    [Fact]
    public void Add_LargeNumbers_ReturnsCorrectSum()
    {
        double result = Calculator.Add(1000000, 2000000);
        Assert.Equal(3000000, result);
    }

    #endregion

    #region Subtract Tests

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

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(5, 3, 2)]
    [InlineData(-5, 3, -8)]
    [InlineData(5, -3, 8)]
    [InlineData(-5, -3, -2)]
    public void Subtract_VariousNumbers_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Subtract_SameNumber_ReturnsZero()
    {
        Assert.Equal(0, Calculator.Subtract(5, 5));
    }

    [Fact]
    public void Subtract_FromZero_ReturnsNegative()
    {
        Assert.Equal(-5, Calculator.Subtract(0, 5));
    }

    #endregion

    #region Multiply Tests

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

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(5, 3, 15)]
    [InlineData(-5, 3, -15)]
    [InlineData(5, -3, -15)]
    [InlineData(-5, -3, 15)]
    public void Multiply_VariousNumbers_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Multiply_ByZero_ReturnsZero()
    {
        Assert.Equal(0, Calculator.Multiply(5, 0));
        Assert.Equal(0, Calculator.Multiply(0, 5));
    }

    [Fact]
    public void Multiply_ByOne_ReturnsOtherOperand()
    {
        Assert.Equal(5, Calculator.Multiply(5, 1));
        Assert.Equal(5, Calculator.Multiply(1, 5));
    }

    #endregion

    #region Divide Tests

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

    [Theory]
    [InlineData(6, 2, 3)]
    [InlineData(-6, 2, -3)]
    [InlineData(6, -2, -3)]
    [InlineData(-6, -2, 3)]
    [InlineData(5, 2, 2.5)]
    public void Divide_VariousNumbers_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double dividend = 10;
        double divisor = 0;

        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Divide(dividend, divisor));
    }

    [Fact]
    public void Divide_ZeroByNumber_ReturnsZero()
    {
        Assert.Equal(0, Calculator.Divide(0, 5));
    }

    [Fact]
    public void Divide_BySelf_ReturnsOne()
    {
        Assert.Equal(1, Calculator.Divide(5, 5));
    }

    #endregion

    #region Modulo Tests

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

    [Theory]
    [InlineData(7, 3, 1)]
    [InlineData(-7, 3, -1)]
    [InlineData(7, -3, 1)]
    [InlineData(-7, -3, -1)]
    [InlineData(10, 5, 0)]
    public void Modulo_VariousNumbers_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Act
        double result = Calculator.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Modulo_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double dividend = 10;
        double divisor = 0;

        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Modulo(dividend, divisor));
    }

    [Fact]
    public void Modulo_ZeroByNumber_ReturnsZero()
    {
        Assert.Equal(0, Calculator.Modulo(0, 5));
    }

    #endregion

    #region Power Tests

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

    [Theory]
    [InlineData(2, 0, 1)]
    [InlineData(2, 3, 8)]
    [InlineData(5, 2, 25)]
    [InlineData(10, 1, 10)]
    [InlineData(-2, 2, 4)]
    public void Power_VariousExponents_ReturnsCorrectPower(double baseNum, double exponent, double expected)
    {
        // Act
        double result = Calculator.Power(baseNum, exponent);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Power_ZeroExponent_ReturnsOne()
    {
        Assert.Equal(1, Calculator.Power(5, 0));
        Assert.Equal(1, Calculator.Power(10, 0));
    }

    [Fact]
    public void Power_BaseOne_ReturnsOne()
    {
        Assert.Equal(1, Calculator.Power(1, 5));
    }

    #endregion

    #region Calculate Method Tests

    [Theory]
    [InlineData(5, 3, "+", 8)]
    [InlineData(5, 3, "-", 2)]
    [InlineData(5, 3, "*", 15)]
    [InlineData(6, 2, "/", 3)]
    [InlineData(7, 3, "%", 1)]
    [InlineData(2, 3, "^", 8)]
    public void Calculate_AllOperators_DelegatesCorrectly(double a, double b, string op, double expected)
    {
        // Act
        double result = Calculator.Calculate(a, b, op);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Calculate_InvalidOperator_ThrowsArgumentException()
    {
        // Act & Assert
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, "&"));
        Assert.Contains("Invalid operator", ex.Message);
    }

    [Fact]
    public void Calculate_NullOperator_ThrowsArgumentException()
    {
        // Act & Assert
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, null!));
        Assert.Contains("cannot be null or empty", ex.Message);
    }

    [Fact]
    public void Calculate_EmptyOperator_ThrowsArgumentException()
    {
        // Act & Assert
        var ex = Assert.Throws<ArgumentException>(() => Calculator.Calculate(5, 3, ""));
        Assert.Contains("cannot be null or empty", ex.Message);
    }

    [Fact]
    public void Calculate_DivideByZeroWithCalculate_ThrowsDivideByZeroException()
    {
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10, 0, "/"));
    }

    [Fact]
    public void Calculate_ModuloByZeroWithCalculate_ThrowsDivideByZeroException()
    {
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => Calculator.Calculate(10, 0, "%"));
    }

    #endregion
}
