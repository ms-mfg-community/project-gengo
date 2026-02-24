export interface CalculationRecord {
  id?: string;
  operand1: string;
  operator: string;
  operand2: string;
  result: string;
  timestamp: Date;
  userId?: string;
  displayText: string;
}

export type ThemeMode = 'light' | 'dark';

export interface CalculatorState {
  display: string;
  firstOperand: string | null;
  secondOperand: string;
  operator: string | null;
  waitingForOperand: boolean;
}
