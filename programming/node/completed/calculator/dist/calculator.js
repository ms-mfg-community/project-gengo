/**
 * Calculator class for performing basic arithmetic operations
 */
export class Calculator {
    /**
     * Adds two numbers
     * @param a First number
     * @param b Second number
     * @returns The sum of a and b
     */
    add(a, b) {
        return a + b;
    }
    /**
     * Subtracts the second number from the first
     * @param a First number
     * @param b Second number
     * @returns The difference between a and b
     */
    subtract(a, b) {
        return a - b;
    }
    /**
     * Multiplies two numbers
     * @param a First number
     * @param b Second number
     * @returns The product of a and b
     */
    multiply(a, b) {
        return a * b;
    }
    /**
     * Divides the first number by the second
     * @param a First number (dividend)
     * @param b Second number (divisor)
     * @returns The quotient of a divided by b
     * @throws Error if b is zero
     */
    divide(a, b) {
        if (b === 0) {
            throw new Error("Division by zero is not allowed");
        }
        return a / b;
    }
    /**
     * Calculates the modulo of the first number by the second
     * @param a First number (dividend)
     * @param b Second number (divisor)
     * @returns The remainder when a is divided by b
     * @throws Error if b is zero
     */
    modulo(a, b) {
        if (b === 0) {
            throw new Error("Modulo by zero is not allowed");
        }
        return a % b;
    }
    /**
     * Raises the first number to the power of the second number
     * @param a Base number
     * @param b Exponent
     * @returns a raised to the power of b
     */
    power(a, b) {
        return Math.pow(a, b);
    }
}
