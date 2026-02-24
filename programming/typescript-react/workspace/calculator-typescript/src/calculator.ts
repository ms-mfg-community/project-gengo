/**
 * Calculator class that provides arithmetic operations
 */
export class Calculator {
    /**
     * Adds two numbers
     * @param first - The first operand
     * @param second - The second operand
     * @returns The sum of the two numbers
     */
    public static add(first: number, second: number): number {
        return first + second;
    }

    /**
     * Subtracts two numbers
     * @param first - The first operand
     * @param second - The second operand
     * @returns The difference between the two numbers
     */
    public static subtract(first: number, second: number): number {
        return first - second;
    }

    /**
     * Multiplies two numbers
     * @param first - The first operand
     * @param second - The second operand
     * @returns The product of the two numbers
     */
    public static multiply(first: number, second: number): number {
        return first * second;
    }

    /**
     * Divides two numbers
     * @param first - The dividend
     * @param second - The divisor
     * @returns The quotient, or NaN if dividing by zero
     */
    public static divide(first: number, second: number): number {
        if (second === 0) {
            console.error("Error: Cannot divide by zero.");
            return NaN;
        }
        return first / second;
    }

    /**
     * Performs modulo operation on two numbers
     * @param first - The dividend
     * @param second - The divisor
     * @returns The remainder, or NaN if dividing by zero
     */
    public static modulo(first: number, second: number): number {
        if (second === 0) {
            console.error("Error: Cannot perform modulo by zero.");
            return NaN;
        }
        return first % second;
    }

    /**
     * Raises the first number to the power of the second number
     * @param first - The base
     * @param second - The exponent
     * @returns The result of first raised to the power of second
     */
    public static exponent(first: number, second: number): number {
        return Math.pow(first, second);
    }

    /**
     * Performs the calculation based on the operation
     * @param first - The first operand
     * @param operator - The operation to perform (+, -, *, /, %, ^)
     * @param second - The second operand
     * @returns The result of the calculation, or NaN if invalid operation
     */
    public static performCalculation(first: number, operator: string, second: number): number {
        if (!operator) {
            return NaN;
        }

        switch (operator) {
            case "+":
                return this.add(first, second);
            case "-":
                return this.subtract(first, second);
            case "*":
                return this.multiply(first, second);
            case "/":
                return this.divide(first, second);
            case "%":
                return this.modulo(first, second);
            case "^":
                return this.exponent(first, second);
            default:
                return NaN;
        }
    }

    /**
     * Validates if a string is a valid operator
     * @param operator - The operator to validate
     * @returns True if the operator is valid, false otherwise
     */
    public static isValidOperator(operator: string): boolean {
        return ["+", "-", "*", "/", "%", "^"].includes(operator);
    }
}
