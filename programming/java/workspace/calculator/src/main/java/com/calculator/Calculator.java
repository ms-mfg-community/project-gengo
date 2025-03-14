import java.util.Scanner;

/**
 * A simple calculator application that performs basic arithmetic operations.
 */
public class Calculator {
    
    private static final Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        boolean continueCalculating = true;
        
        System.out.println("Welcome to the Simple Calculator!");
        
        while (continueCalculating) {
            // Get user input
            double firstNumber = getNumberInput("Enter the first number: ");
            double secondNumber = getNumberInput("Enter the second number: ");
            char operator = getOperatorInput();
            
            // Perform calculation and display result
            double result = calculate(firstNumber, secondNumber, operator);
            System.out.println("Result: " + result);
            
            // Ask if user wants to continue
            continueCalculating = askToContinue();
        }
        
        System.out.println("Thank you for using the Simple Calculator. Goodbye!");
        scanner.close();
    }
    
    /**
     * Prompts user for a numeric input and validates it.
     * 
     * @param prompt Message to display to the user
     * @return The valid number entered by the user
     */
    private static double getNumberInput(String prompt) {
        double number;
        while (true) {
            try {
                System.out.print(prompt);
                number = Double.parseDouble(scanner.nextLine());
                return number;
            } catch (NumberFormatException e) {
                System.out.println("Invalid input. Please enter a valid number.");
            }
        }
    }
    
    /**
     * Gets and validates the operator from the user.
     * 
     * @return A valid arithmetic operator (+, -, *, /)
     */
    private static char getOperatorInput() {
        while (true) {
            System.out.print("Enter the operator (+, -, *, /): ");
            String input = scanner.nextLine().trim();
            
            if (input.length() == 1 && "+-*/".contains(input)) {
                return input.charAt(0);
            }
            System.out.println("Invalid operator. Please enter +, -, *, or /.");
        }
    }
    
    /**
     * Performs the calculation based on the provided operands and operator.
     * 
     * @param first First operand
     * @param second Second operand
     * @param operator Arithmetic operator
     * @return Result of the calculation
     */
    static double calculate(double first, double second, char operator) {
        switch (operator) {
            case '+':
                return first + second;
            case '-':
                return first - second;
            case '*':
                return first * second;
            case '/':
                if (second == 0) {
                    System.out.println("Warning: Division by zero is not allowed!");
                    return 0;
                }
                return first / second;
            default:
                // This should never happen due to input validation
                throw new IllegalArgumentException("Unsupported operator: " + operator);
        }
    }
    
    /**
     * Asks the user if they want to perform another calculation.
     * 
     * @return true if the user wants to continue, false otherwise
     */
    private static boolean askToContinue() {
        while (true) {
            System.out.print("Do you want to perform another calculation? (yes/no): ");
            String response = scanner.nextLine().trim().toLowerCase();
            
            if (response.equals("yes")) {
                return true;
            } else if (response.equals("no")) {
                return false;
            } else {
                System.out.println("Please enter 'yes' or 'no'.");
            }
        }
    }
}