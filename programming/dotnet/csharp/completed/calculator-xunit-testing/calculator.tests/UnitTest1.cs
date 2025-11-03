namespace calculator.tests;

public class UnitTest1
{
    [Fact]
    public void TestAddition()
    {
        double result = Calculator.Program.Add(5, 3);
        Assert.Equal(8, result);
    }

    [Fact]
    public void TestSubtraction()
    {
        double result = Calculator.Program.Subtract(5, 3);
        Assert.Equal(2, result);
    }

    [Fact]
    public void TestMultiplication()
    {
        double result = Calculator.Program.Multiply(5, 3);
        Assert.Equal(15, result);
    }

    [Fact]
    public void TestDivision()
    {
        double result = Calculator.Program.Divide(6, 3);
        Assert.Equal(2, result);
    }

    [Fact]
    public void TestDivisionByZero()
    {
        Assert.Throws<DivideByZeroException>(() => Calculator.Program.Divide(6, 0));
    }
}
