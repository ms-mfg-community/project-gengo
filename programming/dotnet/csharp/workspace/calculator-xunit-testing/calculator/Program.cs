// Top-level statements for .NET 8 console calculator
// These statements handle user interaction, prompts, and the calculation loop

using calculator;

string? input = null;
string? continueCalculating = null;
bool isValidInput;

// Main calculation loop
do
{
    // Clear screen for better user experience (if interactive)
    try
    {
        Console.Clear();
    }
    catch (IOException)
    {
        // Ignore if not running in interactive console
        Console.WriteLine();
    }

    Console.WriteLine("╔════════════════════════════════════════╗");
    Console.WriteLine("║         .NET 8 Console Calculator      ║");
    Console.WriteLine("║   Supported: +, -, *, /, %, ^ (power) ║");
    Console.WriteLine("╚════════════════════════════════════════╝");
    Console.WriteLine();

    // Get first operand
    int firstNumber = 0;
    isValidInput = false;
    while (!isValidInput)
    {
        Console.Write("Enter first number: ");
        input = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(input))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Error: Input cannot be empty. Please enter a valid number.");
            Console.ResetColor();
            continue;
        }

        if (int.TryParse(input, out firstNumber))
        {
            isValidInput = true;
        }
        else
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Error: '{input}' is not a valid number. Please enter an integer.");
            Console.ResetColor();
        }
    }

    // Get operator
    string? operatorSymbol = null;
    string[] validOperators = { "+", "-", "*", "/", "%", "^" };
    isValidInput = false;

    while (!isValidInput)
    {
        Console.Write("Enter operator (+, -, *, /, %, ^): ");
        operatorSymbol = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(operatorSymbol))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Error: Operator cannot be empty. Please enter a valid operator.");
            Console.ResetColor();
            continue;
        }

        if (validOperators.Contains(operatorSymbol))
        {
            isValidInput = true;
        }
        else
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Error: '{operatorSymbol}' is not a valid operator. Valid operators are: +, -, *, /, %, ^");
            Console.ResetColor();
        }
    }

    // Get second operand
    int secondNumber = 0;
    isValidInput = false;
    while (!isValidInput)
    {
        Console.Write("Enter second number: ");
        input = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(input))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Error: Input cannot be empty. Please enter a valid number.");
            Console.ResetColor();
            continue;
        }

        if (int.TryParse(input, out secondNumber))
        {
            isValidInput = true;
        }
        else
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Error: '{input}' is not a valid number. Please enter an integer.");
            Console.ResetColor();
        }
    }

    // Perform calculation
    Console.WriteLine();
    try
    {
        // operatorSymbol is guaranteed non-null from validation loop
        int result = Calculator.Calculate(firstNumber, secondNumber, operatorSymbol!);

        Console.ForegroundColor = ConsoleColor.Green;
        Console.WriteLine($"Result: {firstNumber} {operatorSymbol} {secondNumber} = {result}");
        Console.ResetColor();
    }
    catch (DivideByZeroException ex)
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine($"Error: {ex.Message}");
        Console.ResetColor();
    }
    catch (ArgumentException ex)
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine($"Error: {ex.Message}");
        Console.ResetColor();
    }
    catch (Exception ex)
    {
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine($"Unexpected error: {ex.Message}");
        Console.ResetColor();
    }

    // Ask if user wants to continue
    Console.WriteLine();
    isValidInput = false;
    while (!isValidInput)
    {
        Console.Write("Would you like to perform another calculation? (yes/no): ");
        continueCalculating = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(continueCalculating))
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("Please enter 'yes' or 'no'.");
            Console.ResetColor();
            continue;
        }

        if (continueCalculating.Equals("yes", StringComparison.OrdinalIgnoreCase) ||
            continueCalculating.Equals("no", StringComparison.OrdinalIgnoreCase))
        {
            isValidInput = true;
        }
        else
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("Please enter 'yes' or 'no'.");
            Console.ResetColor();
        }
    }

} while (continueCalculating?.Equals("yes", StringComparison.OrdinalIgnoreCase) == true);

// Exit message
Console.WriteLine();
Console.ForegroundColor = ConsoleColor.Cyan;
Console.WriteLine("Thank you for using the .NET 8 Console Calculator. Goodbye!");
Console.ResetColor();
