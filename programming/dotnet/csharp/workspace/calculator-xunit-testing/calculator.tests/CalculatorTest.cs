using Xunit;

/// <summary>
/// Test suite for CalculatorOperations class following section 1.12.4 Testing Strategy.
/// Tests include Fact tests for simple assertions and Theory tests with InlineData for multiple cases.
/// Coverage includes normal cases, edge cases, and error conditions.
/// </summary>
public class CalculatorTest
{
    #region Addition Tests
    
    /// <summary>
    /// Fact test: Verifies basic addition with positive numbers.
    /// </summary>
    [Fact]
    public void Add_PositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 5;
        double b = 3;
        double expected = 8;

        // Act
        double result = CalculatorOperations.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Theory test: Verifies addition with multiple test cases including normal, negative, and zero values.
    /// </summary>
    [Theory]
    [InlineData(5, 3, 8)]           // Normal case: positive numbers
    [InlineData(-5, -3, -8)]        // Edge case: negative numbers
    [InlineData(0, 5, 5)]           // Edge case: zero operand
    [InlineData(5.5, 2.3, 7.8)]     // Normal case: decimal numbers
    [InlineData(-5, 5, 0)]          // Edge case: opposites sum to zero
    public void Add_VariousCases_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Add(a, b);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    #endregion

    #region Subtraction Tests

    /// <summary>
    /// Fact test: Verifies basic subtraction with positive numbers.
    /// </summary>
    [Fact]
    public void Subtract_PositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = 10;
        double b = 3;
        double expected = 7;

        // Act
        double result = CalculatorOperations.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Theory test: Verifies subtraction with multiple test cases including normal, negative, and zero values.
    /// </summary>
    [Theory]
    [InlineData(10, 3, 7)]          // Normal case: positive numbers
    [InlineData(-5, -3, -2)]        // Edge case: negative numbers
    [InlineData(5, 0, 5)]           // Edge case: subtract zero
    [InlineData(0, 5, -5)]          // Edge case: subtract from zero
    [InlineData(7.5, 2.3, 5.2)]     // Normal case: decimal numbers
    public void Subtract_VariousCases_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Subtract(a, b);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    #endregion

    #region Multiplication Tests

    /// <summary>
    /// Fact test: Verifies basic multiplication with positive numbers.
    /// </summary>
    [Fact]
    public void Multiply_PositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = 4;
        double b = 5;
        double expected = 20;

        // Act
        double result = CalculatorOperations.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Theory test: Verifies multiplication with multiple test cases including normal, negative, and zero values.
    /// </summary>
    [Theory]
    [InlineData(4, 5, 20)]          // Normal case: positive numbers
    [InlineData(-4, -5, 20)]        // Edge case: negative numbers (product positive)
    [InlineData(-4, 5, -20)]        // Edge case: mixed signs
    [InlineData(0, 5, 0)]           // Edge case: multiply by zero
    [InlineData(2.5, 4, 10)]        // Normal case: decimal numbers
    public void Multiply_VariousCases_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Multiply(a, b);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    #endregion

    #region Division Tests

    /// <summary>
    /// Fact test: Verifies basic division with positive numbers.
    /// </summary>
    [Fact]
    public void Divide_PositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = 20;
        double b = 4;
        double expected = 5;

