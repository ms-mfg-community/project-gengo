using System;
using Xunit;

namespace calculator.tests
{
    /// <summary>
    /// Unit tests for the CalculatorOperations class
    /// Tests all arithmetic operations including edge cases and error conditions
    /// </summary>
    public class CalculatorOperationsTests
    {
        private readonly CalculatorOperations _calculator;

        public CalculatorOperationsTests()
        {
            _calculator = new CalculatorOperations();
        }

        #region Addition Tests

        [Fact]
        public void Add_PositiveNumbers_ReturnsCorrectSum()
        {
            // Arrange
            double a = 5.5;
            double b = 3.2;
            double expected = 8.7;

            // Act
            double result = _calculator.Add(a, b);

            // Assert
            Assert.Equal(expected, result, precision: 10);
        }

        [Fact]
        public void Add_NegativeNumbers_ReturnsCorrectSum()
        {
            // Arrange
            double a = -10.5;
            double b = -4.3;
            double expected = -14.8;

            // Act
            double result = _calculator.Add(a, b);

            // Assert
            Assert.Equal(expected, result, precision: 10);
        }

        [Fact]
        public void Add_PositiveAndNegativeNumbers_ReturnsCorrectSum()
        {
            // Arrange
            double a = 15.7;
            double b = -8.2;
            double expected = 7.5;

            // Act
            double result = _calculator.Add(a, b);

            // Assert
            Assert.Equal(expected, result, precision: 10);
        }

