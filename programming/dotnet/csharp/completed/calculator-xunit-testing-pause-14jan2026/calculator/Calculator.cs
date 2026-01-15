// Calculator Application - Basic Arithmetic Operations
// This application prompts users for two operands and an operator,
// performs the calculation, and allows for continuous use.

using calculator.shared;

ICalculatorService calculatorService = new CalculatorService();
bool continueCalculating = true;

while (continueCalculating)
{
    Console.Clear();
    Console.WriteLine("=== Basic Calculator ===\n");

    // Prompt for first operand
    Console.Write("Enter first number: ");
    string? firstInput = Console.ReadLine();
    
    if (!double.TryParse(firstInput, out double firstNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
        continue;
    }

    // Prompt for second operand
    Console.Write("Enter second number: ");
    string? secondInput = Console.ReadLine();
    
    if (!double.TryParse(secondInput, out double secondNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
        continue;
    }

    // Prompt for operator
    Console.Write("Enter operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(operatorInput))
    {
        Console.WriteLine("Operator cannot be empty.");
        Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
        continue;
    }

    // Perform calculation using service
    double result = calculatorService.Calculate(firstNumber, secondNumber, operatorInput);

    // Display result or error message
    if (double.IsNaN(result))
    {
        Console.WriteLine($"\nError: '{operatorInput}' is not a valid operator.");
        Console.WriteLine($"Valid operators: {string.Join(", ", calculatorService.GetSupportedOperators())}");
    }
    else if (double.IsInfinity(result))
    {
        Console.WriteLine($"\nError: Cannot divide by zero.");
    }
    else
    {
        Console.WriteLine($"\nResult: {firstNumber} {operatorInput} {secondNumber} = {result}");
    }

    // Ask if user wants to perform another calculation
    Console.WriteLine("\nWould you like to perform another calculation? (y/n): ");
    string? continueResponse = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(continueResponse) || 
        !continueResponse.Equals("y", StringComparison.OrdinalIgnoreCase))
    {
        continueCalculating = false;
        Console.WriteLine("\nThank you for using the calculator. Goodbye!");
    }
}

