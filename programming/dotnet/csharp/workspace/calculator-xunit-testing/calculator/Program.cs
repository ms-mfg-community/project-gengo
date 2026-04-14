// .NET 8 Console Calculator — top-level statements (entry point)
// Calculator class and methods are in Calculator.cs

using calculator;

bool continueCalculating = true;

Console.WriteLine("=== .NET 8 Console Calculator ===");
Console.WriteLine("Supported operators: +  -  *  /  %  ^");
Console.WriteLine();

while (continueCalculating)
{
    // Prompt for first operand
    double firstOperand;
    while (true)
    {
        Console.Write("Enter first number: ");
        string? input = Console.ReadLine();
        if (double.TryParse(input, out firstOperand))
        {
            break;
        }

        Console.WriteLine("Invalid input. Please enter a valid number.");
    }

    // Prompt for second operand
    double secondOperand;
    while (true)
    {
        Console.Write("Enter second number: ");
        string? input = Console.ReadLine();
        if (double.TryParse(input, out secondOperand))
        {
            break;
        }

        Console.WriteLine("Invalid input. Please enter a valid number.");
    }

    // Prompt for operator
    string operatorSymbol;
    while (true)
    {
        Console.Write("Enter operator (+, -, *, /, %, ^): ");
        string? input = Console.ReadLine();
        if (!string.IsNullOrWhiteSpace(input) && "+-*/%^".Contains(input.Trim()))
        {
            operatorSymbol = input.Trim();
            break;
        }

        Console.WriteLine("Invalid operator. Please enter one of: +, -, *, /, %, ^");
    }

    // Perform the calculation and display the result
    try
    {
        double result = Calculator.Calculate(firstOperand, secondOperand, operatorSymbol);
        Console.WriteLine();
        Console.WriteLine($"  {firstOperand} {operatorSymbol} {secondOperand} = {result}");
        Console.WriteLine();
    }
    catch (DivideByZeroException ex)
    {
        Console.WriteLine();
        Console.WriteLine($"  Error: {ex.Message}");
        Console.WriteLine();
    }
    catch (ArgumentException ex)
    {
        Console.WriteLine();
        Console.WriteLine($"  Error: {ex.Message}");
        Console.WriteLine();
    }

    // Ask if the user wants to continue
    Console.Write("Perform another calculation? (y/n): ");
    string? response = Console.ReadLine();
    if (string.IsNullOrWhiteSpace(response) ||
        !response.Trim().Equals("y", StringComparison.OrdinalIgnoreCase))
    {
        continueCalculating = false;
    }

    Console.Clear();
}

Console.WriteLine("Thank you for using the .NET 8 Console Calculator. Goodbye!");
