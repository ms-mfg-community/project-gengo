import React, { useState, useEffect } from 'react';
import { CalculatorKeypad } from './CalculatorKeypad';
import { HistoryPanel } from './HistoryPanel';
import { ThemeToggle } from './ThemeToggle';
import { Calculator } from '../services/Calculator';
import { historyService } from '../services/HistoryService';
import { CalculationRecord } from '../models';
import '../styles/calculator.css';

export const App: React.FC = () => {
  const [display, setDisplay] = useState<string>('0');
  const [firstOperand, setFirstOperand] = useState<number | null>(null);
  const [secondOperand, setSecondOperand] = useState<number>(0);
  const [operator, setOperator] = useState<string | null>(null);
  const [waitingForOperand, setWaitingForOperand] = useState<boolean>(false);
  const [history, setHistory] = useState<CalculationRecord[]>([]);
  const [historyLoading, setHistoryLoading] = useState<boolean>(false);

  // Load history on mount
  useEffect(() => {
    const loadHistory = async () => {
      setHistoryLoading(true);
      try {
        const data = await historyService.getHistory();
        setHistory(data);
      } finally {
        setHistoryLoading(false);
      }
    };
    loadHistory();
  }, []);

  // Keyboard support
  useEffect(() => {
    const handleKeyPress = (e: KeyboardEvent) => {
      if (/^\d$/.test(e.key)) {
        handleNumberClick(e.key);
      } else if (e.key === '.') {
        handleNumberClick('.');
      } else if (e.key === '+' || e.key === '-' || e.key === '*' || e.key === '/') {
        handleOperatorClick(e.key);
      } else if (e.key === '^') {
        handleOperatorClick('^');
      } else if (e.key === 'Enter' || e.key === '=') {
        handleEquals();
      } else if (e.key === 'Backspace' || e.key === 'Delete' || e.key.toLowerCase() === 'c') {
        handleClear();
      }
    };

    window.addEventListener('keydown', handleKeyPress);
    return () => window.removeEventListener('keydown', handleKeyPress);
  }, [display, firstOperand, secondOperand, operator, waitingForOperand]);

  const handleNumberClick = (digit: string) => {
    let newDisplay = display;

    if (waitingForOperand) {
      newDisplay = digit === '.' ? '0.' : digit;
      setWaitingForOperand(false);
    } else {
      if (digit === '.' && display.includes('.')) {
        return; // Prevent multiple decimals
      }
      newDisplay = display === '0' && digit !== '.' ? digit : display + digit;
    }

    setDisplay(newDisplay);
  };

  const handleOperatorClick = (op: string) => {
    const inputValue = parseFloat(display);

    if (firstOperand === null) {
      setFirstOperand(inputValue);
    } else if (operator && !waitingForOperand) {
      // Chained calculation
      const result = Calculator.performCalculation(firstOperand, operator, inputValue);
      setDisplay(String(result));
      setFirstOperand(result);
    }

    setOperator(op);
    setWaitingForOperand(true);
  };

  const handleEquals = async () => {
    if (firstOperand === null || operator === null || waitingForOperand) {
      return;
    }

    const inputValue = parseFloat(display);
    const result = Calculator.performCalculation(firstOperand, operator, inputValue);
    const resultStr = result.toString();

    setDisplay(resultStr);
    setFirstOperand(null);
    setOperator(null);
    setWaitingForOperand(true);

    // Add to history
    try {
      const record = await historyService.addCalculation(
        String(firstOperand),
        operator,
        String(inputValue),
        resultStr
      );
      setHistory([record, ...history.slice(0, 49)]);
    } catch (error) {
      console.error('Failed to add calculation to history:', error);
    }
  };

  const handleClear = () => {
    setDisplay('0');
    setFirstOperand(null);
    setSecondOperand(0);
    setOperator(null);
    setWaitingForOperand(false);
  };

  const handleHistoryClear = async () => {
    try {
      await historyService.clearHistory();
      setHistory([]);
    } catch (error) {
      console.error('Failed to clear history:', error);
    }
  };

  const handleHistoryReplay = (result: string) => {
    setDisplay(result);
    setFirstOperand(null);
    setOperator(null);
    setWaitingForOperand(true);
  };

  return (
    <div className="calculator-container">
      <div className="calculator-wrapper">
        <div className="calculator-header">
          <h1>Calculator</h1>
          <ThemeToggle />
        </div>

        <div className="calculator-main">
          <div className="display-area">
            <div className="display">{display}</div>
          </div>

          <CalculatorKeypad
            onNumberClick={handleNumberClick}
            onOperatorClick={handleOperatorClick}
            onEquals={handleEquals}
            onClear={handleClear}
          />
        </div>

        <HistoryPanel
          history={history}
          isLoading={historyLoading}
          onReplay={handleHistoryReplay}
          onClear={handleHistoryClear}
        />
      </div>
    </div>
  );
};

export default App;
