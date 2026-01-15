namespace calculator.tests;

using calculator.shared;

/// <summary>
/// xUnit test class for calculator operations.
/// Tests all arithmetic operations with various test cases.
/// </summary>
public class CalculatorTest
{
    // Addition Tests
    
    /// <summary>
    /// Tests basic addition of two positive numbers.
    /// </summary>
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 5;
        double b = 3;
        double expected = 8;

        // Act
        double result = CalculatorMethods.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests addition with negative numbers.
    /// </summary>
    [Theory]
    [InlineData(10, 5, 15)]
    [InlineData(-10, -5, -15)]
    [InlineData(10, -5, 5)]
    [InlineData(-10, 5, -5)]
    public void Add_VariousNumbers_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Act
        double result = CalculatorMethods.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    // Subtraction Tests

    /// <summary>
    /// Tests basic subtraction of two positive numbers.
    /// </summary>
    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = 10;
        double b = 3;
        double expected = 7;

        // Act
        double result = CalculatorMethods.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests subtraction with various number combinations.
    /// </summary>
    [Theory]
    [InlineData(10, 5, 5)]
    [InlineData(-10, -5, -5)]
    [InlineData(10, -5, 15)]
    [InlineData(-10, 5, -15)]
    public void Subtract_VariousNumbers_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Act
        double result = CalculatorMethods.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    // Multiplication Tests

    /// <summary>
    /// Tests basic multiplication of two positive numbers.
    /// </summary>
    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = 4;
        double b = 5;
        double expected = 20;

        // Act
        double result = CalculatorMethods.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests multiplication with various number combinations.
    /// </summary>
    [Theory]
    [InlineData(6, 7, 42)]
    [InlineData(-6, 7, -42)]
    [InlineData(6, -7, -42)]
    [InlineData(-6, -7, 42)]
    [InlineData(0, 5, 0)]
    public void Multiply_VariousNumbers_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Act
        double result = CalculatorMethods.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    // Division Tests

    /// <summary>
    /// Tests basic division of two positive numbers.
    /// </summary>
    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = 20;
        double b = 4;
        double expected = 5;

        // Act
        double result = CalculatorMethods.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests division with various number combinations.
    /// </summary>
    [Theory]
    [InlineData(20, 4, 5)]
    [InlineData(-20, 4, -5)]
    [InlineData(20, -4, -5)]
    [InlineData(-20, -4, 5)]
    public void Divide_VariousNumbers_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Act
        double result = CalculatorMethods.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests division by zero returns positive infinity.
    /// </summary>
    [Fact]
    public void Divide_ByZero_ReturnsPositiveInfinity()
    {
        // Arrange
        double a = 10;
        double b = 0;

        // Act
        double result = CalculatorMethods.Divide(a, b);

        // Assert
        Assert.True(double.IsPositiveInfinity(result));
    }

    // Modulo Tests

    /// <summary>
    /// Tests basic modulo operation.
    /// </summary>
    [Fact]
    public void Modulo_TwoPositiveNumbers_ReturnsCorrectRemainder()
    {
        // Arrange
        double a = 10;
        double b = 3;
        double expected = 1;

        // Act
        double result = CalculatorMethods.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests modulo with various number combinations.
    /// </summary>
    [Theory]
    [InlineData(10, 3, 1)]
    [InlineData(15, 4, 3)]
    [InlineData(20, 5, 0)]
    [InlineData(-10, 3, -1)]
    public void Modulo_VariousNumbers_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Act
        double result = CalculatorMethods.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests modulo by zero returns NaN.
    /// </summary>
    [Fact]
    public void Modulo_ByZero_ReturnsNaN()
    {
        // Arrange
        double a = 10;
        double b = 0;

        // Act
        double result = CalculatorMethods.Modulo(a, b);

        // Assert
        Assert.True(double.IsNaN(result));
    }

    // Exponent Tests

    /// <summary>
    /// Tests basic exponentiation.
    /// </summary>
    [Fact]
    public void Exponent_PositiveBaseAndExponent_ReturnsCorrectPower()
    {
        // Arrange
        double a = 2;
        double b = 3;
        double expected = 8;

        // Act
        double result = CalculatorMethods.Exponent(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Tests exponentiation with various number combinations.
    /// </summary>
    [Theory]
    [InlineData(2, 3, 8)]
    [InlineData(5, 2, 25)]
    [InlineData(10, 0, 1)]
    [InlineData(2, -2, 0.25)]
    public void Exponent_VariousNumbers_ReturnsCorrectPower(double a, double b, double expected)
    {
        // Act
        double result = CalculatorMethods.Exponent(a, b);

        // Assert
        Assert.Equal(expected, result);
    }
}