#nullable enable

using Calculator;

// Main calculator loop
bool continueCalculating = true;

while (continueCalculating)
{
    Console.Clear();
    Console.WriteLine("==== Welcome to the Calculator ====");
    Console.WriteLine();

    // Prompt for first operand
    Console.Write("Enter first operand: ");
    string? firstOperandInput = Console.ReadLine();
    
    if (firstOperandInput == null || !double.TryParse(firstOperandInput, out double firstOperand))
    {
        Console.WriteLine("Error: Invalid input for first operand. Please enter a valid number.");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
        continue;
    }

    // Prompt for second operand
    Console.Write("Enter second operand: ");
    string? secondOperandInput = Console.ReadLine();

    if (secondOperandInput == null || !double.TryParse(secondOperandInput, out double secondOperand))
    {
        Console.WriteLine("Error: Invalid input for second operand. Please enter a valid number.");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
        continue;
    }

    // Prompt for operator
    Console.Write("Enter operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();

    if (operatorInput == null || operatorInput.Length != 1)
    {
        Console.WriteLine("Error: Invalid operator. Please enter a single operator character.");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
        continue;
    }

    // Perform calculation
    try
    {
        double result = Calculator.Calculator.Calculate(firstOperand, secondOperand, operatorInput);
        Console.WriteLine();
        Console.WriteLine($"Result: {firstOperand} {operatorInput} {secondOperand} = {result}");
    }
    catch (DivideByZeroException ex)
    {
        Console.WriteLine($"Error: {ex.Message}");
    }
    catch (ArgumentException ex)
    {
        Console.WriteLine($"Error: {ex.Message}");
    }

    // Ask if user wants to continue
    Console.WriteLine();
    Console.Write("Do you want to perform another calculation? (y/n): ");
    string? continueResponse = Console.ReadLine();

    if (continueResponse == null || !continueResponse.Equals("y", StringComparison.OrdinalIgnoreCase))
    {
        Console.Write("Are you sure you want to exit? (y/n): ");
        string? exitConfirmation = Console.ReadLine();

        if (exitConfirmation != null && exitConfirmation.Equals("y", StringComparison.OrdinalIgnoreCase))
        {
            continueCalculating = false;
            Console.WriteLine("Thank you for using the Calculator. Goodbye!");
        }
    }
    else
    {
        Console.WriteLine("Press any key to continue to the next calculation...");
        Console.ReadKey();
    }
}
