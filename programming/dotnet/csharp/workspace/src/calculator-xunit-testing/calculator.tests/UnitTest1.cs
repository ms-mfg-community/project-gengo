// FILE: calculator.tests/OperationsTests.cs
using Xunit;
using Calculator;

namespace calculator.tests
{
    public class OperationsTests
    {
        [Fact]
        public void Add_ReturnsCorrectSum()
        {
            double result = Operations.Add(2, 3);
            Assert.Equal(5, result);
        }

        [Fact]
        public void Subtract_ReturnsCorrectDifference()
        {
            double result = Operations.Subtract(5, 3);
            Assert.Equal(2, result);
        }

        [Fact]
        public void Multiply_ReturnsCorrectProduct()
        {
            double result = Operations.Multiply(2, 3);
            Assert.Equal(6, result);
        }

        [Fact]
        public void Divide_ReturnsCorrectQuotient()
        {
            double result = Operations.Divide(6, 3);
            Assert.Equal(2, result);
        }

        [Fact]
        public void Divide_ByZero_ThrowsDivideByZeroException()
        {
            Assert.Throws<DivideByZeroException>(() => Operations.Divide(6, 0));
        }
    }
}