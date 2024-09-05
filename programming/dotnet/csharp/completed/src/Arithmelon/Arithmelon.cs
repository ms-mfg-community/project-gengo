namespace Arithmelon
{
    public class ArithmelonCS
    {

        // Method for additionator
        public static double Additionator(double num1, double num2)
        {
            return num1 + num2;
        }

        // Method for Subtractinator
        public static double Subtractinator(double num1, double num2)
        {
            return num1 - num2;
        }

        // Method for multiplicator
        public static double Multiplicator(double num1, double num2)
        {
            return num1 * num2;
        }

        // Method for division
        public static double Dividinator(double num1, double num2)
        {
            return num1 / num2;
        }

        static void Main()
        {
            WriteLine("Welcome to Arithmelon, you Simple AI Calculator to demonstrate Unit Testing!");

            string arithmiUserInput;
            do
            {
                // Get the first number from the user
                double num1;
                do
                {
                    Console.Write("Enter the first numberlon: ");
                } while (!double.TryParse(Console.ReadLine(), out num1));

                // Get the second number from the user
                double num2;
                do
                {
                    Console.Write("Enter the second numberlon: ");
                } while (!double.TryParse(Console.ReadLine(), out num2));

                // Get the operator from the user
                Console.Write("Enter the operator from this collection [additoinator | subtractinator | multiplicator | dividinator): ");

                string? op = Convert.ToString(Console.ReadLine());

                double result = 0;

                // Perform the calculation based on the operator
                switch (op)
                {
                    case "additionator":
                        result = Additionator(num1, num2);
                        break;
                    case "subtractinator":
                        result = Subtractinator(num1, num2);
                        break;
                    case "multiplicator":
                        result = Multiplicator(num1, num2);
                        break;
                    case "dividinator":
                        result = Dividinator(num1, num2);
                        break;
                    default:
                        Console.WriteLine("Invalid operator!");
                        break;
                }

                // Display the result
                Console.WriteLine("Result: " + result);
                Console.Write("Would you like to challenge Arithmelon with another calculation again? (yes/no): ");
                arithmiUserInput = Console.ReadLine()!;
                if (arithmiUserInput.Equals("yes", StringComparison.OrdinalIgnoreCase))
                {
                    Console.Clear();
                }
            } while (arithmiUserInput.Equals("yes", StringComparison.OrdinalIgnoreCase));
            Console.WriteLine("Press any key to surrender!");
            Console.ReadKey();
        }
    }
}
