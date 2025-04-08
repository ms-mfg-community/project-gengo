import { describe, test, expect } from '@jest/globals';
import { add, subtract, multiply, divide, modulo, exponent } from '../utils/calculatorFunctions';

// Test data table with various test cases
const calculatorTestTable = [
  // Format: [operation, a, b, expected]
  // Addition tests
  { operation: 'add', a: 2, b: 3, expected: 5 },
  { operation: 'add', a: -5, b: 10, expected: 5 },
  { operation: 'add', a: 0, b: 0, expected: 0 },
  
  // Subtraction tests
  { operation: 'subtract', a: 5, b: 3, expected: 2 },
  { operation: 'subtract', a: 10, b: 15, expected: -5 },
  { operation: 'subtract', a: 0, b: 0, expected: 0 },
  
  // Multiplication tests
  { operation: 'multiply', a: 4, b: 3, expected: 12 },
  { operation: 'multiply', a: -2, b: 5, expected: -10 },
  { operation: 'multiply', a: 0, b: 100, expected: 0 },
  
  // Division tests
  { operation: 'divide', a: 10, b: 2, expected: 5 },
  { operation: 'divide', a: 7, b: 2, expected: 3.5 },
  { operation: 'divide', a: 0, b: 5, expected: 0 },
  
  // Modulo tests
  { operation: 'modulo', a: 10, b: 3, expected: 1 },
  { operation: 'modulo', a: 15, b: 4, expected: 3 },
  { operation: 'modulo', a: 5, b: 5, expected: 0 },
  
  // Exponent tests
  { operation: 'exponent', a: 2, b: 3, expected: 8 },
  { operation: 'exponent', a: 5, b: 2, expected: 25 },
  { operation: 'exponent', a: 10, b: 0, expected: 1 },
];

// Test cases that should throw errors
const errorTestTable = [
  // Division by zero
  { operation: 'divide', a: 5, b: 0, error: 'Cannot divide by zero' },
  // Modulo by zero
  { operation: 'modulo', a: 10, b: 0, error: 'Cannot find modulo with zero' },
];

describe('Calculator Operations', () => {
  // Test for successful operations
  test.each(calculatorTestTable)('$operation($a, $b) should return $expected', 
    ({ operation, a, b, expected }) => {
      let result;
      switch (operation) {
        case 'add':
          result = add(a, b);
          break;
        case 'subtract':
          result = subtract(a, b);
          break;
        case 'multiply':
          result = multiply(a, b);
          break;
        case 'divide':
          result = divide(a, b);
          break;
        case 'modulo':
          result = modulo(a, b);
          break;
        case 'exponent':
          result = exponent(a, b);
          break;
      }
      expect(result).toBe(expected);
    }
  );

  // Test for operations that should throw errors
  test.each(errorTestTable)('$operation($a, $b) should throw "$error"', 
    ({ operation, a, b, error }) => {
      let testFunction;
      switch (operation) {
        case 'divide':
          testFunction = () => divide(a, b);
          break;
        case 'modulo':
          testFunction = () => modulo(a, b);
          break;
      }
      expect(testFunction).toThrow(error);
    }
  );
});