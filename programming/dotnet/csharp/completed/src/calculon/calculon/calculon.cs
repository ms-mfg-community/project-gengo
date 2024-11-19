using System;

public class Calculon
{
    public double Add(double num1, double num2) => num1 + num2;
    public double Subtract(double num1, double num2) => num1 - num2;
    public double Multiply(double num1, double num2) => num1 * num2;
    public double Divide(double num1, double num2) => num1 / num2;

    public double Calculate(double num1, double num2, char op)
    {
        return op switch
        {
            '+' => Add(num1, num2),
            '-' => Subtract(num1, num2),
            '*' => Multiply(num1, num2),
            '/' => Divide(num1, num2),
            _ => throw new InvalidOperationException("Invalid operator.")
        };
    }
}

public class Program
{
    public static void Main(string[] strings)
    {
        var calculon = new Calculon();

        while (true)
        {
            Console.Clear();
            Console.Write("Enter the first number: ");
            double num1 = Convert.ToDouble(Console.ReadLine());

            Console.Write("Enter the second number: ");
            double num2 = Convert.ToDouble(Console.ReadLine());

            Console.Write("Enter an operator (+, -, *, /): ");
            string? input = Console.ReadLine();
            if (string.IsNullOrEmpty(input))
            {
                Console.WriteLine("Invalid operator.");
                continue;
            }
            char op = input[0];

            try
            {
                double result = calculon.Calculate(num1, num2, op);
                Console.WriteLine($"Result: {result}");
            }
            catch (InvalidOperationException ex)
            {
                Console.WriteLine(ex.Message);
                continue;
            }

            Console.Write("Do you want to perform another operation? (yes/no): ");
            string? response = Console.ReadLine()?.ToLower();

            if (response != "yes")
            {
                Console.WriteLine("User has terminated the program!");
                break;
            }
        }
    }
}
