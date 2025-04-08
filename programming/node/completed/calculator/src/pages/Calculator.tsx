import React, { useState } from 'react';
import '../App.css';

// Separate functions for arithmetic operations
const add = (a: number, b: number): number => {
  return a + b;
};

const subtract = (a: number, b: number): number => {
  return a - b;
};

const multiply = (a: number, b: number): number => {
  return a * b;
};

const divide = (a: number, b: number): number => {
  if (b === 0) {
    throw new Error("Cannot divide by zero");
  }
  return a / b;
};

// Add modulo operation
const modulo = (a: number, b: number): number => {
  if (b === 0) {
    throw new Error("Cannot find modulo with zero");
  }
  return a % b;
};

// Add exponent operation
const exponent = (a: number, b: number): number => {
  return Math.pow(a, b);
};

const Calculator: React.FC = () => {
  // State for managing display and calculations
  const [display, setDisplay] = useState<string>('0');
  const [firstOperand, setFirstOperand] = useState<string>('');
  const [operation, setOperation] = useState<string | null>(null);
  const [waitingForSecondOperand, setWaitingForSecondOperand] = useState<boolean>(false);
  const [error, setError] = useState<string>('');

  // Handle number input
  const handleNumberInput = (digit: string) => {
    setError('');
    
    if (waitingForSecondOperand) {
      setDisplay(digit);
      setWaitingForSecondOperand(false);
    } else {
      setDisplay(display === '0' ? digit : display + digit);
    }
  };

  // Handle decimal point
  const handleDecimalPoint = () => {
    setError('');
    
    if (waitingForSecondOperand) {
      setDisplay('0.');
      setWaitingForSecondOperand(false);
      return;
    }

    if (!display.includes('.')) {
      setDisplay(display + '.');
    }
  };

  // Handle operator selection
  const handleOperator = (nextOperator: string) => {
    setError('');
    
    const inputValue = parseFloat(display);

    if (firstOperand === '' || operation === null) {
      setFirstOperand(display);
      setWaitingForSecondOperand(true);
      setOperation(nextOperator);
      return;
    }

    // If we already have a pending operation, perform calculation first
    if (operation) {
      const result = performCalculation();
      setDisplay(String(result));
      setFirstOperand(String(result));
    }

    setOperation(nextOperator);
    setWaitingForSecondOperand(true);
  };

  // Perform calculation based on stored operation
  const performCalculation = (): number => {
    const firstValue = parseFloat(firstOperand);
    const secondValue = parseFloat(display);

    try {
      switch (operation) {
        case '+':
          return add(firstValue, secondValue);
        case '-':
          return subtract(firstValue, secondValue);
        case '*':
          return multiply(firstValue, secondValue);
        case '/':
          return divide(firstValue, secondValue);
        case '%':
          return modulo(firstValue, secondValue);
        case '^':
          return exponent(firstValue, secondValue);
        default:
          return secondValue;
      }
    } catch (err) {
      if (err instanceof Error) {
        setError(err.message);
      } else {
        setError('An unexpected error occurred');
      }
      return 0;
    }
  };

  // Handle equals button
  const handleEquals = () => {
    if (operation === null || waitingForSecondOperand) {
      return;
    }

    try {
      const result = performCalculation();
      setDisplay(String(result));
      setFirstOperand('');
      setOperation(null);
      setWaitingForSecondOperand(false);
    } catch (err) {
      if (err instanceof Error) {
        setError(err.message);
      } else {
        setError('An unexpected error occurred');
      }
    }
  };

  // Handle clear button
  const handleClear = () => {
    setDisplay('0');
    setFirstOperand('');
    setOperation(null);
    setWaitingForSecondOperand(false);
    setError('');
  };

  // Handle backspace button
  const handleBackspace = () => {
    setDisplay(display.length > 1 ? display.slice(0, -1) : '0');
  };

  // Handle plus/minus toggle
  const handlePlusMinus = () => {
    setDisplay(String(parseFloat(display) * -1));
  };

  const buttonStyle = {
    color: 'black'
  };

  return (
    <div className="physical-calculator">
      <div className="calc-display">
        <div className="calc-operation">
          {operation && `${firstOperand} ${operation}`}
        </div>
        <div className="calc-value">{display}</div>
        {error && <div className="calc-error">{error}</div>}
      </div>
      
      <div className="calc-keypad">
        <div className="calc-row">
          <button className="calc-key function-key" onClick={handleClear} style={buttonStyle}>AC</button>
          <button className="calc-key function-key" onClick={handleBackspace} style={buttonStyle}>⌫</button>
          <button className="calc-key function-key" onClick={handlePlusMinus} style={buttonStyle}>±</button>
          <button className="calc-key operator-key" onClick={() => handleOperator('/')} style={buttonStyle}>/</button>
        </div>
        
        <div className="calc-row">
          <button className="calc-key" onClick={() => handleNumberInput('7')} style={buttonStyle}>7</button>
          <button className="calc-key" onClick={() => handleNumberInput('8')} style={buttonStyle}>8</button>
          <button className="calc-key" onClick={() => handleNumberInput('9')} style={buttonStyle}>9</button>
          <button className="calc-key operator-key" onClick={() => handleOperator('*')} style={buttonStyle}>×</button>
        </div>
        
        <div className="calc-row">
          <button className="calc-key" onClick={() => handleNumberInput('4')} style={buttonStyle}>4</button>
          <button className="calc-key" onClick={() => handleNumberInput('5')} style={buttonStyle}>5</button>
          <button className="calc-key" onClick={() => handleNumberInput('6')} style={buttonStyle}>6</button>
          <button className="calc-key operator-key" onClick={() => handleOperator('-')} style={buttonStyle}>-</button>
        </div>
        
        <div className="calc-row">
          <button className="calc-key" onClick={() => handleNumberInput('1')} style={buttonStyle}>1</button>
          <button className="calc-key" onClick={() => handleNumberInput('2')} style={buttonStyle}>2</button>
          <button className="calc-key" onClick={() => handleNumberInput('3')} style={buttonStyle}>3</button>
          <button className="calc-key operator-key" onClick={() => handleOperator('+')} style={buttonStyle}>+</button>
        </div>
        
        <div className="calc-row">
          <button className="calc-key" onClick={() => handleNumberInput('0')} style={buttonStyle}>0</button>
          <button className="calc-key" onClick={handleDecimalPoint} style={buttonStyle}>.</button>
          <button className="calc-key function-key" onClick={() => handleOperator('^')} style={buttonStyle}>^</button>
          <button className="calc-key equals-key" onClick={handleEquals} style={buttonStyle}>=</button>
        </div>
        
        <div className="calc-row">
          <button className="calc-key function-key" onClick={() => handleOperator('%')} style={buttonStyle}>mod</button>
        </div>
      </div>
    </div>
  );
};

export default Calculator;