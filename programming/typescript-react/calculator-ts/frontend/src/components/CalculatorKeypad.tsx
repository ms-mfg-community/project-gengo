import React from 'react';
import { Calculator } from '../services/Calculator';

interface CalculatorKeypadProps {
  onNumberClick: (digit: string) => void;
  onOperatorClick: (operator: string) => void;
  onEquals: () => void;
  onClear: () => void;
}

export const CalculatorKeypad: React.FC<CalculatorKeypadProps> = ({
  onNumberClick,
  onOperatorClick,
  onEquals,
  onClear,
}) => {
  const operators = [
    { symbol: '÷', value: '/', title: 'Divide' },
    { symbol: '×', value: '*', title: 'Multiply' },
    { symbol: '−', value: '-', title: 'Subtract' },
    { symbol: '+', value: '+', title: 'Add' },
  ];

  return (
    <div className="keypad">
      {/* Row 0: Clear & Reset buttons */}
      <button
        className="btn btn-clear"
        onClick={onClear}
        aria-label="Clear"
      >
        <span className="btn-label">C</span>
        <span className="btn-sublabel">Clear</span>
      </button>
      <button
        className="btn btn-reset"
        onClick={onClear}
        style={{ gridColumn: 'span 3' }}
        aria-label="Reset"
      >
        <span className="btn-label">RESET</span>
      </button>

      {/* Row 1: 7 8 9 / */}
      <button className="btn btn-number" onClick={() => onNumberClick('7')}>7</button>
      <button className="btn btn-number" onClick={() => onNumberClick('8')}>8</button>
      <button className="btn btn-number" onClick={() => onNumberClick('9')}>9</button>
      <button className="btn btn-operator" onClick={() => onOperatorClick('/')} title={operators[0].title}>{operators[0].symbol}</button>

      {/* Row 2: 4 5 6 * */}
      <button className="btn btn-number" onClick={() => onNumberClick('4')}>4</button>
      <button className="btn btn-number" onClick={() => onNumberClick('5')}>5</button>
      <button className="btn btn-number" onClick={() => onNumberClick('6')}>6</button>
      <button className="btn btn-operator" onClick={() => onOperatorClick('*')} title={operators[1].title}>{operators[1].symbol}</button>

      {/* Row 3: 1 2 3 - */}
      <button className="btn btn-number" onClick={() => onNumberClick('1')}>1</button>
      <button className="btn btn-number" onClick={() => onNumberClick('2')}>2</button>
      <button className="btn btn-number" onClick={() => onNumberClick('3')}>3</button>
      <button className="btn btn-operator" onClick={() => onOperatorClick('-')} title={operators[2].title}>{operators[2].symbol}</button>

      {/* Row 4: 0 . + */}
      <button
        className="btn btn-number btn-zero"
        onClick={() => onNumberClick('0')}
        style={{ gridColumn: 'span 2' }}
      >
        0
      </button>
      <button className="btn btn-number" onClick={() => onNumberClick('.')}>.</button>
      <button className="btn btn-operator" onClick={() => onOperatorClick('+')} title={operators[3].title}>{operators[3].symbol}</button>

      {/* Row 5: x^y = */}
      <button
        className="btn btn-operator"
        onClick={() => onOperatorClick('^')}
        style={{ gridColumn: 'span 2' }}
        title="Power"
      >
        x<sup>y</sup>
      </button>
      <button
        className="btn btn-equals"
        onClick={onEquals}
        style={{ gridColumn: 'span 2' }}
      >
        =
      </button>
    </div>
  );
};
