import { Calculator } from './calculator';

/**
 * Basic test suite for the Calculator class
 * Demonstrates usage of all arithmetic operations
 */

console.log("=== Calculator Test Suite ===\n");

// Test Addition
console.log("--- Addition Tests ---");
console.log(`10 + 5 = ${Calculator.add(10, 5)} (Expected: 15)`);
console.log(`-3 + 7 = ${Calculator.add(-3, 7)} (Expected: 4)`);
console.log(`0 + 0 = ${Calculator.add(0, 0)} (Expected: 0)`);
console.log(`5.5 + 2.3 = ${Calculator.add(5.5, 2.3)} (Expected: 7.8)`);
console.log();

// Test Subtraction
console.log("--- Subtraction Tests ---");
console.log(`10 - 5 = ${Calculator.subtract(10, 5)} (Expected: 5)`);
console.log(`5 - 10 = ${Calculator.subtract(5, 10)} (Expected: -5)`);
console.log(`0 - 5 = ${Calculator.subtract(0, 5)} (Expected: -5)`);
console.log(`10.7 - 3.2 = ${Calculator.subtract(10.7, 3.2)} (Expected: 7.5)`);
console.log();

// Test Multiplication
console.log("--- Multiplication Tests ---");
console.log(`10 * 5 = ${Calculator.multiply(10, 5)} (Expected: 50)`);
console.log(`-3 * 4 = ${Calculator.multiply(-3, 4)} (Expected: -12)`);
console.log(`0 * 100 = ${Calculator.multiply(0, 100)} (Expected: 0)`);
console.log(`2.5 * 4 = ${Calculator.multiply(2.5, 4)} (Expected: 10)`);
console.log();

// Test Division
console.log("--- Division Tests ---");
console.log(`10 / 5 = ${Calculator.divide(10, 5)} (Expected: 2)`);
console.log(`20 / 4 = ${Calculator.divide(20, 4)} (Expected: 5)`);
console.log(`7 / 2 = ${Calculator.divide(7, 2)} (Expected: 3.5)`);
console.log(`10 / 0 = ${Calculator.divide(10, 0)} (Expected: NaN with error message)`);
console.log();

// Test Modulo
console.log("--- Modulo Tests ---");
console.log(`10 % 3 = ${Calculator.modulo(10, 3)} (Expected: 1)`);
console.log(`20 % 5 = ${Calculator.modulo(20, 5)} (Expected: 0)`);
console.log(`7 % 2 = ${Calculator.modulo(7, 2)} (Expected: 1)`);
console.log(`10 % 0 = ${Calculator.modulo(10, 0)} (Expected: NaN with error message)`);
console.log();

// Test Exponent
console.log("--- Exponent Tests ---");
console.log(`2 ^ 3 = ${Calculator.exponent(2, 3)} (Expected: 8)`);
console.log(`10 ^ 2 = ${Calculator.exponent(10, 2)} (Expected: 100)`);
console.log(`5 ^ 0 = ${Calculator.exponent(5, 0)} (Expected: 1)`);
console.log(`2 ^ -1 = ${Calculator.exponent(2, -1)} (Expected: 0.5)`);
console.log();

// Test performCalculation method
console.log("--- performCalculation Tests ---");
console.log(`performCalculation(10, "+", 5) = ${Calculator.performCalculation(10, "+", 5)} (Expected: 15)`);
console.log(`performCalculation(10, "-", 5) = ${Calculator.performCalculation(10, "-", 5)} (Expected: 5)`);
console.log(`performCalculation(10, "*", 5) = ${Calculator.performCalculation(10, "*", 5)} (Expected: 50)`);
console.log(`performCalculation(10, "/", 5) = ${Calculator.performCalculation(10, "/", 5)} (Expected: 2)`);
console.log(`performCalculation(10, "%", 3) = ${Calculator.performCalculation(10, "%", 3)} (Expected: 1)`);
console.log(`performCalculation(2, "^", 3) = ${Calculator.performCalculation(2, "^", 3)} (Expected: 8)`);
console.log(`performCalculation(10, "?", 5) = ${Calculator.performCalculation(10, "?", 5)} (Expected: NaN)`);
console.log();

// Test isValidOperator method
console.log("--- isValidOperator Tests ---");
console.log(`isValidOperator("+") = ${Calculator.isValidOperator("+")} (Expected: true)`);
console.log(`isValidOperator("-") = ${Calculator.isValidOperator("-")} (Expected: true)`);
console.log(`isValidOperator("*") = ${Calculator.isValidOperator("*")} (Expected: true)`);
console.log(`isValidOperator("/") = ${Calculator.isValidOperator("/")} (Expected: true)`);
console.log(`isValidOperator("%") = ${Calculator.isValidOperator("%")} (Expected: true)`);
console.log(`isValidOperator("^") = ${Calculator.isValidOperator("^")} (Expected: true)`);
console.log(`isValidOperator("?") = ${Calculator.isValidOperator("?")} (Expected: false)`);
console.log(`isValidOperator("") = ${Calculator.isValidOperator("")} (Expected: false)`);
console.log();

console.log("=== All Tests Completed ===");
