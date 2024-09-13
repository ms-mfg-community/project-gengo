using Microsoft.VisualStudio.TestTools.UnitTesting;
using Arithmelon;

namespace ArithmelonTests
{
    [TestClass]
    public class ArithmelonTests
    {
        [DataTestMethod]
        [DataRow(5, 3, 8)]
        [DataRow(2, 2, 4)]
        [DataRow(-1, -1, -2)]
        public void TestAddition(double a, double b, double expected)
        {
            // Act
            double result = ArithmelonCS.Additionator(a, b);

            // Assert
            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void TestSubtraction()
        {
            // Arrange
            double a = 5;
            double b = 3;
            double expected = 2;

            // Act
            double result = ArithmelonCS.Subtractinator(a, b);

            // Assert
            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void TestMultiplication()
        {
            // Arrange
            double a = 5;
            double b = 3;
            double expected = 15;

            // Act
            double result = ArithmelonCS.Multiplicator(a,b);

            // Assert
            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void TestDivision()
        {
            // Arrange
            double a = 6;
            double b = 3;
            double expected = 2;

            // Act
            double result = ArithmelonCS.Dividinator(a, b);

            // Assert
            Assert.AreEqual(expected, result);
        }

    }
}