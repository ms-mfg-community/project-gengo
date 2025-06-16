using Xunit;

namespace calculator.tests
{
    public class CalculatorOperationsTests
    {
        [Theory]
        [InlineData(2, 3, 5)]
        [InlineData(-1, 1, 0)]
        [InlineData(0, 0, 0)]
        public void Add_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Add(a, b));
        }

        [Theory]
        [InlineData(5, 3, 2)]
        [InlineData(0, 1, -1)]
        [InlineData(-2, -2, 0)]
        public void Subtract_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Subtract(a, b));
        }

        [Theory]
        [InlineData(2, 3, 6)]
        [InlineData(-2, 2, -4)]
        [InlineData(0, 5, 0)]
        public void Multiply_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Multiply(a, b));
        }

        [Theory]
        [InlineData(6, 3, 2)]
        [InlineData(-4, 2, -2)]
        [InlineData(5, 2, 2.5)]
        public void Divide_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Divide(a, b));
        }

        [Fact]
        public void Divide_ByZero_Throws()
        {
            Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Divide(1, 0));
        }

        [Theory]
        [InlineData(7, 3, 1)]
        [InlineData(10, 2, 0)]
        [InlineData(-5, 2, -1)]
        public void Modulo_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Modulo(a, b));
        }

        [Fact]
        public void Modulo_ByZero_Throws()
        {
            Assert.Throws<DivideByZeroException>(() => CalculatorOperations.Modulo(1, 0));
        }

        [Theory]
        [InlineData(2, 3, 8)]
        [InlineData(4, 0.5, 2)]
        [InlineData(9, 0.5, 3)]
        public void Exponent_ReturnsExpected(double a, double b, double expected)
        {
            Assert.Equal(expected, CalculatorOperations.Exponent(a, b), 5); // 5 digits precision
        }
    }
}