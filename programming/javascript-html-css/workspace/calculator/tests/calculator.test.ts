/**
 * Test Suite for TypeScript Calculator
 * Test-Suite für TypeScript-Rechner
 * टाइपस्क्रिप्ट कैलकुलेटर के लिए टेस्ट सूट
 * TypeScript電卓のテストスイート
 */

import { Calculator } from '../src/calculator';

// Mock DOM elements for testing
// DOM-Elemente für Tests mocken
// परीक्षण के लिए DOM तत्वों को मॉक करें
// テスト用のDOM要素をモック
Object.defineProperty(window, 'HTMLInputElement', {
    value: class MockHTMLInputElement {
        value: string = '';
        addEventListener = jest.fn();
    }
});

// Mock document.getElementById
// document.getElementById mocken
// document.getElementById को मॉक करें
// document.getElementByIdをモック
Object.defineProperty(document, 'getElementById', {
    value: jest.fn(() => ({
        value: '',
        addEventListener: jest.fn()
    }))
});

// Mock document.addEventListener
// document.addEventListener mocken
// document.addEventListener को मॉक करें
// document.addEventListenerをモック
Object.defineProperty(document, 'addEventListener', {
    value: jest.fn()
});

describe('Calculator Class Tests', () => {
    let calculator: Calculator;
    let mockDisplay: any;

    beforeEach(() => {
        // Reset mocks before each test
        // Mocks vor jedem Test zurücksetzen
        // प्रत्येक परीक्षण से पहले मॉक को रीसेट करें
        // 各テスト前にモックをリセット
        mockDisplay = {
            value: '',
            addEventListener: jest.fn()
        };
        
        (document.getElementById as jest.Mock).mockReturnValue(mockDisplay);
        calculator = new Calculator();
    });

    describe('Basic Arithmetic Operations', () => {
        // Test addition | Addition testen | जोड़ का परीक्षण | 加算のテスト
        test('should add two positive numbers correctly', () => {
            expect(Calculator.add(5, 3)).toBe(8);
        });

        test('should add positive and negative numbers correctly', () => {
            expect(Calculator.add(10, -3)).toBe(7);
        });

        test('should add two negative numbers correctly', () => {
            expect(Calculator.add(-5, -3)).toBe(-8);
        });

        test('should add decimal numbers correctly', () => {
            expect(Calculator.add(2.5, 3.7)).toBeCloseTo(6.2);
        });

        // Test subtraction | Subtraktion testen | घटाव का परीक्षण | 減算のテスト
        test('should subtract two positive numbers correctly', () => {
            expect(Calculator.subtract(10, 3)).toBe(7);
        });

        test('should subtract negative from positive correctly', () => {
            expect(Calculator.subtract(10, -3)).toBe(13);
        });

        test('should subtract positive from negative correctly', () => {
            expect(Calculator.subtract(-10, 3)).toBe(-13);
        });

        test('should subtract decimal numbers correctly', () => {
            expect(Calculator.subtract(5.8, 2.3)).toBeCloseTo(3.5);
        });

        // Test multiplication | Multiplikation testen | गुणा का परीक्षण | 乗算のテスト
        test('should multiply two positive numbers correctly', () => {
            expect(Calculator.multiply(4, 5)).toBe(20);
        });

        test('should multiply positive and negative numbers correctly', () => {
            expect(Calculator.multiply(4, -5)).toBe(-20);
        });

        test('should multiply two negative numbers correctly', () => {
            expect(Calculator.multiply(-4, -5)).toBe(20);
        });

        test('should multiply decimal numbers correctly', () => {
            expect(Calculator.multiply(2.5, 4)).toBe(10);
        });

        test('should multiply by zero correctly', () => {
            expect(Calculator.multiply(100, 0)).toBe(0);
        });

        // Test division | Division testen | भाग का परीक्षण | 除算のテスト
        test('should divide two positive numbers correctly', () => {
            expect(Calculator.divide(10, 2)).toBe(5);
        });

        test('should divide positive by negative correctly', () => {
            expect(Calculator.divide(10, -2)).toBe(-5);
        });

        test('should divide negative by positive correctly', () => {
            expect(Calculator.divide(-10, 2)).toBe(-5);
        });

        test('should divide decimal numbers correctly', () => {
            expect(Calculator.divide(7.5, 2.5)).toBe(3);
        });

        test('should throw error when dividing by zero', () => {
            expect(() => Calculator.divide(10, 0)).toThrow();
        });
    });

    describe('Advanced Operations', () => {
        // Test modulo | Modulo testen | मॉड्यूलो का परीक्षण | 剰余のテスト
        test('should calculate modulo correctly for positive numbers', () => {
            expect(Calculator.modulo(10, 3)).toBe(1);
        });

        test('should calculate modulo correctly for negative dividend', () => {
            expect(Calculator.modulo(-10, 3)).toBe(-1);
        });

        test('should calculate modulo correctly for negative divisor', () => {
            expect(Calculator.modulo(10, -3)).toBe(1);
        });

        test('should calculate modulo correctly for decimal numbers', () => {
            expect(Calculator.modulo(5.5, 2)).toBeCloseTo(1.5);
        });

        test('should throw error when modulo by zero', () => {
            expect(() => Calculator.modulo(10, 0)).toThrow();
        });

        // Test exponentiation | Potenzierung testen | घातांक का परीक्षण | べき乗のテスト
        test('should calculate power correctly for positive base and exponent', () => {
            expect(Calculator.power(2, 3)).toBe(8);
        });

        test('should calculate power correctly for negative base and odd exponent', () => {
            expect(Calculator.power(-2, 3)).toBe(-8);
        });

        test('should calculate power correctly for negative base and even exponent', () => {
            expect(Calculator.power(-2, 2)).toBe(4);
        });

        test('should calculate power correctly for decimal base', () => {
            expect(Calculator.power(1.5, 2)).toBe(2.25);
        });

        test('should calculate power correctly for zero exponent', () => {
            expect(Calculator.power(5, 0)).toBe(1);
        });

        test('should calculate power correctly for negative exponent', () => {
            expect(Calculator.power(2, -2)).toBe(0.25);
        });
    });

    describe('Display Operations', () => {
        // Test display append | Display-Anhängen testen | डिस्प्ले अपेंड का परीक्षण | ディスプレイ追加のテスト
        test('should append number to display', () => {
            calculator.appendToDisplay('5');
            expect(mockDisplay.value).toBe('5');
        });

        test('should append multiple numbers to display', () => {
            calculator.appendToDisplay('1');
            calculator.appendToDisplay('2');
            calculator.appendToDisplay('3');
            expect(mockDisplay.value).toBe('123');
        });

        test('should convert multiplication symbol correctly', () => {
            calculator.appendToDisplay('*');
            expect(mockDisplay.value).toBe('×');
        });

        test('should convert exponentiation symbol correctly', () => {
            calculator.appendToDisplay('**');
            expect(mockDisplay.value).toBe('^');
        });

        // Test display clear | Display-Löschen testen | डिस्प्ले साफ़ का परीक्षण | ディスプレイクリアのテスト
        test('should clear display completely', () => {
            calculator.appendToDisplay('123');
            calculator.clearDisplay();
            expect(mockDisplay.value).toBe('');
        });

        test('should clear entry', () => {
            calculator.appendToDisplay('123');
            calculator.clearEntry();
            expect(mockDisplay.value).toBe('');
        });

        // Test delete last character | Letztes Zeichen löschen testen | अंतिम वर्ण हटाने का परीक्षण | 最後の文字削除のテスト
        test('should delete last character', () => {
            calculator.appendToDisplay('123');
            calculator.deleteLast();
            expect(mockDisplay.value).toBe('12');
        });

        test('should handle delete on empty display', () => {
            calculator.deleteLast();
            expect(mockDisplay.value).toBe('');
        });
    });

    describe('Complex Calculations', () => {
        // Test complex expressions | Komplexe Ausdrücke testen | जटिल अभिव्यक्तियों का परीक्षण | 複雑な式のテスト
        test('should handle order of operations correctly', () => {
            mockDisplay.value = '2+3*4';
            calculator.calculate();
            expect(mockDisplay.value).toBe('14');
        });

        test('should handle parentheses correctly', () => {
            mockDisplay.value = '(2+3)*4';
            calculator.calculate();
            expect(mockDisplay.value).toBe('20');
        });

        test('should handle decimal calculations', () => {
            mockDisplay.value = '2.5*4';
            calculator.calculate();
            expect(mockDisplay.value).toBe('10');
        });

        test('should handle negative numbers', () => {
            mockDisplay.value = '-5+3';
            calculator.calculate();
            expect(mockDisplay.value).toBe('-2');
        });

        test('should handle modulo operation', () => {
            mockDisplay.value = '10%3';
            calculator.calculate();
            expect(mockDisplay.value).toBe('1');
        });

        test('should handle exponentiation operation', () => {
            mockDisplay.value = '2^3';
            calculator.calculate();
            expect(mockDisplay.value).toBe('8');
        });
    });

    describe('Error Handling', () => {
        // Test error scenarios | Fehlerszenarios testen | त्रुटि परिदृश्यों का परीक्षण | エラーシナリオのテスト
        test('should display error for division by zero in expression', () => {
            mockDisplay.value = '10/0';
            calculator.calculate();
            expect(mockDisplay.value).toBe('Error');
        });

        test('should display error for invalid expression', () => {
            mockDisplay.value = '2++3';
            calculator.calculate();
            expect(mockDisplay.value).toBe('Error');
        });

        test('should display error for unbalanced parentheses', () => {
            mockDisplay.value = '(2+3';
            calculator.calculate();
            expect(mockDisplay.value).toBe('Error');
        });

        test('should handle empty calculation', () => {
            mockDisplay.value = '';
            calculator.calculate();
            expect(mockDisplay.value).toBe('');
        });
    });

    describe('Edge Cases', () => {
        // Test edge cases | Grenzfälle testen | सीमा मामलों का परीक्षण | エッジケースのテスト
        test('should handle very large numbers', () => {
            expect(Calculator.add(Number.MAX_SAFE_INTEGER - 1, 1)).toBe(Number.MAX_SAFE_INTEGER);
        });

        test('should handle very small numbers', () => {
            expect(Calculator.subtract(Number.MIN_SAFE_INTEGER + 1, 1)).toBe(Number.MIN_SAFE_INTEGER);
        });

        test('should handle floating point precision', () => {
            mockDisplay.value = '0.1+0.2';
            calculator.calculate();
            expect(parseFloat(mockDisplay.value)).toBeCloseTo(0.3);
        });

        test('should format integer results correctly', () => {
            mockDisplay.value = '4/2';
            calculator.calculate();
            expect(mockDisplay.value).toBe('2');
        });
    });

    describe('Multi-language Documentation Verification', () => {
        // Verify multi-language support exists | Mehrsprachige Unterstützung verifizieren | बहुभाषी समर्थन सत्यापित करें | 多言語サポートを確認
        test('should have multi-language static method documentation', () => {
            // These tests verify that the methods exist and work correctly
            // Diese Tests verifizieren, dass die Methoden existieren und korrekt funktionieren
            // ये परीक्षण सत्यापित करते हैं कि विधियां मौजूद हैं और सही तरीके से काम करती हैं
            // これらのテストは、メソッドが存在し正しく動作することを確認
            expect(typeof Calculator.add).toBe('function');
            expect(typeof Calculator.subtract).toBe('function');
            expect(typeof Calculator.multiply).toBe('function');
            expect(typeof Calculator.divide).toBe('function');
            expect(typeof Calculator.modulo).toBe('function');
            expect(typeof Calculator.power).toBe('function');
        });

        test('should maintain functionality across all documented languages', () => {
            // English: Function should work regardless of documentation language
            // German: Funktion sollte unabhängig von der Dokumentationssprache funktionieren
            // Hindi: फ़ंक्शन दस्तावेज़ीकरण भाषा की परवाह किए बिना काम करना चाहिए
            // Japanese: ドキュメンテーション言語に関係なく機能が動作する必要がある
            expect(Calculator.add(2, 3)).toBe(5);
            expect(Calculator.subtract(5, 2)).toBe(3);
            expect(Calculator.multiply(3, 4)).toBe(12);
            expect(Calculator.divide(8, 2)).toBe(4);
            expect(Calculator.modulo(7, 3)).toBe(1);
            expect(Calculator.power(2, 4)).toBe(16);
        });
    });
});
