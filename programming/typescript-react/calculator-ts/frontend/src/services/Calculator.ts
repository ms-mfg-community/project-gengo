/**
 * Calculator Service - Core arithmetic operations
 * Pure functions matching the C# Calculator.cs functionality
 */

export class Calculator {
  static add(first: number, second: number): number {
    return first + second;
  }

  static subtract(first: number, second: number): number {
    return first - second;
  }

  static multiply(first: number, second: number): number {
    return first * second;
  }

  static divide(first: number, second: number): number {
    if (second === 0) return NaN;
    return first / second;
  }

  static modulo(first: number, second: number): number {
    if (second === 0) return NaN;
    return first % second;
  }

  static exponent(first: number, second: number): number {
    return Math.pow(first, second);
  }

  static performCalculation(first: number, operator: string | null, second: number): number {
    if (!operator) return first;

    switch (operator) {
      case '+':
        return this.add(first, second);
      case '-':
        return this.subtract(first, second);
      case '*':
        return this.multiply(first, second);
      case '/':
        return this.divide(first, second);
      case '%':
        return this.modulo(first, second);
      case '^':
        return this.exponent(first, second);
      default:
        return NaN;
    }
  }
}