        [Fact]
        public void Add_ZeroAndPositiveNumber_ReturnsPositiveNumber()
        {
            // Arrange
            double a = 0;
            double b = 42.5;
            double expected = 42.5;

            // Act
            double result = _calculator.Add(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion

        #region Subtraction Tests

        [Fact]
        public void Subtract_PositiveNumbers_ReturnsCorrectDifference()
        {
            // Arrange
            double a = 10.5;
            double b = 3.2;
            double expected = 7.3;

            // Act
            double result = _calculator.Subtract(a, b);

            // Assert
            Assert.Equal(expected, result, precision: 10);
        }

        [Fact] 
        public void Subtract_NegativeNumbers_ReturnsCorrectDifference()
        {
            // Arrange
            double a = -5.5;
            double b = -2.3;
            double expected = -3.2;

            // Act
            double result = _calculator.Subtract(a, b);

            // Assert
            Assert.Equal(expected, result, precision: 10);
        }

        [Fact]
        public void Subtract_FromZero_ReturnsNegativeNumber()
        {
            // Arrange
            double a = 0;
            double b = 7.5;
            double expected = -7.5;

            // Act
            double result = _calculator.Subtract(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Subtract_SameNumbers_ReturnsZero()
        {
            // Arrange
            double a = 15.7;
            double b = 15.7;
            double expected = 0;

            // Act
            double result = _calculator.Subtract(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion

        #region Multiplication Tests

        [Fact]
        public void Multiply_PositiveNumbers_ReturnsCorrectProduct()
        {
            // Arrange
            double a = 4.5;
            double b = 2.0;
            double expected = 9.0;

            // Act
            double result = _calculator.Multiply(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Multiply_NegativeNumbers_ReturnsPositiveProduct()
        {
            // Arrange
            double a = -3.0;
            double b = -4.0;
            double expected = 12.0;

            // Act
            double result = _calculator.Multiply(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Multiply_PositiveAndNegativeNumbers_ReturnsNegativeProduct()
        {
            // Arrange
            double a = 6.0;
            double b = -2.5;
            double expected = -15.0;

            // Act
            double result = _calculator.Multiply(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Multiply_ByZero_ReturnsZero()
        {
            // Arrange
            double a = 42.7;
            double b = 0;
            double expected = 0;

            // Act
            double result = _calculator.Multiply(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Multiply_ByOne_ReturnsOriginalNumber()
        {
            // Arrange
            double a = 25.3;
            double b = 1;
            double expected = 25.3;

            // Act
            double result = _calculator.Multiply(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion

        #region Division Tests

        [Fact]
        public void Divide_PositiveNumbers_ReturnsCorrectQuotient()
        {
            // Arrange
            double a = 15.0;
            double b = 3.0;
            double expected = 5.0;

            // Act
            double result = _calculator.Divide(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Divide_NegativeNumbers_ReturnsPositiveQuotient()
        {
            // Arrange
            double a = -20.0;
            double b = -4.0;
            double expected = 5.0;

            // Act
            double result = _calculator.Divide(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Divide_PositiveByNegative_ReturnsNegativeQuotient()
        {
            // Arrange
            double a = 12.0;
            double b = -3.0;
            double expected = -4.0;

            // Act
            double result = _calculator.Divide(a, b);

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
            var exception = Assert.Throws<DivideByZeroException>(() => _calculator.Divide(a, b));
            Assert.Equal("Cannot divide by zero", exception.Message);
        }

        [Fact]
        public void Divide_ZeroByNonZero_ReturnsZero()
        {
            // Arrange
            double a = 0.0;
            double b = 5.0;
            double expected = 0.0;

            // Act
            double result = _calculator.Divide(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Divide_ByOne_ReturnsOriginalNumber()
        {
            // Arrange
            double a = 42.5;
            double b = 1.0;
            double expected = 42.5;

            // Act
            double result = _calculator.Divide(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion

        #region Modulo Tests

        [Fact]
        public void Modulo_PositiveNumbers_ReturnsCorrectRemainder()
        {
            // Arrange
            double a = 17.0;
            double b = 5.0;
            double expected = 2.0;

            // Act
            double result = _calculator.Modulo(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Modulo_NegativeNumbers_ReturnsCorrectRemainder()
        {
            // Arrange
            double a = -17.0;
            double b = -5.0;
            double expected = -2.0;

            // Act
            double result = _calculator.Modulo(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Modulo_MixedSigns_ReturnsCorrectRemainder()
        {
            // Arrange
            double a = 17.0;
            double b = -5.0;
            double expected = 2.0;

            // Act
            double result = _calculator.Modulo(a, b);

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
            var exception = Assert.Throws<DivideByZeroException>(() => _calculator.Modulo(a, b));
            Assert.Equal("Cannot perform modulo with zero divisor", exception.Message);
        }

        [Fact]
        public void Modulo_ZeroByNonZero_ReturnsZero()
        {
            // Arrange
            double a = 0.0;
            double b = 5.0;
            double expected = 0.0;

            // Act
            double result = _calculator.Modulo(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Modulo_EqualNumbers_ReturnsZero()
        {
            // Arrange
            double a = 7.0;
            double b = 7.0;
            double expected = 0.0;

            // Act
            double result = _calculator.Modulo(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion

        #region Power Tests

        [Fact]
        public void Power_PositiveBasePositiveExponent_ReturnsCorrectResult()
        {
            // Arrange
            double baseNumber = 2.0;
            double exponent = 3.0;
            double expected = 8.0;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_PositiveBaseNegativeExponent_ReturnsCorrectResult()
        {
            // Arrange
            double baseNumber = 2.0;
            double exponent = -3.0;
            double expected = 0.125;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_NegativeBaseEvenExponent_ReturnsPositiveResult()
        {
            // Arrange
            double baseNumber = -3.0;
            double exponent = 2.0;
            double expected = 9.0;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_NegativeBaseOddExponent_ReturnsNegativeResult()
        {
            // Arrange
            double baseNumber = -2.0;
            double exponent = 3.0;
            double expected = -8.0;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_AnyNumberToZero_ReturnsOne()
        {
            // Arrange
            double baseNumber = 42.0;
            double exponent = 0.0;
            double expected = 1.0;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_ZeroToPositiveExponent_ReturnsZero()
        {
            // Arrange
            double baseNumber = 0.0;
            double exponent = 5.0;
            double expected = 0.0;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_OneToAnyExponent_ReturnsOne()
        {
            // Arrange
            double baseNumber = 1.0;
            double exponent = 100.0;
            double expected = 1.0;

            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        [Fact]
        public void Power_LargeExponent_ThrowsArgumentOutOfRangeException()
        {
            // Arrange
            double baseNumber = 10.0;
            double exponent = 1000.0;

            // Act & Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => _calculator.Power(baseNumber, exponent));
        }

        [Fact]
        public void Power_NegativeBaseDecimalExponent_ThrowsArgumentOutOfRangeException()
        {
            // Arrange
            double baseNumber = -4.0;
            double exponent = 0.5; // Square root of negative number results in NaN

            // Act & Assert
            Assert.Throws<ArgumentOutOfRangeException>(() => _calculator.Power(baseNumber, exponent));
        }

        [Theory]
        [InlineData(5.0, 2.0, 25.0)]
        [InlineData(3.0, 4.0, 81.0)]
        [InlineData(10.0, 0.0, 1.0)]
        [InlineData(2.0, -2.0, 0.25)]
        public void Power_VariousInputs_ReturnsExpectedResults(double baseNumber, double exponent, double expected)
        {
            // Act
            double result = _calculator.Power(baseNumber, exponent);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion

        #region Theory Tests for Multiple Scenarios

        [Theory]
        [InlineData(1.0, 2.0, 3.0)]
        [InlineData(-1.0, -2.0, -3.0)]
        [InlineData(0.0, 0.0, 0.0)]
        [InlineData(10.5, 5.5, 16.0)]
        [InlineData(-10.0, 15.0, 5.0)]
        public void Add_MultipleScenarios_ReturnsExpectedResults(double a, double b, double expected)
        {
            // Act
            double result = _calculator.Add(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Theory]
        [InlineData(10.0, 3.0, 5.0)]
        [InlineData(0.0, 5.0, -5.0)]
        [InlineData(-10.0, -5.0, -5.0)]
        [InlineData(15.5, 10.5, 5.0)]
        public void Subtract_MultipleScenarios_ReturnsExpectedResults(double a, double b, double expected)
        {
            // Act
            double result = _calculator.Subtract(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Theory]
        [InlineData(2.0, 3.0, 6.0)]
        [InlineData(-2.0, 3.0, -6.0)]
        [InlineData(-2.0, -3.0, 6.0)]
        [InlineData(0.0, 5.0, 0.0)]
        [InlineData(1.0, 100.0, 100.0)]
        public void Multiply_MultipleScenarios_ReturnsExpectedResults(double a, double b, double expected)
        {
            // Act
            double result = _calculator.Multiply(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        [Theory]
        [InlineData(10.0, 2.0, 5.0)]
        [InlineData(-10.0, 2.0, -5.0)]
        [InlineData(-10.0, -2.0, 5.0)]
        [InlineData(0.0, 5.0, 0.0)]
        [InlineData(25.0, 5.0, 5.0)]
        public void Divide_MultipleScenarios_ReturnsExpectedResults(double a, double b, double expected)
        {
            // Act
            double result = _calculator.Divide(a, b);

            // Assert
            Assert.Equal(expected, result);
        }

        #endregion
    }
}