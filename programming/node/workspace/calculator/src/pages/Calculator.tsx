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
  // State for managing input values and result
  const [firstNumber, setFirstNumber] = useState<string>('');
  const [secondNumber, setSecondNumber] = useState<string>('');
  const [operation, setOperation] = useState<string>('+');
  const [result, setResult] = useState<number | null>(null);
  const [error, setError] = useState<string>('');

  // Handle calculation
  const calculateResult = () => {
    // Reset error state
    setError('');
    
    // Convert string inputs to numbers
    const num1 = parseFloat(firstNumber);
    const num2 = parseFloat(secondNumber);
    
    // Validate inputs
    if (isNaN(num1) || isNaN(num2)) {
      setError('Please enter valid numbers');
      return;
    }

    try {
      let calculationResult: number;
      
      // Perform calculation based on selected operation
      switch (operation) {
        case '+':
          calculationResult = add(num1, num2);
          break;
        case '-':
          calculationResult = subtract(num1, num2);
          break;
        case '*':
          calculationResult = multiply(num1, num2);
          break;
        case '/':
          calculationResult = divide(num1, num2);
          break;
        case '%':
          calculationResult = modulo(num1, num2);
          break;
        case '^':
          calculationResult = exponent(num1, num2);
          break;
        default:
          setError('Invalid operation');
          return;
      }
      
      setResult(calculationResult);
    } catch (err) {
      if (err instanceof Error) {
        setError(err.message);
      } else {
        setError('An unexpected error occurred');
      }
    }
  };

  // Handle form submission
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    calculateResult();
  };

  // Add direct button click handler for redundancy
  const handleButtonClick = () => {
    calculateResult();
  };

  return (
    <div className="calculator-container">
      <h1>Simple Calculator</h1>
      
      <form onSubmit={handleSubmit} className="calculator-form">
        <div className="form-group">
          <label htmlFor="firstNumber">First Number:</label>
          <input
            id="firstNumber"
            type="number"
            value={firstNumber}
            onChange={(e) => setFirstNumber(e.target.value)}
            placeholder="Enter first number"
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="operation">Operation:</label>
          <select
            id="operation"
            value={operation}
            onChange={(e) => setOperation(e.target.value)}
          >
            <option value="+">Addition (+)</option>
            <option value="-">Subtraction (-)</option>
            <option value="*">Multiplication (×)</option>
            <option value="/">Division (÷)</option>
            <option value="%">Modulo (%)</option>
            <option value="^">Exponent (^)</option>
          </select>
        </div>
        
        <div className="form-group">
          <label htmlFor="secondNumber">Second Number:</label>
          <input
            id="secondNumber"
            type="number"
            value={secondNumber}
            onChange={(e) => setSecondNumber(e.target.value)}
            placeholder="Enter second number"
            required
          />
        </div>
        
        <button 
          type="submit" 
          className="calculate-btn" 
          onClick={handleButtonClick}
        >
          Calculate
        </button>
      </form>
      
      {error && <div className="error-message">{error}</div>}
      
      {result !== null && !error && (
        <div className="result-container">
          <h2>Result:</h2>
          <div className="result">
            {firstNumber} {operation} {secondNumber} = {result}
          </div>
        </div>
      )}
    </div>
  );
};

export default Calculator;