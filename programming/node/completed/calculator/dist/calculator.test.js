import { Calculator } from './calculator';
describe('Calculator', () => {
    let calculator;
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
});
