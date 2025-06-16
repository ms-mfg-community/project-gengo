// Simple Calculator using top-level statements
while (true)
{
    Console.Write("Enter the first number: ");
    if (!double.TryParse(Console.ReadLine(), out double num1))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }

    Console.Write("Enter the operator (+, -, *, /): ");
    string op = Console.ReadLine();
    if (op != "+" && op != "-" && op != "*" && op != "/")
    {
        Console.WriteLine("Invalid operator. Please enter one of +, -, *, /");
        continue;
    }

    Console.Write("Enter the second number: ");
    if (!double.TryParse(Console.ReadLine(), out double num2))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }

    double result = 0;
    bool valid = true;
    switch (op)
    {
        case "+": result = num1 + num2; break;
        case "-": result = num1 - num2; break;
        case "*": result = num1 * num2; break;
        case "/":
            if (num2 == 0)
            {
                Console.WriteLine("Cannot divide by zero.");
                valid = false;
            }
            else
            {
                result = num1 / num2;
            }
            break;
    }
    if (valid)
        Console.WriteLine($"Result: {num1} {op} {num2} = {result}");

    Console.Write("Do you want to perform another calculation? (yes/no): ");
    string again = Console.ReadLine()?.Trim().ToLower();
    if (again != "yes" && again != "y")
    {
        Console.WriteLine("Thank you for using the calculator. Goodbye!");
        break;
    }
}
