import { Calculator } from './calculator';

describe('Calculator', () => {
  let calculator: Calculator;

  beforeEach(() => {
    calculator = new Calculator();
  });

  describe('add', () => {
    it('should add two positive numbers correctly', () => {
      expect(calculator.add(2, 3)).toBe(5);
    });

    it('should handle negative numbers', () => {
      expect(calculator.add(-2, 3)).toBe(1);
      expect(calculator.add(2, -3)).toBe(-1);
      expect(calculator.add(-2, -3)).toBe(-5);
    });
  });

  describe('subtract', () => {
    it('should subtract two positive numbers correctly', () => {
      expect(calculator.subtract(5, 3)).toBe(2);
    });

    it('should handle negative numbers', () => {
      expect(calculator.subtract(-2, 3)).toBe(-5);
      expect(calculator.subtract(2, -3)).toBe(5);
      expect(calculator.subtract(-2, -3)).toBe(1);
    });
  });

  describe('multiply', () => {
    it('should multiply two positive numbers correctly', () => {
      expect(calculator.multiply(2, 3)).toBe(6);
    });

    it('should handle negative numbers', () => {
      expect(calculator.multiply(-2, 3)).toBe(-6);
      expect(calculator.multiply(2, -3)).toBe(-6);
      expect(calculator.multiply(-2, -3)).toBe(6);
    });

    it('should return 0 when multiplying by 0', () => {
      expect(calculator.multiply(5, 0)).toBe(0);
      expect(calculator.multiply(0, 5)).toBe(0);
    });
  });

  describe('divide', () => {
    it('should divide two positive numbers correctly', () => {
      expect(calculator.divide(6, 3)).toBe(2);
    });

    it('should handle negative numbers', () => {
      expect(calculator.divide(-6, 3)).toBe(-2);
      expect(calculator.divide(6, -3)).toBe(-2);
      expect(calculator.divide(-6, -3)).toBe(2);
    });

    it('should throw an error when dividing by zero', () => {
      expect(() => calculator.divide(5, 0)).toThrow('Division by zero is not allowed');
    });
  });

  describe('modulo', () => {
    it('should calculate modulo of two positive numbers correctly', () => {
      expect(calculator.modulo(7, 3)).toBe(1);
    });

    it('should handle negative numbers', () => {
      expect(calculator.modulo(-7, 3)).toBe(-1);
      expect(calculator.modulo(7, -3)).toBe(1);
      expect(calculator.modulo(-7, -3)).toBe(-1);
    });

    it('should throw an error when modulo by zero', () => {
      expect(() => calculator.modulo(5, 0)).toThrow('Modulo by zero is not allowed');
    });
  });

  describe('power', () => {
    it('should calculate power of two positive numbers correctly', () => {
      expect(calculator.power(2, 3)).toBe(8);
    });

    it('should handle negative base', () => {
      expect(calculator.power(-2, 3)).toBe(-8);
      expect(calculator.power(-2, 2)).toBe(4);
    });

    it('should handle negative exponent', () => {
      expect(calculator.power(2, -3)).toBe(0.125);
    });

    it('should return 1 when exponent is 0', () => {
      expect(calculator.power(5, 0)).toBe(1);
      expect(calculator.power(-5, 0)).toBe(1);
    });

    it('should handle zero base', () => {
      expect(calculator.power(0, 5)).toBe(0);
    });
  });
});