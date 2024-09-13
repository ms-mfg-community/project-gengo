using Arithmelon;
using Xunit;
namespace Arithmelon.xUnitArithmelonTests;

public class xUnitTests
{
    [Fact]
    public void Add()
    {
        // Arrange: Set up the inputs and the unit under test.
        double num1 = 5;
        double num2 = 10;
        double expected = 15;

        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Additionator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Fact]
    public void Subtract()
    {
        // Arrange: Set up the inputs and the unit under test.
        double num1 = 10;
        double num2 = 5;
        double expected = 5;

        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Subtractinator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Fact]
    public void Multiply()
    {
        // Arrange: Set up the inputs and the unit under test.
        double num1 = 5;
        double num2 = 10;
        double expected = 50;

        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Multiplicator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Fact]
    public void Divide()
    {
        // Arrange: Set up the inputs and the unit under test.
        double num1 = 10;
        double num2 = 5;
        double expected = 2;

        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Dividinator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Theory]
    [InlineData(5, 3, 8)]
    [InlineData(2, 2, 4)]
    [InlineData(8, 2, 10)]
    public void Add_WithInlineData(double num1, double num2, double expected)
    {
        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Additionator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Theory]
    [InlineData(10, 2, 8)]
    [InlineData(5, 3, 2)]
    [InlineData(100, 80, 20)]
    public void Subtract_WithInlineData(double num1, double num2, double expected)
    {
        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Subtractinator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Theory]
    [InlineData(5, 10, 50)]
    [InlineData(2, 5, 10)]
    [InlineData(8, 4, 32)]
    public void Multiply_WithInlineData(double num1, double num2, double expected)
    {
        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Multiplicator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Theory]
    [InlineData(10, 5, 2)]
    [InlineData(20, 4, 5)]
    [InlineData(100, 10, 10)]
    public void Divide_WithInlineData(double num1, double num2, double expected)
    {
        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Dividinator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }

    [Fact]
    public void Divide_WithFact()
    {
        // Arrange: Set up the inputs and the unit under test.
        double num1 = 20;
        double num2 = 4;
        double expected = 5;

        // Act: Execute the unit under test with the inputs.
        double actual = ArithmelonCS.Dividinator(num1, num2);

        // Assert: Check that the actual result matches the expected result.
        Assert.Equal(expected, actual, precision: 2);
    }
}
