// Simple Calculator using top-level statements
while (true)
{
    // Clear the screen at the start of each calculation
    Console.Clear();

    // Prompt for the first operand
    Console.Write("Enter the first number: ");
    if (!double.TryParse(Console.ReadLine(), out double num1))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        Console.WriteLine("Press Enter to continue...");
        Console.ReadLine();
        continue;
    }

    // Prompt for the second operand
    Console.Write("Enter the second number: ");
    if (!double.TryParse(Console.ReadLine(), out double num2))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        Console.WriteLine("Press Enter to continue...");
        Console.ReadLine();
        continue;
    }

    // Prompt for the operator (now includes %, ^)
    Console.Write("Enter the operator (+, -, *, /, %, ^): ");
    string op = Console.ReadLine();
    double result = 0;
    bool valid = true;
    switch (op)
    {
        case "+": result = CalculatorOperations.Add(num1, num2); break;
        case "-": result = CalculatorOperations.Subtract(num1, num2); break;
        case "*": result = CalculatorOperations.Multiply(num1, num2); break;
        case "/":
            try
            {
                result = CalculatorOperations.Divide(num1, num2);
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("Cannot divide by zero.");
                valid = false;
            }
            break;
        case "%":
            try
            {
                result = CalculatorOperations.Modulo(num1, num2);
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine("Cannot modulo by zero.");
                valid = false;
            }
            break;
        case "^": result = CalculatorOperations.Exponent(num1, num2); break;
        default:
            Console.WriteLine("Invalid operator. Please enter one of +, -, *, /, %, ^");
            valid = false;
            break;
    }
    if (valid)
        Console.WriteLine($"Result: {num1} {op} {num2} = {result}");

    Console.Write("Do you want to perform another calculation? (yes/no): ");
    string again = Console.ReadLine()?.Trim().ToLower();
    if (again != "yes" && again != "y")
    {
        Console.Clear(); // Clear screen before thank you message
        Console.WriteLine("Thank you for using the calculator. Goodbye!");
        break;
    }
}

// CalculatorOperations class for unit testing
public static class CalculatorOperations
{
    public static double Add(double a, double b) => a + b;
    public static double Subtract(double a, double b) => a - b;
    public static double Multiply(double a, double b) => a * b;
    public static double Divide(double a, double b)
    {
        if (b == 0) throw new DivideByZeroException();
        return a / b;
    }
    public static double Modulo(double a, double b)
    {
        if (b == 0) throw new DivideByZeroException();
        return a % b;
    }
    public static double Exponent(double a, double b) => Math.Pow(a, b);
}
