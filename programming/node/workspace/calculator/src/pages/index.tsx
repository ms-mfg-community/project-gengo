import React, { useState } from 'react';
import './index.css';

export function Page() {
  const [display, setDisplay] = useState('0');
  const [firstOperand, setFirstOperand] = useState<number | null>(null);
  const [operator, setOperator] = useState<string | null>(null);
  const [waitingForSecondOperand, setWaitingForSecondOperand] = useState(false);

  const inputDigit = (digit: string) => {
    if (waitingForSecondOperand) {
      setDisplay(digit);
      setWaitingForSecondOperand(false);
    } else {
      setDisplay(display === '0' ? digit : display + digit);
    }
  };

  const inputDecimal = () => {
    if (waitingForSecondOperand) {
      setDisplay('0.');
      setWaitingForSecondOperand(false);
      return;
    }

    if (!display.includes('.')) {
      setDisplay(display + '.');
    }
  };

  const clearDisplay = () => {
    setDisplay('0');
    setFirstOperand(null);
    setOperator(null);
    setWaitingForSecondOperand(false);
  };

  const performOperation = (nextOperator: string) => {
    const inputValue = parseFloat(display);

    if (firstOperand === null) {
      setFirstOperand(inputValue);
    } else if (operator) {
      const result = calculate(firstOperand, inputValue, operator);
      setDisplay(String(result));
      setFirstOperand(result);
    }

    setWaitingForSecondOperand(true);
    setOperator(nextOperator);
  };

  const calculate = (firstOperand: number, secondOperand: number, operator: string): number => {
    switch (operator) {
      case '+':
        return firstOperand + secondOperand;
      case '-':
        return firstOperand - secondOperand;
      case '*':
        return firstOperand * secondOperand;
      case '/':
        return firstOperand / secondOperand;
      default:
        return secondOperand;
    }
  };

  const handleEquals = () => {
    if (firstOperand === null || operator === null) {
      return;
    }

    const inputValue = parseFloat(display);
    const result = calculate(firstOperand, inputValue, operator);
    
    setDisplay(String(result));
    setFirstOperand(result);
    setOperator(null);
    setWaitingForSecondOperand(true);
  };

  return (
    <div className="calculator">
      <h1>Calculator</h1>
      <div className="calculator-display">{display}</div>
      <div className="calculator-keypad">
        <div className="input-keys">
          <div className="function-keys">
            <button className="calculator-key key-clear" onClick={clearDisplay}>AC</button>
          </div>
          <div className="digit-keys">
            <button className="calculator-key key-0" onClick={() => inputDigit('0')}>0</button>
            <button className="calculator-key key-dot" onClick={inputDecimal}>.</button>
            <button className="calculator-key key-1" onClick={() => inputDigit('1')}>1</button>
            <button className="calculator-key key-2" onClick={() => inputDigit('2')}>2</button>
            <button className="calculator-key key-3" onClick={() => inputDigit('3')}>3</button>
            <button className="calculator-key key-4" onClick={() => inputDigit('4')}>4</button>
            <button className="calculator-key key-5" onClick={() => inputDigit('5')}>5</button>
            <button className="calculator-key key-6" onClick={() => inputDigit('6')}>6</button>
            <button className="calculator-key key-7" onClick={() => inputDigit('7')}>7</button>
            <button className="calculator-key key-8" onClick={() => inputDigit('8')}>8</button>
            <button className="calculator-key key-9" onClick={() => inputDigit('9')}>9</button>
          </div>
        </div>
        <div className="operator-keys">
          <button className="calculator-key key-divide" onClick={() => performOperation('/')}>÷</button>
          <button className="calculator-key key-multiply" onClick={() => performOperation('*')}>×</button>
          <button className="calculator-key key-subtract" onClick={() => performOperation('-')}>−</button>
          <button className="calculator-key key-add" onClick={() => performOperation('+')}>+</button>
          <button className="calculator-key key-equals" onClick={handleEquals}>=</button>
        </div>
      </div>
    </div>
  );
}

export const documentProps = {
  title: 'Calculator App',
  description: 'A simple calculator app built with React and SSR'
};