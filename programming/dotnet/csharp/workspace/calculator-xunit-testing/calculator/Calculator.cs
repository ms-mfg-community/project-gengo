// Calculator console application using top-level statements
// Supports basic arithmetic operations: +, -, *, /

bool continueCalculation = true;

while (continueCalculation)
{
    // Prompt for first operand
    Console.Write("Enter the first operand: ");
    string? input1 = Console.ReadLine();
    
    // Validate first operand input
    if (string.IsNullOrWhiteSpace(input1) || !double.TryParse(input1, out double operand1))
    {
        Console.WriteLine("Invalid input for first operand. Please enter a valid number.");
        continue;
    } // end if

    // Prompt for second operand
    Console.Write("Enter the second operand: ");
    string? input2 = Console.ReadLine();
    
    // Validate second operand input
    if (string.IsNullOrWhiteSpace(input2) || !double.TryParse(input2, out double operand2))
    {
        Console.WriteLine("Invalid input for second operand. Please enter a valid number.");
        continue;
    } // end if

    // Prompt for operator
    Console.Write("Enter an operator (+, -, *, /): ");
    string? operatorInput = Console.ReadLine();
    
    // Validate operator input
    if (string.IsNullOrWhiteSpace(operatorInput))
    {
        Console.WriteLine("Invalid operator. Please enter a valid operator.");
        continue;
    } // end if

    // Perform calculation based on operator
    double result;
    bool validOperation = true;

    switch (operatorInput)
    {
        case "+":
            result = operand1 + operand2;
            break;
        case "-":
            result = operand1 - operand2;
            break;
        case "*":
            result = operand1 * operand2;
            break;
        case "/":
            if (operand2 == 0)
            {
                Console.WriteLine("Error: Division by zero is not allowed.");
                validOperation = false;
                result = 0;
            } // end if
            else
            {
                result = operand1 / operand2;
            } // end else
            break;
        default:
            Console.WriteLine($"Error: '{operatorInput}' is not a valid operator.");
            validOperation = false;
            result = 0;
            break;
    } // end switch

    // Display result if operation was valid
    if (validOperation)
    {
        Console.WriteLine($"Result: {operand1} {operatorInput} {operand2} = {result}");
    } // end if

    // Ask if user wants to perform another calculation
    Console.Write("\nWould you like to perform another calculation? (y/n): ");
    string? response = Console.ReadLine();
    
    // Handle user response with null checking
    if (string.IsNullOrWhiteSpace(response) || !response.Trim().Equals("y", StringComparison.OrdinalIgnoreCase))
    {
        continueCalculation = false;
        Console.WriteLine("Thank you for using the calculator. Goodbye!");
    } // end if
} // end while
