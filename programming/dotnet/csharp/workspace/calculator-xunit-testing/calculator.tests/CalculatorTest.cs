using Xunit;

namespace calculator.tests
{
    // Unit tests for CalculatorOperations
    public class CalculatorOperationsTests
    {
        // Test addition for various cases including positive, negative, and zero
        [Theory]
        [InlineData(2, 3, 5)]
        [InlineData(-1, 1, 0)]
        [InlineData(0, 0, 0)]
        public void Add_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Add(a, b));
        }

        // Test subtraction for various cases including negative results
        [Theory]
        [InlineData(5, 3, 2)]
        [InlineData(0, 1, -1)]
        [InlineData(-2, -2, 0)]
        public void Subtract_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Subtract(a, b));
        }

        // Test multiplication for positive, negative, and zero operands
        [Theory]
        [InlineData(2, 3, 6)]
        [InlineData(-2, 2, -4)]
        [InlineData(0, 5, 0)]
        public void Multiply_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Multiply(a, b));
        }

        // Test division for normal cases (non-zero divisor)
        [Theory]
        [InlineData(6, 3, 2)]
        [InlineData(-4, 2, -2)]
        [InlineData(5, 2, 2.5)]
        public void Divide_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Divide(a, b));
        }

        // Test division by zero throws the correct exception
        [Fact]
        public void Divide_ByZero_Throws()
        {
            Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Divide(1, 0));
        }

        // Test modulo for various cases, including negative and zero results
        [Theory]
        [InlineData(7, 3, 1)]
        [InlineData(10, 2, 0)]
        [InlineData(-5, 2, -1)]
        public void Modulo_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Modulo(a, b));
        }

        // Test modulo by zero throws the correct exception
        [Fact]
        public void Modulo_ByZero_Throws()
        {
            Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Modulo(1, 0));
        }

        // Test exponentiation for integer and fractional exponents
        [Theory]
        [InlineData(2, 3, 8)] // 2^3 = 8
        [InlineData(4, 0.5, 2)] // sqrt(4) = 2
        [InlineData(9, 0.5, 3)] // sqrt(9) = 3
        public void Exponent_ReturnsExpected(double a, double b, double expected)
        {
            // Use precision of 5 digits for floating point comparison
            Assert.Equal(expected, CalculatorOperations.Exponent(a, b), 5);
        }
    }
}