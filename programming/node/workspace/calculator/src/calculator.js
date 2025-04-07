// JavaScript version of the Calculator class
export class Calculator {
  add(a, b) {
    return a + b;
  }

  subtract(a, b) {
    return a - b;
  }

  multiply(a, b) {
    return a * b;
  }

  divide(a, b) {
    if (b === 0) {
      throw new Error('Division by zero is not allowed');
    }
    return a / b;
  }
  
  modulo(a, b) {
    if (b === 0) {
      throw new Error('Modulo by zero is not allowed');
    }
    return a % b;
  }
  
  exponent(a, b) {
    return Math.pow(a, b);
  }
}