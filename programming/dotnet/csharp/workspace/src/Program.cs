using System;

namespace CalculatorApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Welcome to Calculator App!");

            // Get the first number from the user
            double num1;
            do
            {
                Console.Write("Enter the first number: ");
            } while (!double.TryParse(Console.ReadLine(), out num1));

            // Get the second number from the user
            double num2;
            do
            {
                Console.Write("Enter the second number: ");
            } while (!double.TryParse(Console.ReadLine(), out num2));

            // Get the operator from the user
            Console.Write("Enter the operator (+, -, *, /): ");
            
            char op = Convert.ToChar(Console.ReadLine());

            double result = 0;

            // Perform the calculation based on the operator
            switch (op)
            {
                case '+':
                    result = num1 + num2;
                    break;
                case '-':
                    result = num1 - num2;
                    break;
                case '*':
                    result = num1 * num2;
                    break;
                case '/':
                    result = num1 / num2;
                    break;
                default:
                    Console.WriteLine("Invalid operator!");
                    break;
            }

            // Display the result
            Console.WriteLine("Result: " + result);

            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }
    }
}
