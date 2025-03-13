package calculator.src.main.java.com.project13;

import java.util.Scanner;

/**
 * Simple Calculator application
 */
public class App {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean continueCalculating = true;

        clearScreen();
        System.out.println("Welcome to Simple Calculator!");

        while (continueCalculating) {
            try {
                // Get first operand
                System.out.print("Enter the first number: ");
                double firstNumber = scanner.nextDouble();

                // Get second operand
                System.out.print("Enter the second number: ");
                double secondNumber = scanner.nextDouble();

                // Get operator
                System.out.print("Enter the operator (+, -, *, /, %, ^): ");
                String operator = scanner.next();

                // Perform calculation
                CalculationResult calculationResult = calculate(firstNumber, secondNumber, operator);

                if (calculationResult.isValidOperation()) {
                    System.out.println("Result: " + calculationResult.getResult());
                }

                // Ask to continue
                System.out.print("Do you want to perform another calculation? (yes/no): ");
                String response = scanner.next().toLowerCase();

                clearScreen();

                if (!response.equals("yes")) {
                    continueCalculating = false;
                }

            } catch (Exception e) {
                System.out.println("Invalid input. Please try again.");
                scanner.nextLine(); // Clear the input buffer
            }
        }

        System.out.println("Thank you for using Simple Calculator! Goodbye!");
        scanner.close();
    }

    /**
     * Performs a calculation based on two operands and an operator
     * 
     * @param firstNumber The first operand
     * @param secondNumber The second operand
     * @param operator The operation to perform (+, -, *, /, %, ^)
     * @return A CalculationResult containing the result and operation validity
     */
    public static CalculationResult calculate(double firstNumber, double secondNumber, String operator) {
        switch (operator) {
            case "+":
                return new CalculationResult(add(firstNumber, secondNumber), true);
            case "-":
                return new CalculationResult(subtract(firstNumber, secondNumber), true);
            case "*":
                return new CalculationResult(multiply(firstNumber, secondNumber), true);
            case "/":
                return divide(firstNumber, secondNumber);
            case "%":
                return modulo(firstNumber, secondNumber);
            case "^":
                return new CalculationResult(power(firstNumber, secondNumber), true);
            default:
                System.out.println("Invalid operator entered.");
                return new CalculationResult(0, false);
        }
    }

    /**
     * Adds two numbers
     * 
     * @param a First number
     * @param b Second number
     * @return Sum of both numbers
     */
    public static double add(double a, double b) {
        return a + b;
    }

    /**
     * Subtracts second number from first number
     * 
     * @param a First number
     * @param b Second number
     * @return a - b
     */
    public static double subtract(double a, double b) {
        return a - b;
    }

    /**
     * Multiplies two numbers
     * 
     * @param a First number
     * @param b Second number
     * @return Product of both numbers
     */
    public static double multiply(double a, double b) {
        return a * b;
    }

    /**
     * Divides first number by second number
     * 
     * @param a First number
     * @param b Second number
     * @return CalculationResult containing result and validity
     */
    public static CalculationResult divide(double a, double b) {
        if (b == 0) {
            System.out.println("Error: Cannot divide by zero!");
            return new CalculationResult(0, false);
        } else {
            return new CalculationResult(a / b, true);
        }
    }

    /**
     * Calculates modulo of first number by second number
     * 
     * @param a First number
     * @param b Second number
     * @return CalculationResult containing result and validity
     */
    public static CalculationResult modulo(double a, double b) {
        if (b == 0) {
            System.out.println("Error: Cannot perform modulo with zero!");
            return new CalculationResult(0, false);
        } else {
            return new CalculationResult(a % b, true);
        }
    }

    /**
     * Raises first number to power of second number
     * 
     * @param a Base
     * @param b Exponent
     * @return a raised to power of b
     */
    public static double power(double a, double b) {
        return Math.pow(a, b);
    }

    private static void clearScreen() {
        try {
            // Try ANSI escape code first (works in most terminals)
            System.out.print("\033[H\033[2J");
            System.out.flush();

            // Try system command as backup
            String os = System.getProperty("os.name").toLowerCase();
            if (os.contains("win")) {
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            } else {
                new ProcessBuilder("clear").inheritIO().start().waitFor();
            }
        } catch (Exception e) {
            // Fallback: just print many newlines
            for (int i = 0; i < 100; i++) {
                System.out.println();
            }
        }
    }
}