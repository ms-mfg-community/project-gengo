using Xunit;
using System;

/// <summary>
/// Test class for CalculatorOperations.
/// Contains unit tests that verify the behavior of all calculator operations
/// including normal cases, edge cases, and exception scenarios.
/// </summary>
public class CalculatorTest
{
    #region Addition Tests
    
    /// <summary>
    /// Tests addition of two positive numbers.
    /// Verifies the basic addition functionality.
    /// </summary>
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(5, 3);
        
        // Assert
        Assert.Equal(8, result);
    }
    
    /// <summary>
    /// Tests addition with a negative number.
    /// Verifies that the calculator correctly handles negative values.
    /// </summary>
    [Fact]
    public void Add_WithNegativeNumber_ReturnsCorrectSum()
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(5, -3);
        
        // Assert
        Assert.Equal(2, result);
    }
    
    /// <summary>
    /// Tests addition of two negative numbers.
    /// Verifies that the calculator handles the case where both inputs are negative.
    /// </summary>
    [Fact]
    public void Add_TwoNegativeNumbers_ReturnsCorrectSum()
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(-5, -3);
        
        // Assert
        Assert.Equal(-8, result);
    }
    
    /// <summary>
    /// Tests addition using theory with multiple test cases.
    /// Uses xUnit's Theory attribute to run the same test with different inputs.
    /// </summary>
    /// <param name="a">First number</param>
    /// <param name="b">Second number</param>
    /// <param name="expected">Expected sum</param>
    [Theory]
    [InlineData(0, 0, 0)]        // Adding zeros
    [InlineData(1.5, 2.5, 4)]    // Adding decimal numbers
    [InlineData(-1.5, 1.5, 0)]   // Adding negative and positive for zero sum
    [InlineData(2, 3, 5)]        // Simple positive addition
    [InlineData(3, 7, 10)]       // Another simple positive addition
    public void Add_TheoryTest_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Subtraction Tests
    
    /// <summary>
    /// Tests subtraction of two positive numbers.
    /// Verifies the basic subtraction functionality with positive result.
    /// </summary>
    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange & Act
        double result = CalculatorOperations.Subtract(5, 3);
        
        // Assert
        Assert.Equal(2, result);
    }
    
    /// <summary>
    /// Tests subtraction with a negative number.
    /// Verifies that subtracting a negative is equivalent to addition.
    /// </summary>
    [Fact]
    public void Subtract_WithNegativeNumber_ReturnsCorrectDifference()
    {
        // Arrange & Act
        double result = CalculatorOperations.Subtract(5, -3);
        
        // Assert
        Assert.Equal(8, result);
    }
    
    /// <summary>
    /// Tests subtraction using theory with multiple test cases.
    /// Includes cases for positive, negative, and zero inputs.
    /// </summary>
    /// <param name="a">First number</param>
    /// <param name="b">Number to subtract</param>
    /// <param name="expected">Expected difference</param>
    [Theory]
    [InlineData(5, 3, 2)]        // Basic subtraction with positive result
    [InlineData(3, 5, -2)]       // Subtraction resulting in negative
    [InlineData(0, 0, 0)]        // Zero case
    [InlineData(-5, -3, -2)]     // Negative numbers
    public void Subtract_TheoryTest_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Subtract(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Multiplication Tests
    
    /// <summary>
    /// Tests multiplication of two positive numbers.
    /// Verifies the basic multiplication functionality.
    /// </summary>
    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange & Act
        double result = CalculatorOperations.Multiply(5, 3);
        
        // Assert
        Assert.Equal(15, result);
    }
    
    /// <summary>
    /// Tests multiplication with zero.
    /// Verifies that multiplying any number by zero results in zero.
    /// </summary>
    [Fact]
    public void Multiply_WithZero_ReturnsZero()
    {
        // Arrange & Act
        double result = CalculatorOperations.Multiply(5, 0);
        
        // Assert
        Assert.Equal(0, result);
    }
    
    /// <summary>
    /// Tests multiplication using theory with multiple test cases.
    /// Includes cases for zero, negative numbers, and sign rules.
    /// </summary>
    /// <param name="a">First factor</param>
    /// <param name="b">Second factor</param>
    /// <param name="expected">Expected product</param>
    [Theory]
    [InlineData(5, 3, 15)]       // Basic positive multiplication
    [InlineData(0, 5, 0)]        // Zero times any number equals zero
    [InlineData(-5, 3, -15)]     // Negative * positive equals negative
    [InlineData(-5, -3, 15)]     // Negative * negative equals positive
    public void Multiply_TheoryTest_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Multiply(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Division Tests
    
    /// <summary>
    /// Tests division of two positive numbers.
    /// Verifies the basic division functionality.
    /// </summary>
    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange & Act
        double result = CalculatorOperations.Divide(6, 3);
        
        // Assert
        Assert.Equal(2, result);
    }
    
    /// <summary>
    /// Tests division by zero.
    /// Verifies that attempting to divide by zero throws the expected exception.
    /// </summary>
    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange, Act & Assert
        // This test passes if the code throws a DivideByZeroException
        Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Divide(5, 0));
    }
    
    /// <summary>
    /// Tests division using theory with multiple test cases.
    /// Includes cases for zero numerator, negative numbers, and sign rules.
    /// </summary>
    /// <param name="a">Numerator</param>
    /// <param name="b">Denominator</param>
    /// <param name="expected">Expected quotient</param>
    [Theory]
    [InlineData(6, 3, 2)]        // Basic division
    [InlineData(0, 5, 0)]        // Zero divided by any non-zero number equals zero
    [InlineData(-6, 3, -2)]      // Negative divided by positive equals negative
    [InlineData(-6, -3, 2)]      // Negative divided by negative equals positive
    public void Divide_TheoryTest_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Divide(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Modulo Tests
    
    /// <summary>
    /// Tests modulo operation with positive numbers.
    /// Verifies that the remainder is correctly calculated.
    /// </summary>
    [Fact]
    public void Modulo_PositiveNumbers_ReturnsCorrectRemainder()
    {
        // Arrange & Act
        double result = CalculatorOperations.Modulo(7, 3);
        
        // Assert
        Assert.Equal(1, result);
    }
    
    /// <summary>
    /// Tests modulo by zero.
    /// Verifies that attempting modulo with zero divisor throws the expected exception.
    /// </summary>
    [Fact]
    public void Modulo_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange, Act & Assert
        // This test passes if the code throws a DivideByZeroException
        Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Modulo(5, 0));
    }
    
    /// <summary>
    /// Tests modulo using theory with multiple test cases.
    /// Tests remainder calculations with different values including negative numbers.
    /// </summary>
    /// <param name="a">Dividend</param>
    /// <param name="b">Divisor</param>
    /// <param name="expected">Expected remainder</param>
    /// <remarks>
    /// In C#, the modulo of negative numbers follows the sign of the dividend:
    /// -7 % 3 = -1, which differs from some other languages.
    /// </remarks>
    [Theory]
    [InlineData(7, 3, 1)]        // Basic modulo with remainder
    [InlineData(8, 4, 0)]        // Modulo with no remainder
    [InlineData(-7, 3, -1)]      // Negative dividend follows C#'s rule (keeps sign of dividend)
    [InlineData(7, -3, 1)]       // Negative divisor follows C#'s rule
    public void Modulo_TheoryTest_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Modulo(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Power Tests
    
    /// <summary>
    /// Tests power operation with positive base and positive exponent.
    /// Verifies the basic power functionality.
    /// </summary>
    [Fact]
    public void Power_PositiveNumberAndPositiveExponent_ReturnsCorrectResult()
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(2, 3);
        
        // Assert
        Assert.Equal(8, result);
    }
    
    /// <summary>
    /// Tests raising a number to the power of zero.
    /// Verifies that any number raised to the power of zero equals 1.
    /// </summary>
    [Fact]
    public void Power_NumberToZeroPower_ReturnsOne()
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(5, 0);
        
        // Assert
        Assert.Equal(1, result);
    }
    
    /// <summary>
    /// Tests raising zero to a positive power.
    /// Verifies that zero raised to any positive power equals 0.
    /// </summary>
    [Fact]
    public void Power_ZeroToPositivePower_ReturnsZero()
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(0, 5);
        
        // Assert
        Assert.Equal(0, result);
    }
    
    /// <summary>
    /// Tests power operation using theory with multiple test cases.
    /// Covers various combinations including the special cases of 0^0 and x^0.
    /// </summary>
    /// <param name="a">Base</param>
    /// <param name="b">Exponent</param>
    /// <param name="expected">Expected result</param>
    /// <remarks>
    /// Special cases:
    /// - 0^0 = 1 (mathematical convention)
    /// - x^0 = 1 for any x
    /// - 0^y = 0 for any positive y
    /// </remarks>
    [Theory]
    [InlineData(2, 3, 8)]        // Basic power operation
    [InlineData(3, 2, 9)]        // Another basic power operation
    [InlineData(2, 0, 1)]        // Any number raised to power 0 equals 1
    [InlineData(0, 5, 0)]        // Zero raised to positive power equals 0
    public void Power_TheoryTest_ReturnsCorrectResult(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
}