using Microsoft.VisualStudio.TestTools.UnitTesting;

[TestClass]
public class CalculonTests
{
    private readonly Calculon _calculon = new Calculon();

    [TestMethod]
    public void Add_ReturnsCorrectResult()
    {
        double result = _calculon.Add(2, 3);
        Assert.AreEqual(5, result);
    }

    [TestMethod]
    public void Subtract_ReturnsCorrectResult()
    {
        double result = _calculon.Subtract(5, 3);
        Assert.AreEqual(2, result);
    }

    [TestMethod]
    public void Multiply_ReturnsCorrectResult()
    {
        double result = _calculon.Multiply(2, 3);
        Assert.AreEqual(6, result);
    }

    [TestMethod]
    public void Divide_ReturnsCorrectResult()
    {
        double result = _calculon.Divide(6, 3);
        Assert.AreEqual(2, result);
    }

    [TestMethod]
    public void Calculate_Addition_ReturnsCorrectResult()
    {
        double result = _calculon.Calculate(2, 3, '+');
        Assert.AreEqual(5, result);
    }

    [TestMethod]
    public void Calculate_Subtraction_ReturnsCorrectResult()
    {
        double result = _calculon.Calculate(5, 3, '-');
        Assert.AreEqual(2, result);
    }

    [TestMethod]
    public void Calculate_Multiplication_ReturnsCorrectResult()
    {
        double result = _calculon.Calculate(2, 3, '*');
        Assert.AreEqual(6, result);
    }

    [TestMethod]
    public void Calculate_Division_ReturnsCorrectResult()
    {
        double result = _calculon.Calculate(6, 3, '/');
        Assert.AreEqual(2, result);
    }

    [TestMethod]
    [ExpectedException(typeof(InvalidOperationException))]
    public void Calculate_InvalidOperator_ThrowsInvalidOperationException()
    {
        _calculon.Calculate(2, 3, '%');
    }
}
