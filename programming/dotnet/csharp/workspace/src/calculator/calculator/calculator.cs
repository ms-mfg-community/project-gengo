using System;

namespace Calculator
{
    public class Program
    {
        // Method for addition
        public static double Addition(double num1, double num2)
        {
            return num1 + num2;
        }

        // Method for subtraction
        public static double Subtraction(double num1, double num2)
        {
            return num1 - num2;
        }

        // Method for multiplication
        public static double Multiplication(double num1, double num2)
        {
            return num1 * num2;
        }

        // Method for division
        public static double Division(double num1, double num2)
        {
            return num1 / num2;
        }

        static void Main()
        {
            Console.WriteLine("Welcome to Calculator, your Simple AI Calculator!");

            string userInput;
            do
            {
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
                string? op = Console.ReadLine();

                double result = 0;

                // Perform the calculation based on the operator
                switch (op)
                {
                    case "+":
                        result = Addition(num1, num2);
                        break;
                    case "-":
                        result = Subtraction(num1, num2);
                        break;
                    case "*":
                        result = Multiplication(num1, num2);
                        break;
                    case "/":
                        result = Division(num1, num2);
                        break;
                    default:
                        Console.WriteLine("Invalid operator!");
                        break;
                }

                // Display the result
                Console.WriteLine("Result: " + result);
                Console.Write("Would you like to perform another calculation? (yes/no): ");
                userInput = Console.ReadLine()!;
                if (userInput.Equals("yes", StringComparison.OrdinalIgnoreCase))
                {
                    Console.Clear();
                }
            } while (userInput.Equals("yes", StringComparison.OrdinalIgnoreCase));
            Console.WriteLine("Press any key to exit!");
            Console.ReadKey();
        }
    }
}
