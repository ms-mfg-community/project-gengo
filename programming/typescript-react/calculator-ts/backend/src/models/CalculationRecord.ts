/**
 * Calculation Record Model - Database schema
 */
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

export interface CreateCalculationDTO {
  operand1: string;
  operator: string;
  operand2: string;
  result: string;
  timestamp: Date;
  userId?: string;
  displayText: string;
}
