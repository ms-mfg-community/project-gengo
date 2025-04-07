import { Calculator } from './calculator';
import * as readline from 'readline';

const calculator = new Calculator();
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

console.log('Simple Calculator App');
console.log('Available operations: add, subtract, multiply, divide, modulo, exponent');

function promptCalculation(): void {
    rl.question('Enter operation (e.g., add 5 3) or type "exit" to quit: ', (input) => {
        if (input.toLowerCase() === 'exit') {
            rl.close();
            return;
        }

        const parts = input.split(' ');
        if (parts.length !== 3) {
            console.log('Invalid input format. Please use: operation number1 number2');
            promptCalculation();
            return;
        }

        const [operation, aStr, bStr] = parts;
        const a = parseFloat(aStr);
        const b = parseFloat(bStr);

        if (isNaN(a) || isNaN(b)) {
            console.log('Invalid numbers provided. Please enter valid numbers.');
            promptCalculation();
            return;
        }

        try {
            let result: number;
            switch (operation.toLowerCase()) {
                case 'add':
                    result = calculator.add(a, b);
                    break;
                case 'subtract':
                    result = calculator.subtract(a, b);
                    break;
                case 'multiply':
                    result = calculator.multiply(a, b);
                    break;
                case 'divide':
                    result = calculator.divide(a, b);
                    break;
                case 'modulo':
                    result = calculator.modulo(a, b);
                    break;
                case 'exponent':
                    result = calculator.exponent(a, b);
                    break;
                default:
                    console.log('Unknown operation. Available operations: add, subtract, multiply, divide, modulo, exponent');
                    promptCalculation();
                    return;
            }

            console.log(`Result: ${result}`);
        }
        catch (error) {
            if (error instanceof Error) {
                console.log(`Error: ${error.message}`);
            } else {
                console.log(`Error: ${String(error)}`);
            }
        }

        promptCalculation();
    });
}

promptCalculation();

rl.on('close', () => {
    console.log('Calculator app closed.');
    process.exit(0);
});