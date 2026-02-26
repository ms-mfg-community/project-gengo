#nullable enable

namespace Calculator
{
    /// <summary>
    /// Provides arithmetic operations for basic calculator functionality.
    /// </summary>
    public class Calculator
    {
        /// <summary>
        /// Adds two numbers.
        /// </summary>
        /// <param name="a">First operand</param>
        /// <param name="b">Second operand</param>
        /// <returns>The sum of a and b</returns>
        /// <example>
        /// <code>
        /// var result = Calculator.Add(5, 3);
        /// Console.WriteLine(result); // Output: 8
        /// </code>
        /// </example>
        public static double Add(double a, double b)
        {
            return a + b;
        }

        /// <summary>
        /// Subtracts the second number from the first number.
        /// </summary>
        /// <param name="a">Minuend (first operand)</param>
        /// <param name="b">Subtrahend (second operand)</param>
        /// <returns>The difference (a - b)</returns>
        /// <example>
        /// <code>
        /// var result = Calculator.Subtract(10, 3);
        /// Console.WriteLine(result); // Output: 7
        /// </code>
        /// </example>
        public static double Subtract(double a, double b)
        {
            return a - b;
        }

        /// <summary>
        /// Multiplies two numbers.
        /// </summary>
        /// <param name="a">First operand</param>
        /// <param name="b">Second operand</param>
        /// <returns>The product of a and b</returns>
        /// <example>
        /// <code>
        /// var result = Calculator.Multiply(4, 5);
        /// Console.WriteLine(result); // Output: 20
        /// </code>
        /// </example>
        public static double Multiply(double a, double b)
        {
            return a * b;
        }

        /// <summary>
        /// Divides the first number by the second number.
        /// </summary>
        /// <param name="a">Dividend (first operand)</param>
        /// <param name="b">Divisor (second operand)</param>
        /// <returns>The quotient (a / b)</returns>
        /// <exception cref="DivideByZeroException">Thrown when divisor is zero</exception>
        /// <example>
        /// <code>
        /// var result = Calculator.Divide(20, 4);
        /// Console.WriteLine(result); // Output: 5
        /// </code>
        /// </example>
        public static double Divide(double a, double b)
        {
            if (b == 0)
                throw new DivideByZeroException("Cannot divide by zero");
            return a / b;
        }

        /// <summary>
        /// Calculates the remainder of division of the first number by the second number.
        /// </summary>
        /// <param name="a">Dividend (first operand)</param>
        /// <param name="b">Divisor (second operand)</param>
        /// <returns>The remainder (a % b)</returns>
        /// <exception cref="DivideByZeroException">Thrown when divisor is zero</exception>
        /// <example>
        /// <code>
        /// var result = Calculator.Modulo(10, 3);
        /// Console.WriteLine(result); // Output: 1
        /// </code>
        /// </example>
        public static double Modulo(double a, double b)
        {
            if (b == 0)
                throw new DivideByZeroException("Cannot perform modulo with zero");
            return a % b;
        }

        /// <summary>
        /// Raises the first number to the power of the second number.
        /// </summary>
        /// <param name="a">Base (first operand)</param>
        /// <param name="b">Exponent (second operand)</param>
        /// <returns>a raised to the power of b</returns>
        /// <example>
        /// <code>
        /// var result = Calculator.Power(2, 3);
        /// Console.WriteLine(result); // Output: 8
        /// </code>
        /// </example>
        public static double Power(double a, double b)
        {
            return Math.Pow(a, b);
        }

        /// <summary>
        /// Performs an arithmetic operation on two operands based on the provided operator.
        /// </summary>
        /// <param name="a">First operand</param>
        /// <param name="b">Second operand</param>
        /// <param name="operatorSymbol">Operator symbol (+, -, *, /, %, ^)</param>
        /// <returns>Result of the operation</returns>
        /// <exception cref="ArgumentException">Thrown when operator is not recognized</exception>
        /// <exception cref="DivideByZeroException">Thrown when attempting division by zero</exception>
        /// <example>
        /// <code>
        /// var result = Calculator.Calculate(10, 5, "+");
        /// Console.WriteLine(result); // Output: 15
        /// </code>
        /// </example>
        public static double Calculate(double a, double b, string? operatorSymbol)
        {
            if (operatorSymbol == null)
                throw new ArgumentException("Operator cannot be null");

            return operatorSymbol switch
            {
                "+" => Add(a, b),
                "-" => Subtract(a, b),
                "*" => Multiply(a, b),
                "/" => Divide(a, b),
                "%" => Modulo(a, b),
                "^" => Power(a, b),
                _ => throw new ArgumentException($"Unknown operator: {operatorSymbol}")
            };
        }
    }
}
