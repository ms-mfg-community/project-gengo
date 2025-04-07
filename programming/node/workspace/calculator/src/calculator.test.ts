import { Calculator } from './calculator.js';

describe('Calculator', () => {
  let calculator: Calculator;

  // Before each test, create a new instance of the Calculator
  beforeEach(() => {
    calculator = new Calculator();
  });

  // Addition tests
  describe('add', () => {
    test('should add two positive numbers correctly', () => {
      expect(calculator.add(2, 3)).toBe(5);
    });

    test('should add a positive and a negative number correctly', () => {
      expect(calculator.add(5, -3)).toBe(2);
    });

    test('should add two negative numbers correctly', () => {
      expect(calculator.add(-2, -3)).toBe(-5);
    });

    test('should add zero correctly', () => {
      expect(calculator.add(5, 0)).toBe(5);
    });

    test('should handle decimal numbers', () => {
      expect(calculator.add(2.5, 3.7)).toBeCloseTo(6.2);
    });
  });

  // Subtraction tests
  describe('subtract', () => {
    test('should subtract two positive numbers correctly', () => {
      expect(calculator.subtract(5, 3)).toBe(2);
    });

    test('should handle negative result correctly', () => {
      expect(calculator.subtract(3, 5)).toBe(-2);
    });

    test('should subtract a negative number correctly', () => {
      expect(calculator.subtract(5, -3)).toBe(8);
    });

    test('should subtract zero correctly', () => {
      expect(calculator.subtract(5, 0)).toBe(5);
    });

    test('should handle decimal numbers', () => {
      expect(calculator.subtract(5.5, 3.3)).toBeCloseTo(2.2);
    });
  });

  // Multiplication tests
  describe('multiply', () => {
    test('should multiply two positive numbers correctly', () => {
      expect(calculator.multiply(2, 3)).toBe(6);
    });

    test('should multiply with zero correctly', () => {
      expect(calculator.multiply(5, 0)).toBe(0);
    });

    test('should multiply negative numbers correctly', () => {
      expect(calculator.multiply(-2, 3)).toBe(-6);
      expect(calculator.multiply(2, -3)).toBe(-6);
      expect(calculator.multiply(-2, -3)).toBe(6);
    });

    test('should handle decimal numbers', () => {
      expect(calculator.multiply(2.5, 2)).toBe(5);
    });
  });

  // Division tests
  describe('divide', () => {
    test('should divide two positive numbers correctly', () => {
      expect(calculator.divide(6, 3)).toBe(2);
    });

    test('should handle division resulting in decimals', () => {
      expect(calculator.divide(5, 2)).toBe(2.5);
    });

    test('should handle negative numbers correctly', () => {
      expect(calculator.divide(-6, 3)).toBe(-2);
      expect(calculator.divide(6, -3)).toBe(-2);
      expect(calculator.divide(-6, -3)).toBe(2);
    });

    test('should throw an error when dividing by zero', () => {
      expect(() => calculator.divide(5, 0)).toThrow('Division by zero is not allowed');
    });
  });

  // Modulo tests
  describe('modulo', () => {
    test('should calculate modulo of two positive numbers correctly', () => {
      expect(calculator.modulo(7, 3)).toBe(1);
    });

    test('should handle zero as first operand correctly', () => {
      expect(calculator.modulo(0, 5)).toBe(0);
    });

    test('should handle negative numbers correctly', () => {
      expect(calculator.modulo(-7, 3)).toBe(-1);
      expect(calculator.modulo(7, -3)).toBe(1);
    });

    test('should throw an error when doing modulo by zero', () => {
      expect(() => calculator.modulo(5, 0)).toThrow('Modulo by zero is not allowed');
    });
  });

  // Exponent tests
  describe('exponent', () => {
    test('should calculate exponent correctly with positive integers', () => {
      expect(calculator.exponent(2, 3)).toBe(8);
    });

    test('should handle base of zero correctly', () => {
      expect(calculator.exponent(0, 5)).toBe(0);
    });

    test('should handle exponent of zero correctly', () => {
      expect(calculator.exponent(5, 0)).toBe(1);
    });

    test('should handle negative base correctly', () => {
      expect(calculator.exponent(-2, 2)).toBe(4);
      expect(calculator.exponent(-2, 3)).toBe(-8);
    });

    test('should handle decimal exponents correctly', () => {
      expect(calculator.exponent(4, 0.5)).toBe(2);
      expect(calculator.exponent(27, 1/3)).toBeCloseTo(3);
    });

    test('should handle negative exponents correctly', () => {
      expect(calculator.exponent(2, -2)).toBe(0.25);
    });
  });
});