        // Act
        double result = CalculatorOperations.Divide(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Fact test: Verifies division by zero returns NaN (error condition).
    /// </summary>
    [Fact]
    public void Divide_ByZero_ReturnsNaN()
    {
        // Arrange
        double a = 10;
        double b = 0;

        // Act
        double result = CalculatorOperations.Divide(a, b);

        // Assert
        Assert.True(double.IsNaN(result), "Division by zero should return NaN");
    }

    /// <summary>
    /// Theory test: Verifies division with multiple test cases including normal, negative, and edge values.
    /// </summary>
    [Theory]
    [InlineData(20, 4, 5)]          // Normal case: positive numbers
    [InlineData(-20, -4, 5)]        // Edge case: negative numbers (quotient positive)
    [InlineData(-20, 4, -5)]        // Edge case: mixed signs
    [InlineData(0, 5, 0)]           // Edge case: zero dividend
    [InlineData(10, 2.5, 4)]        // Normal case: decimal numbers
    public void Divide_VariousCases_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Divide(a, b);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    #endregion

    #region Modulo Tests

    /// <summary>
    /// Fact test: Verifies basic modulo operation with positive numbers.
    /// </summary>
    [Fact]
    public void Modulo_PositiveNumbers_ReturnsCorrectRemainder()
    {
        // Arrange
        double a = 10;
        double b = 3;
        double expected = 1;

        // Act
        double result = CalculatorOperations.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Fact test: Verifies modulo by zero returns NaN (error condition).
    /// </summary>
    [Fact]
    public void Modulo_ByZero_ReturnsNaN()
    {
        // Arrange
        double a = 10;
        double b = 0;

        // Act
        double result = CalculatorOperations.Modulo(a, b);

        // Assert
        Assert.True(double.IsNaN(result), "Modulo by zero should return NaN");
    }

    /// <summary>
    /// Theory test: Verifies modulo with multiple test cases including normal, negative, and edge values.
    /// </summary>
    [Theory]
    [InlineData(10, 3, 1)]          // Normal case: positive numbers
    [InlineData(-10, 3, -1)]        // Edge case: negative dividend
    [InlineData(10, -3, 1)]         // Edge case: negative divisor
    [InlineData(0, 5, 0)]           // Edge case: zero dividend
    [InlineData(7.5, 2.5, 0)]       // Normal case: decimal numbers
    public void Modulo_VariousCases_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Modulo(a, b);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    #endregion

    #region Exponent Tests

    /// <summary>
    /// Fact test: Verifies basic exponent operation.
    /// </summary>
    [Fact]
    public void Exponent_PositiveExponent_ReturnsCorrectPower()
    {
        // Arrange
        double a = 2;
        double b = 3;
        double expected = 8;

        // Act
        double result = CalculatorOperations.Exponent(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Theory test: Verifies exponent with multiple test cases including normal, zero, negative, and edge values.
    /// </summary>
    [Theory]
    [InlineData(2, 3, 8)]           // Normal case: positive base and exponent
    [InlineData(2, 0, 1)]           // Edge case: any number to power 0 is 1
    [InlineData(5, 2, 25)]          // Normal case: squared
    [InlineData(10, -1, 0.1)]       // Edge case: negative exponent (reciprocal)
    [InlineData(-2, 3, -8)]         // Edge case: negative base with odd exponent
    public void Exponent_VariousCases_ReturnsCorrectPower(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Exponent(a, b);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    #endregion

    #region Perform Method Tests

    /// <summary>
    /// Fact test: Verifies the Perform method routes to correct operation for addition.
    /// </summary>
    [Fact]
    public void Perform_AdditionOperator_CallsAddMethod()
    {
        // Arrange
        double a = 5;
        double b = 3;
        char op = '+';
        double expected = 8;

        // Act
        double result = CalculatorOperations.Perform(a, b, op);

        // Assert
        Assert.Equal(expected, result);
    }

    /// <summary>
    /// Theory test: Verifies Perform method with all supported operators.
    /// </summary>
    [Theory]
    [InlineData(10, 5, '+', 15)]    // Addition
    [InlineData(10, 5, '-', 5)]     // Subtraction
    [InlineData(10, 5, '*', 50)]    // Multiplication
    [InlineData(10, 5, '/', 2)]     // Division
    [InlineData(10, 3, '%', 1)]     // Modulo
    [InlineData(2, 3, '^', 8)]      // Exponent
    public void Perform_AllOperators_ReturnsCorrectResult(double a, double b, char op, double expected)
    {
        // Act
        double result = CalculatorOperations.Perform(a, b, op);

        // Assert
        Assert.Equal(expected, result, precision: 10);
    }

    /// <summary>
    /// Fact test: Verifies Perform method returns NaN for invalid operator.
    /// </summary>
    [Fact]
    public void Perform_InvalidOperator_ReturnsNaN()
    {
        // Arrange
        double a = 10;
        double b = 5;
        char op = '&';  // Invalid operator

        // Act
        double result = CalculatorOperations.Perform(a, b, op);

        // Assert
        Assert.True(double.IsNaN(result), "Invalid operator should return NaN");
    }

    #endregion
}