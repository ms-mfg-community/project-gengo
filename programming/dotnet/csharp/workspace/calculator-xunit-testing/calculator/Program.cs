// Console Calculator Application - Top-level statements for user interaction
using calculator;

bool continueCalculating = true;

Console.WriteLine("=== .NET 8 Console Calculator ===");
Console.WriteLine("Supported operators: +, -, *, /, %, ^");
Console.WriteLine();

while (continueCalculating)
{
    // Prompt for first operand
    Console.Write("Enter the first number: ");
    string? firstInput = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(firstInput) || !double.TryParse(firstInput, out double firstNumber))
    {
        Console.WriteLine("Error: Invalid number. Please enter a valid numeric value.");
        Console.WriteLine();
        continue;
    }

    // Prompt for operator
    Console.Write("Enter an operator (+, -, *, /, %, ^): ");
    string? operatorInput = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(operatorInput))
    {
        Console.WriteLine("Error: Operator cannot be empty. Please enter a valid operator.");
        Console.WriteLine();
        continue;
    }

    // Prompt for second operand
    Console.Write("Enter the second number: ");
    string? secondInput = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(secondInput) || !double.TryParse(secondInput, out double secondNumber))
    {
        Console.WriteLine("Error: Invalid number. Please enter a valid numeric value.");
        Console.WriteLine();
        continue;
    }

    // Perform calculation
    try
    {
        double result = Calculator.Calculate(firstNumber, secondNumber, operatorInput);
        Console.WriteLine($"Result: {firstNumber} {operatorInput} {secondNumber} = {result}");
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
    string? response = Console.ReadLine();

    if (string.IsNullOrWhiteSpace(response) ||
        !response.Trim().Equals("y", StringComparison.OrdinalIgnoreCase))
    {
        continueCalculating = false;
    }

    // Clear screen between calculations for a clean interface
    if (continueCalculating)
    {
        Console.Clear();
        Console.WriteLine("=== .NET 8 Console Calculator ===");
        Console.WriteLine("Supported operators: +, -, *, /, %, ^");
        Console.WriteLine();
    }
}

Console.WriteLine();
Console.WriteLine("Thank you for using the calculator. Goodbye!");
