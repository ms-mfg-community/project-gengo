using Arithmelon;
using Xunit;
namespace xUnitArithmelonTests;

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
        Assert.Equal(expected, actual);
    }
}