using System;
using Xunit;

namespace calculator.tests
{
    public class CalculatorTest
    {
        [Fact]
        public void TestAddition()
        {
            double result = Add(5, 3);
            Assert.Equal(8, result);
        }

        [Fact]
        public void TestSubtraction()
        {
            double result = Subtract(5, 3);
            Assert.Equal(2, result);
        }

        [Fact]
        public void TestMultiplication()
        {
            double result = Multiply(5, 3);
            Assert.Equal(15, result);
        }

        [Fact]
        public void TestDivision()
        {
            double result = Divide(6, 3);
            Assert.Equal(2, result);
        }

        [Fact]
        public void TestDivisionByZero()
        {
            Assert.Throws<DivideByZeroException>(() => Divide(6, 0));
        }

        [Fact]
        public void TestModulo()
        {
            double result = Modulo(10, 3);
            Assert.Equal(1, result);
        }

        [Fact]
        public void TestExponent()
        {
            double result = Exponent(2, 3);
            Assert.Equal(8, result);
        }

        private double Add(double a, double b) => a + b;
        private double Subtract(double a, double b) => a - b;
        private double Multiply(double a, double b) => a * b;
        private double Divide(double a, double b)
        {
            if (b == 0) throw new DivideByZeroException();
            return a / b;
        }
        private double Modulo(double a, double b) => a % b;
        private double Exponent(double a, double b) => Math.Pow(a, b);
    }
}
