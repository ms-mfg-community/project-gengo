import { Calculator } from './calculator.js';
import * as readline from 'readline';
// Create calculator instance
const calculator = new Calculator();
// Create readline interface for user input
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
// Display welcome message and instructions
console.log('\nCalculator Application');
console.log('=====================');
console.log('Available operations:');
console.log('1. Addition (+)');
console.log('2. Subtraction (-)');
console.log('3. Multiplication (*)');
console.log('4. Division (/)');
console.log('5. Modulo (%)');
console.log('6. Exponent (^)');
console.log('Type "exit" to quit the application\n');
// Main application loop
function promptCalculation() {
    rl.question('Enter calculation (e.g. 5 + 3): ', (input) => {
        // Check for exit command
        if (input.toLowerCase() === 'exit') {
            console.log('Exiting calculator. Goodbye!');
            rl.close();
            return;
        }
        try {
            // Parse the input
            const parts = input.trim().split(' ');
            // Basic validation
            if (parts.length !== 3) {
                console.log('Invalid input format. Please use format: number operator number');
                promptCalculation();
                return;
            }
            const a = parseFloat(parts[0]);
            const operator = parts[1];
            const b = parseFloat(parts[2]);
            // Validate numbers
            if (isNaN(a) || isNaN(b)) {
                console.log('Please enter valid numbers');
                promptCalculation();
                return;
            }
            let result;
            // Perform calculation based on operator
            switch (operator) {
                case '+':
                    result = calculator.add(a, b);
                    break;
                case '-':
                    result = calculator.subtract(a, b);
                    break;
                case '*':
                    result = calculator.multiply(a, b);
                    break;
                case '/':
                    result = calculator.divide(a, b);
                    break;
                case '%':
                    result = calculator.modulo(a, b);
                    break;
                case '^':
                    result = calculator.power(a, b);
                    break;
                default:
                    console.log('Unknown operator. Please use +, -, *, /, %, or ^');
                    promptCalculation();
                    return;
            }
            console.log(`Result: ${result}`);
        }
        catch (error) {
            if (error instanceof Error) {
                console.log(`Error: ${error.message}`);
            }
            else {
                console.log('An unknown error occurred');
            }
        }
        // Continue with next calculation
        promptCalculation();
    });
}
// Start the application
promptCalculation();
