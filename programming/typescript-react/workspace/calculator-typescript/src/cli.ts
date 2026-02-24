import * as readline from 'readline';
import { Calculator } from './calculator';

/**
 * Command Line Interface for the Calculator application
 */
class CalculatorCLI {
    private rl: readline.Interface;

    /**
     * Initializes the CLI with readline interface
     */
    constructor() {
        this.rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
    }

    /**
     * Prompts the user for input and returns a promise
     * @param question - The question to ask the user
     * @returns A promise that resolves with the user's input
     */
    private question(question: string): Promise<string> {
        return new Promise((resolve) => {
            this.rl.question(question, (answer) => {
                resolve(answer);
            });
        });
    }

    /**
     * Gets numeric input from the user with validation
     * @param prompt - The prompt to display to the user
     * @returns A promise that resolves with a valid number
     */
    private async getNumericInput(prompt: string): Promise<number> {
        while (true) {
            const input = await this.question(prompt);
            const num = parseFloat(input);
            
            if (!isNaN(num)) {
                return num;
            }
            console.log("Invalid input. Please enter a valid number.");
        }
    }

    /**
     * Gets and validates operator input from the user
     * @param prompt - The prompt to display to the user
     * @returns A promise that resolves with a valid operator
     */
    private async getOperator(prompt: string): Promise<string> {
        while (true) {
            const input = await this.question(prompt);
            const operator = input.trim();
            
            if (!operator) {
                console.log("Invalid operator. Please enter +, -, *, /, %, or ^");
                continue;
            }
            
            if (Calculator.isValidOperator(operator)) {
                return operator;
            }
            console.log("Invalid operator. Please enter +, -, *, /, %, or ^");
        }
    }

    /**
     * Clears the console screen
     */
    private clearScreen(): void {
        console.clear();
    }

    /**
     * Main loop for the calculator application
     */
    public async run(): Promise<void> {
        let continueCalculating = true;

        while (continueCalculating) {
            this.clearScreen();
            console.log("=== Simple Calculator ===\n");

            // Get first operand
            const firstOperand = await this.getNumericInput("Enter first operand: ");

            // Get second operand
            const secondOperand = await this.getNumericInput("Enter second operand: ");

            // Get operator
            const operator = await this.getOperator("Enter operator (+, -, *, /, %, ^): ");

            // Perform calculation
            const result = Calculator.performCalculation(firstOperand, operator, secondOperand);

            if (isNaN(result)) {
                console.log("\nError: Invalid operation");
            } else {
                console.log(`\nResult: ${firstOperand} ${operator} ${secondOperand} = ${result}`);
            }

            // Ask if user wants to continue
            const response = await this.question("\nDo you want to perform another calculation? (yes/no): ");
            continueCalculating = response.toLowerCase() === "yes" || response.toLowerCase() === "y";
        }

        console.log("\nThank you for using the calculator. Goodbye!");
        this.rl.close();
    }
}

/**
 * Main entry point for the calculator application
 */
async function main(): Promise<void> {
    const cli = new CalculatorCLI();
    await cli.run();
}

// Run the application
main().catch((error) => {
    console.error("An error occurred:", error);
    process.exit(1);
});
