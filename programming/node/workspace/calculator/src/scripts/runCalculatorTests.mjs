// Node script to run calculator unit tests and display results in console
import { add, subtract, multiply, divide, modulo, exponent } from '../utils/calculatorFunctions.js';

// Test data table format
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

// Helper function to run a test and return result
function runTest(test) {
  const { operation, a, b, expected, error } = test;
  let result;
  let passed = false;
  let errorThrown = null;

  try {
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

    if (error) {
      // If we expected an error but none was thrown
      passed = false;
      return { operation, a, b, expected: `Error: ${error}`, actual: result, passed };
    } else {
      // Normal case - compare result with expected
      passed = result === expected;
      return { operation, a, b, expected, actual: result, passed };
    }
  } catch (e) {
    errorThrown = e.message;
    
    if (error) {
      // We expected an error and one was thrown
      passed = errorThrown.includes(error);
      return { 
        operation, 
        a, 
        b, 
        expected: `Error: ${error}`, 
        actual: `Error: ${errorThrown}`, 
        passed 
      };
    } else {
      // We didn't expect an error but one was thrown
      passed = false;
      return { 
        operation, 
        a, 
        b, 
        expected, 
        actual: `Error: ${errorThrown}`, 
        passed 
      };
    }
  }
}

// Run all tests
console.log('\n======== CALCULATOR TEST RESULTS ========\n');

// Regular tests
console.log('NORMAL OPERATIONS:');
console.log('=================\n');

let successCount = 0;
let totalTests = calculatorTestTable.length;

calculatorTestTable.forEach((test, index) => {
  const result = runTest(test);
  if (result.passed) successCount++;
  
  console.log(`Test #${index + 1}: ${result.operation}(${result.a}, ${result.b})`);
  console.log(`Expected: ${result.expected}`);
  console.log(`Actual: ${result.actual}`);
  console.log(`Status: ${result.passed ? 'PASS ✅' : 'FAIL ❌'}`);
  console.log('----------------------------');
});

console.log('\nERROR HANDLING:');
console.log('==============\n');

let errorSuccessCount = 0;
let totalErrorTests = errorTestTable.length;

errorTestTable.forEach((test, index) => {
  const result = runTest(test);
  if (result.passed) errorSuccessCount++;
  
  console.log(`Test #${index + 1}: ${result.operation}(${result.a}, ${result.b})`);
  console.log(`Expected: ${result.expected}`);
  console.log(`Actual: ${result.actual}`);
  console.log(`Status: ${result.passed ? 'PASS ✅' : 'FAIL ❌'}`);
  console.log('----------------------------');
});

// Summary
const totalSuccess = successCount + errorSuccessCount;
const totalTestCount = totalTests + totalErrorTests;
const successRate = Math.round((totalSuccess / totalTestCount) * 100);

console.log('\n======== SUMMARY ========');
console.log(`Tests passed: ${totalSuccess} / ${totalTestCount} (${successRate}%)`);
console.log('========================\n');