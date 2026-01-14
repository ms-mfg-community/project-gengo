using System;

internal class Program
{
    private static void Main(string[] args)
    {
        Console.Clear();
        Console.WriteLine("========================================");
        Console.WriteLine("        Welcome to the Calculator       ");
        Console.WriteLine("========================================");
        Console.WriteLine("Supported operations: +, -, *, /, %, ^");
        Console.WriteLine("Type 'exit' to quit\n");

        Calculator calculator = new Calculator();
        bool continueCalculating = true;

        while (continueCalculating)
        {
            try
            {
                double firstOperand = GetNumericInput("Enter first number: ");
                string? operatorSymbol = GetOperatorInput("Enter operator (+, -, *, /, %, ^): ");
                
                if (operatorSymbol == null)
                {
                    continueCalculating = false;
                    continue;
                }

                double secondOperand = GetNumericInput("Enter second number: ");
                double result = calculator.Operate(firstOperand, secondOperand, operatorSymbol);

                Console.WriteLine($"\n{firstOperand} {operatorSymbol} {secondOperand} = {result}\n");
                continueCalculating = PromptForAnotherCalculation();
                
                if (continueCalculating)
                    Console.Clear();
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine($"\nError: {ex.Message}\n");
            }
        }

        Console.WriteLine("\nThank you for using the Calculator. Goodbye!");
    }

    private static double GetNumericInput(string prompt)
    {
        while (true)
        {
            Console.Write(prompt);
            string? input = Console.ReadLine();

            if (string.IsNullOrWhiteSpace(input))
            {
                Console.WriteLine("Invalid input. Please enter a valid number.");
                continue;
            }

            if (double.TryParse(input, out double result))
                return result;

            Console.WriteLine("Invalid input. Please enter a valid number.");
        }
    }

    private static string? GetOperatorInput(string prompt)
    {
        string[] validOperators = { "+", "-", "*", "/", "%", "^" };

        while (true)
        {
            Console.Write(prompt);
            string? input = Console.ReadLine();

            if (string.IsNullOrWhiteSpace(input))
            {
                Console.WriteLine("Invalid input. Please enter a valid operator.");
                continue;
            }

            if (input.Equals("exit", StringComparison.OrdinalIgnoreCase))
                return null;

            if (Array.Exists(validOperators, element => element == input))
                return input;

            Console.WriteLine("Invalid operator. Please use one of: +, -, *, /, %, ^");
        }
    }

    private static bool PromptForAnotherCalculation()
    {
        while (true)
        {
            Console.Write("Would you like to perform another calculation? (yes/no): ");
            string? input = Console.ReadLine();

            if (string.IsNullOrWhiteSpace(input))
                continue;

            if (input.Equals("yes", StringComparison.OrdinalIgnoreCase) || input.Equals("y", StringComparison.OrdinalIgnoreCase))
                return true;

            if (input.Equals("no", StringComparison.OrdinalIgnoreCase) || input.Equals("n", StringComparison.OrdinalIgnoreCase))
                return false;

            Console.WriteLine("Invalid input. Please enter 'yes' or 'no'.");
        }
    }
}

