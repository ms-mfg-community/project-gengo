using System;

namespace Calculator
{
    public class Program
    {
        public static void Main(string[] args)
        {
            bool continueCalculation = true;

            while (continueCalculation)
            {
                Console.Clear();
                Console.Write("Enter the first number: ");
                double firstNumber = Convert.ToDouble(Console.ReadLine());

                Console.Write("Enter the second number: ");
                double secondNumber = Convert.ToDouble(Console.ReadLine());

                Console.Write("Enter the operator (+, -, *, /): ");
                char operation = Console.ReadKey().KeyChar;
                Console.WriteLine();

                double result = 0;

                try
                {
                    result = PerformOperation(firstNumber, secondNumber, operation);
                    Console.WriteLine($"Result: {result}");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error: {ex.Message}");
                }

                Console.Write("Do you want to perform another calculation? (yes/no): ");
                string? userResponse = Console.ReadLine()?.ToLower();
                if (userResponse != "yes")
                {
                    continueCalculation = false;
                    Console.Clear();
                    Console.WriteLine("Thank you for using the calculator. Goodbye!");
                }
            }
        }

        public static double PerformOperation(double firstNumber, double secondNumber, char operation)
        {
            return operation switch
            {
                '+' => Add(firstNumber, secondNumber),
                '-' => Subtract(firstNumber, secondNumber),
                '*' => Multiply(firstNumber, secondNumber),
                '/' => Divide(firstNumber, secondNumber),
                _ => throw new InvalidOperationException("Invalid operator.")
            };
        }

        public static double Add(double a, double b) => a + b;

        public static double Subtract(double a, double b) => a - b;

        public static double Multiply(double a, double b) => a * b;

        public static double Divide(double a, double b)
        {
            if (b == 0)
                throw new DivideByZeroException("Division by zero is not allowed.");
            return a / b;
        }
    }
}
