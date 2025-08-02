/**
 * Browser-compatible Calculator
 * Browser-kompatible Rechner
 * ब्राउज़र-संगत कैलकुलेटर
 * ブラウザ互換電卓
 */

class Calculator {
    constructor() {
        this.currentInput = '';
        this.shouldResetDisplay = false;
        
        // Initialize display element
        this.display = document.getElementById('display');
        this.initializeEventListeners();
    }

    initializeEventListeners() {
        document.addEventListener('keydown', (event) => {
            this.handleKeyboardInput(event);
        });
    }

    handleKeyboardInput(event) {
        const key = event.key;

        if (/[0-9.]/.test(key)) {
            this.appendToDisplay(key);
        } else if (['+', '-', '*', '/', '%'].includes(key)) {
            this.appendToDisplay(key === '*' ? '*' : key);
        } else if (key === 'Enter' || key === '=') {
            event.preventDefault();
            this.calculate();
        } else if (key === 'Escape' || key === 'c' || key === 'C') {
            this.clearDisplay();
        } else if (key === 'Backspace') {
            this.deleteLast();
        }
    }

    appendToDisplay(value) {
        if (this.shouldResetDisplay) {
            this.display.value = '';
            this.shouldResetDisplay = false;
        }

        // Handle special cases
        if (value === '**') {
            this.display.value += '^';
        } else if (value === '*') {
            this.display.value += '×';
        } else {
            this.display.value += value;
        }

        this.currentInput = this.display.value;
    }

    clearDisplay() {
        this.display.value = '';
        this.currentInput = '';
        this.shouldResetDisplay = false;
    }

    clearEntry() {
        this.display.value = '';
        this.currentInput = '';
    }

    deleteLast() {
        if (this.display.value.length > 0) {
            this.display.value = this.display.value.slice(0, -1);
            this.currentInput = this.display.value;
        }
    }

    calculate() {
        try {
            if (!this.currentInput && !this.display.value) {
                return;
            }

            // Prepare expression for evaluation
            let expression = this.display.value;
            
            // Replace visual operators with JavaScript operators
            expression = expression
                .replace(/×/g, '*')
                .replace(/\^/g, '**')
                .replace(/÷/g, '/');

            // Validate expression
            if (!this.isValidExpression(expression)) {
                throw new Error('Invalid expression');
            }

            // Calculate result
            const result = this.evaluateExpression(expression);
            
            // Display result
            this.display.value = this.formatResult(result);
            this.currentInput = this.display.value;
            this.shouldResetDisplay = true;

        } catch (error) {
            // Handle calculation errors
            this.display.value = 'Error';
            this.shouldResetDisplay = true;
            console.error('Calculation error:', error);
        }
    }

    isValidExpression(expression) {
        // Check for invalid characters
        const validPattern = /^[0-9+\-*/.%() ]+$/;
        if (!validPattern.test(expression)) {
            return false;
        }

        // Check for balanced parentheses
        let parenthesesCount = 0;
        for (const char of expression) {
            if (char === '(') parenthesesCount++;
            if (char === ')') parenthesesCount--;
            if (parenthesesCount < 0) return false;
        }

        return parenthesesCount === 0;
    }

    evaluateExpression(expression) {
        // Use Function constructor for safe evaluation
        const sanitizedExpression = expression.replace(/[^0-9+\-*/.%() ]/g, '');
        return Function('"use strict"; return (' + sanitizedExpression + ')')();
    }

    formatResult(result) {
        // Handle special cases
        if (!isFinite(result)) {
            return 'Error';
        }

        // Format to avoid floating point precision issues
        if (result % 1 === 0) {
            return result.toString();
        } else {
            return parseFloat(result.toFixed(10)).toString();
        }
    }

    // Static methods for basic operations
    static add(a, b) {
        return a + b;
    }

    static subtract(a, b) {
        return a - b;
    }

    static multiply(a, b) {
        return a * b;
    }

    static divide(a, b) {
        if (b === 0) {
            throw new Error('Division by zero');
        }
        return a / b;
    }

    static modulo(a, b) {
        if (b === 0) {
            throw new Error('Modulo by zero');
        }
        return a % b;
    }

    static power(base, exponent) {
        return Math.pow(base, exponent);
    }
}

// Global variables and functions for HTML onclick events
let calculatorInstance;

// Initialize calculator when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    calculatorInstance = new Calculator();
});

// Global functions accessible from HTML
function appendToDisplay(value) {
    if (calculatorInstance) {
        calculatorInstance.appendToDisplay(value);
    }
}

function clearDisplay() {
    if (calculatorInstance) {
        calculatorInstance.clearDisplay();
    }
}

function clearEntry() {
    if (calculatorInstance) {
        calculatorInstance.clearEntry();
    }
}

function deleteLast() {
    if (calculatorInstance) {
        calculatorInstance.deleteLast();
    }
}

function calculate() {
    if (calculatorInstance) {
        calculatorInstance.calculate();
    }
}
