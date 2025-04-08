// Separate functions for arithmetic operations
export const add = (a: number, b: number): number => {
  return a + b;
};

export const subtract = (a: number, b: number): number => {
  return a - b;
};

export const multiply = (a: number, b: number): number => {
  return a * b;
};

export const divide = (a: number, b: number): number => {
  if (b === 0) {
    throw new Error("Cannot divide by zero");
  }
  return a / b;
};

// Add modulo operation
export const modulo = (a: number, b: number): number => {
  if (b === 0) {
    throw new Error("Cannot find modulo with zero");
  }
  return a % b;
};

// Add exponent operation
export const exponent = (a: number, b: number): number => {
  return Math.pow(a, b);
};