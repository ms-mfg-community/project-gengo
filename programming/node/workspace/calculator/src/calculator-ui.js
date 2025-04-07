// Import the Calculator class
import { Calculator } from './calculator.js';

// Initialize the calculator
class CalculatorUI {
    constructor() {
        this.calculator = new Calculator();
        this.displayValue = '0';
        this.firstOperand = null;
        this.waitingForSecondOperand = false;
        this.operator = null;
        this.lastResult = null;

        this.display = document.getElementById('display');
        this.initEventListeners();
    }

    initEventListeners() {
        document.querySelector('.calculator-keys').addEventListener('click', (event) => {
            const target = event.target;

            // If the clicked element is not a button, exit the function
            if (!target.matches('button')) {
                return;
            }

            // Handle different button types
            if (target.classList.contains('number')) {
                this.inputDigit(target.dataset.digit);
            } else if (target.classList.contains('decimal')) {
                this.inputDecimal();
            } else if (target.classList.contains('operator')) {
                this.handleOperator(target.dataset.action);
            } else if (target.classList.contains('equals')) {
                this.handleCalculate();
            } else if (target.classList.contains('clear')) {
                this.clear();
            } else if (target.classList.contains('backspace')) {
                this.backspace();
            }

            this.updateDisplay();
        });

        // Add keyboard support
        document.addEventListener('keydown', (event) => {
            // Numbers
            if (/^\d$/.test(event.key)) {
                event.preventDefault();
                this.inputDigit(event.key);
            }
            // Decimal
            else if (event.key === '.') {
                event.preventDefault();
                this.inputDecimal();
            }
            // Operators
            else if (['+', '-', '*', '/', '^', '%'].includes(event.key)) {
                event.preventDefault();
                const operatorMap = {
                    '+': 'add',
                    '-': 'subtract',
                    '*': 'multiply',
                    '/': 'divide',
                    '%': 'modulo',
                    '^': 'exponent'
                };
                this.handleOperator(operatorMap[event.key]);
            }
            // Enter/Equal key
            else if (event.key === 'Enter' || event.key === '=') {
                event.preventDefault();
                this.handleCalculate();
            }
            // Backspace
            else if (event.key === 'Backspace') {
                event.preventDefault();
                this.backspace();
            }
            // Clear with 'c' or 'Escape'
            else if (event.key === 'c' || event.key === 'Escape') {
                event.preventDefault();
                this.clear();
            }

            this.updateDisplay();
        });
    }

    inputDigit(digit) {
        if (this.waitingForSecondOperand) {
            this.displayValue = digit;
            this.waitingForSecondOperand = false;
        } else {
            this.displayValue = this.displayValue === '0' ? digit : this.displayValue + digit;
        }
    }

    inputDecimal() {
        // If the display already contains a decimal point, exit the function
        if (this.displayValue.includes('.')) {
            return;
        }

        // If waiting for second operand, start with '0.'
        if (this.waitingForSecondOperand) {
            this.displayValue = '0.';
            this.waitingForSecondOperand = false;
        } else {
            this.displayValue += '.';
        }
    }

    handleOperator(nextOperator) {
        const value = parseFloat(this.displayValue);

        // If there's an existing operation and we were waiting 
        // for the second operand, update the operator and exit
        if (this.operator && this.waitingForSecondOperand) {
            this.operator = nextOperator;
            return;
        }

        // If there's no first operand yet, store it
        if (this.firstOperand === null) {
            this.firstOperand = value;
        } 
        // If there's already a first operand and an operation stored,
        // perform the operation before storing the new one
        else if (this.operator) {
            const result = this.performCalculation();
            this.displayValue = String(result);
            this.firstOperand = result;
            this.lastResult = result;
        }

        this.waitingForSecondOperand = true;
        this.operator = nextOperator;
    }

    performCalculation() {
        const secondOperand = parseFloat(this.displayValue);
        
        if (isNaN(this.firstOperand) || isNaN(secondOperand)) {
            return this.displayValue;
        }
        
        let result;
        
        try {
            switch (this.operator) {
                case 'add':
                    result = this.calculator.add(this.firstOperand, secondOperand);
                    break;
                case 'subtract':
                    result = this.calculator.subtract(this.firstOperand, secondOperand);
                    break;
                case 'multiply':
                    result = this.calculator.multiply(this.firstOperand, secondOperand);
                    break;
                case 'divide':
                    result = this.calculator.divide(this.firstOperand, secondOperand);
                    break;
                case 'modulo':
                    result = this.calculator.modulo(this.firstOperand, secondOperand);
                    break;
                case 'exponent':
                    result = this.calculator.exponent(this.firstOperand, secondOperand);
                    break;
                default:
                    return this.displayValue;
            }
            
            return result;
        } catch (error) {
            this.displayValue = error.message;
            this.firstOperand = null;
            this.waitingForSecondOperand = false;
            this.operator = null;
            return 'Error';
        }
    }

    handleCalculate() {
        // If there's no stored operation, nothing to calculate
        if (this.firstOperand === null || this.operator === null) {
            return;
        }

        const result = this.performCalculation();
        
        // Only update if we didn't get an error
        if (result !== 'Error') {
            this.displayValue = String(result);
            this.lastResult = result;
        }
        
        // Reset for new calculation
        this.firstOperand = null;
        this.waitingForSecondOperand = false;
        this.operator = null;
    }

    clear() {
        this.displayValue = '0';
        this.firstOperand = null;
        this.waitingForSecondOperand = false;
        this.operator = null;
    }

    backspace() {
        // If waiting for second operand, clear the display and start over
        if (this.waitingForSecondOperand) {
            this.displayValue = '0';
            this.waitingForSecondOperand = false;
            return;
        }
        
        this.displayValue = this.displayValue.length > 1 
            ? this.displayValue.slice(0, -1) 
            : '0';
    }

    updateDisplay() {
        this.display.textContent = this.displayValue;
    }
}

// Initialize the calculator when the DOM is fully loaded
let calculatorInstance;

function initCalculator() {
    calculatorInstance = new CalculatorUI();
}

// Initialize on DOM load
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCalculator);
} else {
    initCalculator();
}

// Add hot module replacement support
if (import.meta.hot) {
    import.meta.hot.accept((newModule) => {
        console.log('🔄 Calculator UI updated');
    });
}