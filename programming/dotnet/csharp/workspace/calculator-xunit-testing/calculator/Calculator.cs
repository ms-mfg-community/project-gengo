// Calculator implementation following section 1.12.3 - Refactored with methods for testability

bool continueCalculating = true;

while (continueCalculating)
{
    Console.Clear();
    Console.WriteLine("=== Simple Calculator ===\n");

    // Prompt for first operand
    Console.Write("Enter first number: ");
    string? firstInput = Console.ReadLine();
    if (!double.TryParse(firstInput, out double firstOperand))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        System.Threading.Thread.Sleep(2000);
        continue;
    }

    // Prompt for second operand
    Console.Write("Enter second number: ");
    string? secondInput = Console.ReadLine();
    if (!double.TryParse(secondInput, out double secondOperand))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        System.Threading.Thread.Sleep(2000);
        continue;
    }

    // Prompt for operator
    Console.Write("Enter operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();
    if (string.IsNullOrWhiteSpace(operatorInput) || operatorInput.Length != 1)
    {
        Console.WriteLine("Invalid operator. Please enter a single operator.");
        System.Threading.Thread.Sleep(2000);
        continue;
    }
    char operatorChar = operatorInput[0];

    // Perform the arithmetic operation using CalculatorOperations class
    double result = CalculatorOperations.Perform(firstOperand, secondOperand, operatorChar);

    // Display the result
    CalculatorOperations.DisplayResult(firstOperand, secondOperand, operatorChar, result);

    // Ask if the user wants to perform another calculation
    Console.Write("\nDo you want to perform another calculation? (yes/no): ");
    string? continueInput = Console.ReadLine();
    
    // Handle user response
    if (string.IsNullOrWhiteSpace(continueInput) || !continueInput.Equals("yes", StringComparison.OrdinalIgnoreCase))
    {
        continueCalculating = false;
    }
}

Console.WriteLine("\nThank you for using the calculator. Goodbye!");