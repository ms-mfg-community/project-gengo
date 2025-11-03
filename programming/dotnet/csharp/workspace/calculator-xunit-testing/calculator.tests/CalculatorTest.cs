namespace calculator.tests;

/// <summary>
/// Comprehensive xUnit tests for Calculator operations
/// Demonstrates Fact and Theory test approaches with multiple test cases
/// </summary>
public class CalculatorTest
{
    #region Addition Tests
    
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = 5.0;
        double b = 3.0;
        double expected = 8.0;
        
        // Act
        double result = CalculatorOperations.Add(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Theory]
    [InlineData(10, 5, 15)]
    [InlineData(-5, -3, -8)]
    [InlineData(0, 0, 0)]
    [InlineData(100.5, 200.5, 301.0)]
    [InlineData(-10, 10, 0)]
    public void Add_VariousInputs_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Add(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Subtraction Tests
    
    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange
        double a = 10.0;
        double b = 3.0;
        double expected = 7.0;
        
        // Act
        double result = CalculatorOperations.Subtract(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Theory]
    [InlineData(15, 5, 10)]
    [InlineData(-5, -3, -2)]
    [InlineData(0, 0, 0)]
    [InlineData(100.5, 50.5, 50.0)]
    [InlineData(5, 10, -5)]
    public void Subtract_VariousInputs_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Subtract(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Multiplication Tests
    
    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange
        double a = 4.0;
        double b = 5.0;
        double expected = 20.0;
        
        // Act
        double result = CalculatorOperations.Multiply(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Theory]
    [InlineData(6, 7, 42)]
    [InlineData(-3, 4, -12)]
    [InlineData(-2, -5, 10)]
    [InlineData(0, 100, 0)]
    [InlineData(2.5, 4, 10.0)]
    [InlineData(1.5, 2.5, 3.75)]
    public void Multiply_VariousInputs_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Multiply(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Division Tests
    
    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange
        double a = 20.0;
        double b = 4.0;
        double expected = 5.0;
        
        // Act
        double result = CalculatorOperations.Divide(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Theory]
    [InlineData(100, 10, 10)]
    [InlineData(-20, 4, -5)]
    [InlineData(-15, -3, 5)]
    [InlineData(7.5, 2.5, 3.0)]
    [InlineData(1, 2, 0.5)]
    public void Divide_VariousInputs_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Divide(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double a = 10.0;
        double b = 0.0;
        
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Divide(a, b));
    }
    
    [Theory]
    [InlineData(5, 0)]
    [InlineData(-10, 0)]
    [InlineData(0, 0)]
    public void Divide_ByZero_ThrowsException(double a, double b)
    {
        // Act & Assert
        var exception = Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Divide(a, b));
        Assert.Equal("Cannot divide by zero.", exception.Message);
    }
    
    #endregion
    
    #region Modulo Tests
    
    [Fact]
    public void Modulo_TwoPositiveNumbers_ReturnsCorrectRemainder()
    {
        // Arrange
        double a = 10.0;
        double b = 3.0;
        double expected = 1.0;
        
        // Act
        double result = CalculatorOperations.Modulo(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Theory]
    [InlineData(17, 5, 2)]
    [InlineData(20, 4, 0)]
    [InlineData(7, 3, 1)]
    [InlineData(100, 30, 10)]
    [InlineData(15.5, 4, 3.5)]
    public void Modulo_VariousInputs_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Modulo(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Fact]
    public void Modulo_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange
        double a = 10.0;
        double b = 0.0;
        
        // Act & Assert
        Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Modulo(a, b));
    }
    
    [Theory]
    [InlineData(8, 0)]
    [InlineData(-5, 0)]
    [InlineData(0, 0)]
    public void Modulo_ByZero_ThrowsException(double a, double b)
    {
        // Act & Assert
        var exception = Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Modulo(a, b));
        Assert.Equal("Cannot perform modulo by zero.", exception.Message);
    }
    
    #endregion
    
    #region Exponent Tests
    
    [Fact]
    public void Exponent_BaseAndPositiveExponent_ReturnsCorrectPower()
    {
        // Arrange
        double a = 2.0;
        double b = 3.0;
        double expected = 8.0;
        
        // Act
        double result = CalculatorOperations.Exponent(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    [Theory]
    [InlineData(2, 0, 1)]        // Any number to power 0 equals 1
    [InlineData(5, 2, 25)]       // Positive base, positive exponent
    [InlineData(10, 3, 1000)]    // Base 10
    [InlineData(3, 4, 81)]       // 3^4
    [InlineData(2, -2, 0.25)]    // Negative exponent
    [InlineData(4, 0.5, 2)]      // Fractional exponent (square root)
    public void Exponent_VariousInputs_ReturnsCorrectPower(double a, double b, double expected)
    {
        // Act
        double result = CalculatorOperations.Exponent(a, b);
        
        // Assert
        Assert.Equal(expected, result, 10); // Allow small floating point differences
    }
    
    #endregion
    
    #region Edge Case Tests
    
    [Fact]
    public void Add_LargeNumbers_ReturnsCorrectSum()
    {
        // Arrange
        double a = double.MaxValue / 2;
        double b = double.MaxValue / 4;
        
        // Act
        double result = CalculatorOperations.Add(a, b);
        
        // Assert
        Assert.True(result > 0);
    }
    
    [Fact]
    public void Multiply_ByZero_ReturnsZero()
    {
        // Arrange
        double a = 123.456;
        double b = 0.0;
        
        // Act
        double result = CalculatorOperations.Multiply(a, b);
        
        // Assert
        Assert.Equal(0.0, result);
    }
    
    [Fact]
    public void Subtract_SameNumbers_ReturnsZero()
    {
        // Arrange
        double a = 42.0;
        double b = 42.0;
        
        // Act
        double result = CalculatorOperations.Subtract(a, b);
        
        // Assert
        Assert.Equal(0.0, result);
    }
    
    #endregion
}
