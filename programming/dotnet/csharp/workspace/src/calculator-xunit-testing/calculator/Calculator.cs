using System;

void ClearScreen()
{
    Console.Clear();
}

double Add(double a, double b) => a + b;
double Subtract(double a, double b) => a - b;
double Multiply(double a, double b) => a * b;
double Divide(double a, double b)
{
    if (b == 0) throw new DivideByZeroException("Cannot divide by zero.");
    return a / b;
}
double Modulo(double a, double b) => a % b;
double Exponent(double a, double b) => Math.Pow(a, b);

bool continueCalculation = true;

while (continueCalculation)
{
    ClearScreen();

    Console.Write("Enter the first number: ");
    if (!double.TryParse(Console.ReadLine(), out double firstNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }

    Console.Write("Enter the second number: ");
    if (!double.TryParse(Console.ReadLine(), out double secondNumber))
    {
        Console.WriteLine("Invalid input. Please enter a valid number.");
        continue;
    }

    Console.Write("Enter the operator (+, -, *, /, %, ^): ");
    string operation = Console.ReadLine() ?? string.Empty;

    double result;
    try
    {
        result = operation switch
        {
            "+" => Add(firstNumber, secondNumber),
            "-" => Subtract(firstNumber, secondNumber),
            "*" => Multiply(firstNumber, secondNumber),
            "/" => Divide(firstNumber, secondNumber),
            "%" => Modulo(firstNumber, secondNumber),
            "^" => Exponent(firstNumber, secondNumber),
            _ => throw new InvalidOperationException("Invalid operator. Please enter one of +, -, *, /, %, ^.")
        };
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
        continue;
    }

    Console.WriteLine($"The result is: {result}");

    Console.Write("Do you want to perform another calculation? (yes/no): ");
    string response = Console.ReadLine()?.ToLower() ?? string.Empty;
    if (response == "yes")
    {
        continue;
    }
    else
    {
        ClearScreen();
        continueCalculation = false;
        Console.WriteLine("Thank you for using the calculator. Goodbye!");
    }
}
