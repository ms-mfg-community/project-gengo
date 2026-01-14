using Xunit;

public class CalculatorTest
{
    private readonly Calculator _calculator = new Calculator();

    #region Addition Tests
    [Fact]
    public void Add_TwoPositiveNumbers_ReturnsCorrectSum()
    {
        double result = _calculator.Add(5, 3);
        Assert.Equal(8, result);
    }

    [Theory]
    [InlineData(10, 5, 15)]
    [InlineData(-5, 3, -2)]
    [InlineData(0, 0, 0)]
    [InlineData(2.5, 3.5, 6)]
    public void Add_MultipleScenarios_ReturnsCorrectSum(double firstOperand, double secondOperand, double expected)
    {
        double result = _calculator.Add(firstOperand, secondOperand);
        Assert.Equal(expected, result);
    }
    #endregion

    #region Subtraction Tests
    [Fact]
    public void Subtract_TwoPositiveNumbers_ReturnsCorrectDifference()
    {
        double result = _calculator.Subtract(10, 3);
        Assert.Equal(7, result);
    }

    [Theory]
    [InlineData(20, 8, 12)]
    [InlineData(-5, 3, -8)]
    [InlineData(0, 0, 0)]
    [InlineData(7.5, 2.5, 5)]
    public void Subtract_MultipleScenarios_ReturnsCorrectDifference(double firstOperand, double secondOperand, double expected)
    {
        double result = _calculator.Subtract(firstOperand, secondOperand);
        Assert.Equal(expected, result);
    }
    #endregion

    #region Multiplication Tests
    [Fact]
    public void Multiply_TwoPositiveNumbers_ReturnsCorrectProduct()
    {
        double result = _calculator.Multiply(6, 4);
        Assert.Equal(24, result);
    }

    [Theory]
    [InlineData(7, 6, 42)]
    [InlineData(-5, 3, -15)]
    [InlineData(0, 100, 0)]
    [InlineData(2.5, 4, 10)]
    public void Multiply_MultipleScenarios_ReturnsCorrectProduct(double firstOperand, double secondOperand, double expected)
    {
        double result = _calculator.Multiply(firstOperand, secondOperand);
        Assert.Equal(expected, result);
    }
    #endregion

    #region Division Tests
    [Fact]
    public void Divide_TwoPositiveNumbers_ReturnsCorrectQuotient()
    {
        double result = _calculator.Divide(20, 4);
        Assert.Equal(5, result);
    }

    [Theory]
    [InlineData(100, 5, 20)]
    [InlineData(15, 3, 5)]
    [InlineData(7, 2, 3.5)]
    [InlineData(-20, 4, -5)]
    public void Divide_MultipleScenarios_ReturnsCorrectQuotient(double firstOperand, double secondOperand, double expected)
    {
        double result = _calculator.Divide(firstOperand, secondOperand);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Divide_ByZero_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => _calculator.Divide(10, 0));
    }
    #endregion

    #region Modulo Tests
    [Fact]
    public void Modulo_TwoPositiveNumbers_ReturnsCorrectRemainder()
    {
        double result = _calculator.Modulo(17, 5);
        Assert.Equal(2, result);
    }

    [Theory]
    [InlineData(20, 3, 2)]
    [InlineData(10, 4, 2)]
    [InlineData(15, 5, 0)]
    [InlineData(-17, 5, -2)]
    public void Modulo_MultipleScenarios_ReturnsCorrectRemainder(double firstOperand, double secondOperand, double expected)
    {
        double result = _calculator.Modulo(firstOperand, secondOperand);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Modulo_ByZero_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => _calculator.Modulo(10, 0));
    }
    #endregion

    #region Power Tests
    [Fact]
    public void Power_TwoPositiveNumbers_ReturnsCorrectExponent()
    {
        double result = _calculator.Power(2, 3);
        Assert.Equal(8, result);
    }

    [Theory]
    [InlineData(5, 2, 25)]
    [InlineData(10, 0, 1)]
    [InlineData(2, 10, 1024)]
    [InlineData(3, 3, 27)]
    public void Power_MultipleScenarios_ReturnsCorrectExponent(double firstOperand, double secondOperand, double expected)
    {
        double result = _calculator.Power(firstOperand, secondOperand);
        Assert.Equal(expected, result);
    }
    #endregion

    #region Operate Tests
    [Theory]
    [InlineData(10, 5, "+", 15)]
    [InlineData(10, 5, "-", 5)]
    [InlineData(10, 5, "*", 50)]
    [InlineData(10, 5, "/", 2)]
    [InlineData(17, 5, "%", 2)]
    [InlineData(2, 3, "^", 8)]
    public void Operate_AllOperators_ReturnsCorrectResult(double firstOperand, double secondOperand, string operatorSymbol, double expected)
    {
        double result = _calculator.Operate(firstOperand, secondOperand, operatorSymbol);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Operate_InvalidOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => _calculator.Operate(10, 5, "&"));
    }

    [Fact]
    public void Operate_NullOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => _calculator.Operate(10, 5, null!));
    }

    [Fact]
    public void Operate_EmptyOperator_ThrowsArgumentException()
    {
        Assert.Throws<ArgumentException>(() => _calculator.Operate(10, 5, ""));
    }
    #endregion

    #region Edge Cases
    [Fact]
    public void Operations_WithNegativeNumbers_ReturnsCorrectResult()
    {
        double addResult = _calculator.Add(-10, -5);
        double subtractResult = _calculator.Subtract(-10, -5);
        double multiplyResult = _calculator.Multiply(-4, -3);

        Assert.Equal(-15, addResult);
        Assert.Equal(-5, subtractResult);
        Assert.Equal(12, multiplyResult);
    }

    [Fact]
    public void Operations_WithDecimalNumbers_ReturnsCorrectResult()
    {
        double addResult = _calculator.Add(1.5, 2.5);
        double multiplyResult = _calculator.Multiply(3.5, 2);
        double divideResult = _calculator.Divide(7.5, 2.5);

        Assert.Equal(4, addResult);
        Assert.Equal(7, multiplyResult);
        Assert.Equal(3, divideResult);
    }
    #endregion
}