// Basic Calculator Application with Top-Level Statements
// Demonstrates arithmetic operations and user interaction

string? continueCalculating = "y";

while (continueCalculating?.ToLower() == "y")
{
    // Prompt for first operand
    Console.Write("Enter the first operand: ");
    string? firstInput = Console.ReadLine();
    
    // Validate and parse first operand
    if (string.IsNullOrWhiteSpace(firstInput) || !double.TryParse(firstInput, out double firstOperand))
    {
        Console.WriteLine("Invalid input for first operand. Please enter a valid number.");
        continue;
    }
    
    // Prompt for second operand
    Console.Write("Enter the second operand: ");
    string? secondInput = Console.ReadLine();
    
    // Validate and parse second operand
    if (string.IsNullOrWhiteSpace(secondInput) || !double.TryParse(secondInput, out double secondOperand))
    {
        Console.WriteLine("Invalid input for second operand. Please enter a valid number.");
        continue;
    }
    
    // Prompt for operator
    Console.Write("Enter the operator (+, -, *, /): ");
    string? operatorInput = Console.ReadLine();
    
    // Validate operator input
    if (string.IsNullOrWhiteSpace(operatorInput))
    {
        Console.WriteLine("Invalid operator. Please enter one of: +, -, *, /");
        continue;
    }
    
    // Perform calculation based on operator
    double result;
    
    switch (operatorInput)
    {
        case "+":
            result = firstOperand + secondOperand;
            Console.WriteLine($"Result: {firstOperand} + {secondOperand} = {result}");
            break;
        case "-":
            result = firstOperand - secondOperand;
            Console.WriteLine($"Result: {firstOperand} - {secondOperand} = {result}");
            break;
        case "*":
            result = firstOperand * secondOperand;
            Console.WriteLine($"Result: {firstOperand} * {secondOperand} = {result}");
            break;
        case "/":
            if (secondOperand == 0)
            {
                Console.WriteLine("Error: Division by zero is not allowed.");
            }
            else
            {
                result = firstOperand / secondOperand;
                Console.WriteLine($"Result: {firstOperand} / {secondOperand} = {result}");
            }
            break;
        default:
            Console.WriteLine($"Invalid operator: {operatorInput}. Please use +, -, *, or /");
            break;
    }
    
    // Ask if user wants to perform another calculation
    Console.Write("\nDo you want to perform another calculation? (y/n): ");
    continueCalculating = Console.ReadLine();
}

Console.WriteLine("Thank you for using the calculator. Goodbye!");
