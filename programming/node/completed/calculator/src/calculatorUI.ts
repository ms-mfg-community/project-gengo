import { Calculator } from './calculator';

export class CalculatorUI {
  private calculator: Calculator;
  private display: HTMLInputElement;
  private currentInput: string = '';
  private firstOperand: number | null = null;
  private waitingForSecondOperand: boolean = false;
  private operator: string | null = null;

  constructor() {
    this.calculator = new Calculator();
    this.display = document.getElementById('result') as HTMLInputElement;
    this.initEventListeners();
  }

  private initEventListeners(): void {
    // Number buttons
    const numberButtons = document.querySelectorAll('.number');
    numberButtons.forEach(button => {
      button.addEventListener('click', () => {
        this.inputDigit((button as HTMLElement).getAttribute('data-number') || '');
      });
    });

    // Operator buttons
    const operatorButtons = document.querySelectorAll('.operator');
    operatorButtons.forEach(button => {
      button.addEventListener('click', () => {
        const operatorAttr = (button as HTMLElement).getAttribute('data-operator');
        if (operatorAttr) {
          this.handleOperator(operatorAttr);
        }
      });
    });

    // Equals button
    const equalsButton = document.getElementById('equals');
    if (equalsButton) {
      equalsButton.addEventListener('click', () => this.handleEquals());
    }

    // Clear button
    const clearButton = document.getElementById('clear');
    if (clearButton) {
      clearButton.addEventListener('click', () => this.resetCalculator());
    }

    // Backspace button
    const backspaceButton = document.getElementById('backspace');
    if (backspaceButton) {
      backspaceButton.addEventListener('click', () => this.handleBackspace());
    }
  }

  private updateDisplay(): void {
    this.display.value = this.currentInput || '0';
  }

  private inputDigit(digit: string): void {
    if (this.waitingForSecondOperand) {
      this.currentInput = digit;
      this.waitingForSecondOperand = false;
    } else {
      // Don't allow multiple decimal points
      if (digit === '.' && this.currentInput.includes('.')) return;
      // Replace '0' with digit, or append digit
      this.currentInput = this.currentInput === '0' ? digit : this.currentInput + digit;
    }
    this.updateDisplay();
  }

  private handleOperator(nextOperator: string): void {
    const inputValue = parseFloat(this.currentInput);
    
    if (this.firstOperand === null) {
      this.firstOperand = inputValue;
    } else if (this.operator) {
      const result = this.performCalculation(this.operator, inputValue);
      this.currentInput = String(result);
      this.firstOperand = result;
      this.updateDisplay();
    }
    
    this.waitingForSecondOperand = true;
    this.operator = nextOperator;
  }

  private performCalculation(operator: string, secondOperand: number): number {
    if (this.firstOperand === null) return secondOperand;
    
    try {
      switch (operator) {
        case '+':
          return this.calculator.add(this.firstOperand, secondOperand);
        case '-':
          return this.calculator.subtract(this.firstOperand, secondOperand);
        case '*':
          return this.calculator.multiply(this.firstOperand, secondOperand);
        case '/':
          return this.calculator.divide(this.firstOperand, secondOperand);
        case '%':
          return this.calculator.modulo(this.firstOperand, secondOperand);
        case '^':
          return this.calculator.power(this.firstOperand, secondOperand);
        default:
          return secondOperand;
      }
    } catch (error) {
      if (error instanceof Error) {
        alert(`Error: ${error.message}`);
      } else {
        alert('An unknown error occurred');
      }
      this.resetCalculator();
      return 0;
    }
  }

  private handleEquals(): void {
    if (this.firstOperand === null || this.operator === null) return;
    
    const secondOperand = parseFloat(this.currentInput);
    const result = this.performCalculation(this.operator, secondOperand);
    
    this.currentInput = String(result);
    this.updateDisplay();
    
    // Reset for new calculation but keep the result
    this.firstOperand = null;
    this.operator = null;
    this.waitingForSecondOperand = false;
  }

  private resetCalculator(): void {
    this.currentInput = '0';
    this.firstOperand = null;
    this.waitingForSecondOperand = false;
    this.operator = null;
    this.updateDisplay();
  }

  private handleBackspace(): void {
    if (this.waitingForSecondOperand) return;
    
    this.currentInput = this.currentInput.slice(0, -1);
    if (this.currentInput === '') {
      this.currentInput = '0';
    }
    this.updateDisplay();
  }
}

// Initialize the calculator UI when the DOM is fully loaded
let calculatorInstance: CalculatorUI | null = null;

function initCalculator() {
  calculatorInstance = new CalculatorUI();
}

document.addEventListener('DOMContentLoaded', initCalculator);

// Support for Hot Module Replacement
if (import.meta.hot) {
  import.meta.hot.accept((newModule) => {
    console.log('Calculator UI module updated');
    // Remove existing event listeners (if needed)
    
    // Initialize new instance with the updated code
    initCalculator();
  });
}