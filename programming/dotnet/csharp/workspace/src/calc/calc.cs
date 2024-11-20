using System;

class Calculator
{
    static void Main()
    {
        bool continueCalculation = true;

        while (continueCalculation)
        {
            Console.Clear();

            // Prompt user for the first number
            Console.Write("Enter the first number: ");
            double firstNumber = Convert.ToDouble(Console.ReadLine());

            // Prompt user for the second number
            Console.Write("Enter the second number: ");
            double secondNumber = Convert.ToDouble(Console.ReadLine());

            // Prompt user for the operator
            Console.Write("Enter the operator (+, -, *, /): ");
            char operation = Console.ReadKey().KeyChar;
            Console.WriteLine();

            try
            {
                double result = PerformOperation(firstNumber, secondNumber, operation);

                // Display the result
                Console.WriteLine($"Result: {result}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }

            // Prompt user if they want to continue
            Console.Write("Do you want to perform another operation? (yes/no): ");
            string? userResponse = Console.ReadLine()?.ToLower();

            // Check if the user wants to terminate the program
            if (userResponse != "yes")
            {
                continueCalculation = false;
                Console.WriteLine("Program terminated!");
            }
        }
    }

    public static double PerformOperation(double firstNumber, double secondNumber, char operation)
    {
        return operation switch
        {
            '+' => firstNumber + secondNumber,
            '-' => firstNumber - secondNumber,
            '*' => firstNumber * secondNumber,
            '/' when secondNumber != 0 => firstNumber / secondNumber,
            '/' => throw new DivideByZeroException("Division by zero is not allowed."),
            _ => throw new InvalidOperationException("Invalid operator.")
        };
    }
}
