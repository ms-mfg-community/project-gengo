using Xunit;
using System;

public class CalculatorTest
{
    #region Addition Tests
    
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(5, 3);
        
        // Assert
        Assert.Equal(8, result);
    }
    
    [Fact]
    public void Add_WithNegativeNumber_ReturnsCorrectSum()
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(5, -3);
        
        // Assert
        Assert.Equal(2, result);
    }
    
    [Fact]
    public void Add_TwoNegativeNumbers_ReturnsCorrectSum()
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(-5, -3);
        
        // Assert
        Assert.Equal(-8, result);
    }
    
    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(1.5, 2.5, 4)]
    [InlineData(-1.5, 1.5, 0)]
    [InlineData(2, 3, 5)]
    [InlineData(3, 7, 10)]  
    public void Add_TheoryTest_ReturnsCorrectSum(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Add(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Subtraction Tests
    
    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        // Arrange & Act
        double result = CalculatorOperations.Subtract(5, 3);
        
        // Assert
        Assert.Equal(2, result);
    }
    
    [Fact]
    public void Subtract_WithNegativeNumber_ReturnsCorrectDifference()
    {
        // Arrange & Act
        double result = CalculatorOperations.Subtract(5, -3);
        
        // Assert
        Assert.Equal(8, result);
    }
    
    [Theory]
    [InlineData(5, 3, 2)]
    [InlineData(3, 5, -2)]
    [InlineData(0, 0, 0)]
    [InlineData(-5, -3, -2)]
    public void Subtract_TheoryTest_ReturnsCorrectDifference(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Subtract(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Multiplication Tests
    
    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        // Arrange & Act
        double result = CalculatorOperations.Multiply(5, 3);
        
        // Assert
        Assert.Equal(15, result);
    }
    
    [Fact]
    public void Multiply_WithZero_ReturnsZero()
    {
        // Arrange & Act
        double result = CalculatorOperations.Multiply(5, 0);
        
        // Assert
        Assert.Equal(0, result);
    }
    
    [Theory]
    [InlineData(5, 3, 15)]
    [InlineData(0, 5, 0)]
    [InlineData(-5, 3, -15)]
    [InlineData(-5, -3, 15)]
    public void Multiply_TheoryTest_ReturnsCorrectProduct(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Multiply(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Division Tests
    
    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        // Arrange & Act
        double result = CalculatorOperations.Divide(6, 3);
        
        // Assert
        Assert.Equal(2, result);
    }
    
    [Fact]
    public void Divide_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange, Act & Assert
        Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Divide(5, 0));
    }
    
    [Theory]
    [InlineData(6, 3, 2)]
    [InlineData(0, 5, 0)]
    [InlineData(-6, 3, -2)]
    [InlineData(-6, -3, 2)]
    public void Divide_TheoryTest_ReturnsCorrectQuotient(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Divide(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Modulo Tests
    
    [Fact]
    public void Modulo_PositiveNumbers_ReturnsCorrectRemainder()
    {
        // Arrange & Act
        double result = CalculatorOperations.Modulo(7, 3);
        
        // Assert
        Assert.Equal(1, result);
    }
    
    [Fact]
    public void Modulo_ByZero_ThrowsDivideByZeroException()
    {
        // Arrange, Act & Assert
        Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Modulo(5, 0));
    }
    
    [Theory]
    [InlineData(7, 3, 1)]
    [InlineData(8, 4, 0)]
    [InlineData(-7, 3, -1)]
    [InlineData(7, -3, 1)]
    public void Modulo_TheoryTest_ReturnsCorrectRemainder(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Modulo(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
    
    #region Power Tests
    
    [Fact]
    public void Power_PositiveNumberAndPositiveExponent_ReturnsCorrectResult()
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(2, 3);
        
        // Assert
        Assert.Equal(8, result);
    }
    
    [Fact]
    public void Power_NumberToZeroPower_ReturnsOne()
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(5, 0);
        
        // Assert
        Assert.Equal(1, result);
    }
    
    [Fact]
    public void Power_ZeroToPositivePower_ReturnsZero()
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(0, 5);
        
        // Assert
        Assert.Equal(0, result);
    }
    
    [Theory]
    [InlineData(2, 3, 8)]
    [InlineData(3, 2, 9)]
    [InlineData(2, 0, 1)]
    [InlineData(0, 5, 0)]
    public void Power_TheoryTest_ReturnsCorrectResult(double a, double b, double expected)
    {
        // Arrange & Act
        double result = CalculatorOperations.Power(a, b);
        
        // Assert
        Assert.Equal(expected, result);
    }
    
    #endregion
}