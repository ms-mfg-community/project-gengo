#nullable enable

using calculator;

// Console Calculator Application
// Demonstrates top-level statements with Calculator class usage

bool continueCalculating = true;

Console.WriteLine("╔════════════════════════════════════════╗");
Console.WriteLine("║  Welcome to the .NET Calculator       ║");
Console.WriteLine("║  Type 'exit' to quit at any time      ║");
Console.WriteLine("╚════════════════════════════════════════╝");
Console.WriteLine();

while (continueCalculating)
{
    try
    {
        // Clear screen gracefully (ignore IOException in non-interactive environments)
        try
        {
            Console.Clear();
        }
        catch (IOException)
        {
            // Ignore if not running in interactive console
            Console.WriteLine();
        }

        Console.WriteLine("┌─ Calculator ─────────────────────────┐");
        Console.WriteLine("│ Supported operations: + - * / % ^     │");
        Console.WriteLine("│ (addition, subtraction, multiplication,");
        Console.WriteLine("│  division, modulo, power)             │");
        Console.WriteLine("└──────────────────────────────────────┘");
        Console.WriteLine();

        // Get first number
        Console.Write("Enter first number: ");
        string? firstInput = Console.ReadLine();

        if (firstInput?.Equals("exit", StringComparison.OrdinalIgnoreCase) ?? false)
        {
            Console.WriteLine("\n✓ Thank you for using the calculator. Goodbye!");
            break;
        }

        if (!double.TryParse(firstInput, out double firstNumber))
        {
            Console.WriteLine("✗ Invalid input. Please enter a valid number (integer or decimal).");
            Console.Write("Press Enter to continue...");
            Console.ReadLine();
            continue;
        }

        // Get second number
        Console.Write("Enter second number: ");
        string? secondInput = Console.ReadLine();

        if (secondInput?.Equals("exit", StringComparison.OrdinalIgnoreCase) ?? false)
        {
            Console.WriteLine("\n✓ Thank you for using the calculator. Goodbye!");
            break;
        }

        if (!double.TryParse(secondInput, out double secondNumber))
        {
            Console.WriteLine("✗ Invalid input. Please enter a valid number (integer or decimal).");
            Console.Write("Press Enter to continue...");
            Console.ReadLine();
            continue;
        }

        // Get operator
        Console.Write("Enter operator (+, -, *, /, %, ^): ");
        string? operatorSymbol = Console.ReadLine();

        if (operatorSymbol?.Equals("exit", StringComparison.OrdinalIgnoreCase) ?? false)
        {
            Console.WriteLine("\n✓ Thank you for using the calculator. Goodbye!");
            break;
        }

        if (string.IsNullOrWhiteSpace(operatorSymbol))
        {
            Console.WriteLine("✗ Operator cannot be empty.");
            Console.Write("Press Enter to continue...");
            Console.ReadLine();
            continue;
        }

        // Validate operator
        if (!new[] { "+", "-", "*", "/", "%", "^" }.Contains(operatorSymbol.Trim()))
        {
            Console.WriteLine($"✗ Unknown operator: {operatorSymbol}. Supported operators are: + - * / % ^");
            Console.Write("Press Enter to continue...");
            Console.ReadLine();
            continue;
        }

        // Perform calculation
        double result = Calculator.Calculate(firstNumber, secondNumber, operatorSymbol!);

        Console.WriteLine();
        Console.WriteLine("┌─ Result ──────────────────────────────┐");
        Console.WriteLine($"│  {firstNumber} {operatorSymbol} {secondNumber} = {result}");
        Console.WriteLine("└──────────────────────────────────────┘");
        Console.WriteLine();

        // Ask if user wants to continue
        Console.Write("Would you like to perform another calculation? (yes/no): ");
        string? continueResponse = Console.ReadLine();

        if ((continueResponse?.Equals("no", StringComparison.OrdinalIgnoreCase) ?? false) ||
            (continueResponse?.Equals("n", StringComparison.OrdinalIgnoreCase) ?? false))
        {
            Console.WriteLine("\n✓ Thank you for using the calculator. Goodbye!");
            continueCalculating = false;
        }
    }
    catch (DivideByZeroException ex)
    {
        Console.WriteLine($"\n✗ Error: {ex.Message}");
        Console.Write("Press Enter to continue...");
        Console.ReadLine();
    }
    catch (ArgumentException ex)
    {
        Console.WriteLine($"\n✗ Error: {ex.Message}");
        Console.Write("Press Enter to continue...");
        Console.ReadLine();
    }
    catch (Exception ex)
    {
        Console.WriteLine($"\n✗ Unexpected error: {ex.Message}");
        Console.Write("Press Enter to continue...");
        Console.ReadLine();
    }
}
