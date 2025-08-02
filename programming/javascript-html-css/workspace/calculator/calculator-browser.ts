/**
 * Browser-compatible TypeScript Calculator
 * Browser-kompatible TypeScript-Rechner
 * ब्राउज़र-संगत टाइपस्क्रिप्ट कैलकुलेटर
 * ブラウザ互換TypeScript電卓
 */

/**
 * Calculator class containing all mathematical operations
 * Klasse Calculator mit allen mathematischen Operationen
 * सभी गणितीय संचालन वाला कैलकुलेटर क्लास
 * すべての数学演算を含む電卓クラス
 */
class Calculator {
    private display: HTMLInputElement;
    private currentInput: string = '';
    private shouldResetDisplay: boolean = false;

    constructor() {
        // Initialize display element | Display-Element initialisieren | डिस्प्ले तत्व को प्रारंभ करें | ディスプレイ要素を初期化
        this.display = document.getElementById('display') as HTMLInputElement;
        this.initializeEventListeners();
    }

    /**
     * Initialize keyboard event listeners
     * Tastatur-Event-Listener initialisieren
     * कीबोर्ड इवेंट लिस्नर को प्रारंभ करें
     * キーボードイベントリスナーを初期化
     */
    private initializeEventListeners(): void {
        document.addEventListener('keydown', (event: KeyboardEvent) => {
            this.handleKeyboardInput(event);
        });
    }

    /**
     * Handle keyboard input for calculator
     * Tastatureingabe für Rechner verarbeiten
     * कैलकुलेटर के लिए कीबोर्ड इनपुट संभालें
     * 電卓のキーボード入力を処理
     */
    private handleKeyboardInput(event: KeyboardEvent): void {
        const key = event.key;

        if (/[0-9.]/.test(key)) {
            this.appendToDisplay(key);
        } else if (['+', '-', '*', '/', '%'].includes(key)) {
            this.appendToDisplay(key === '*' ? '*' : key);
        } else if (key === 'Enter' || key === '=') {
            event.preventDefault();
            this.calculate();
        } else if (key === 'Escape' || key === 'c' || key === 'C') {
            this.clearDisplay();
        } else if (key === 'Backspace') {
            this.deleteLast();
        }
    }

    /**
     * Add number or operator to display
     * Zahl oder Operator zum Display hinzufügen
     * डिस्प्ले में संख्या या ऑपरेटर जोड़ें
     * ディスプレイに数字または演算子を追加
     */
    public appendToDisplay(value: string): void {
        if (this.shouldResetDisplay) {
            this.display.value = '';
            this.shouldResetDisplay = false;
        }

        // Handle special cases | Sonderfälle behandeln | विशेष मामलों को संभालें | 特殊なケースを処理
        if (value === '**') {
            this.display.value += '^';
        } else if (value === '*') {
            this.display.value += '×';
        } else {
            this.display.value += value;
        }

        this.currentInput = this.display.value;
    }

    /**
     * Clear entire display
     * Gesamtes Display löschen
     * पूरा डिस्प्ले साफ़ करें
     * ディスプレイ全体をクリア
     */
    public clearDisplay(): void {
        this.display.value = '';
        this.currentInput = '';
        this.shouldResetDisplay = false;
    }

    /**
     * Clear last entry (CE function)
     * Letzten Eintrag löschen (CE-Funktion)
     * अंतिम प्रविष्टि साफ़ करें (CE फ़ंक्शन)
     * 最後のエントリをクリア（CE機能）
     */
    public clearEntry(): void {
        this.display.value = '';
        this.currentInput = '';
    }

    /**
     * Delete last character (Backspace function)
     * Letztes Zeichen löschen (Rücktaste-Funktion)
     * अंतिम वर्ण हटाएं (बैकस्पेस फ़ंक्शन)
     * 最後の文字を削除（バックスペース機能）
     */
    public deleteLast(): void {
        if (this.display.value.length > 0) {
            this.display.value = this.display.value.slice(0, -1);
            this.currentInput = this.display.value;
        }
    }

    /**
     * Perform calculation and display result
     * Berechnung durchführen und Ergebnis anzeigen
     * गणना करें और परिणाम प्रदर्शित करें
     * 計算を実行し結果を表示
     */
    public calculate(): void {
        try {
            if (!this.currentInput && !this.display.value) {
                return;
            }

            // Prepare expression for evaluation | Ausdruck für Auswertung vorbereiten | मूल्यांकन के लिए अभिव्यक्ति तैयार करें | 評価のための式を準備
            let expression = this.display.value;
            
            // Replace visual operators with JavaScript operators
            // Visuelle Operatoren durch JavaScript-Operatoren ersetzen
            // दृश्य ऑपरेटरों को जावास्क्रिप्ट ऑपरेटरों से बदलें
            // 視覚的な演算子をJavaScript演算子に置換
            expression = expression
                .replace(/×/g, '*')
                .replace(/\^/g, '**')
                .replace(/÷/g, '/');

            // Validate expression | Ausdruck validieren | अभिव्यक्ति को मान्य करें | 式を検証
            if (!this.isValidExpression(expression)) {
                throw new Error('Invalid expression');
            }

            // Calculate result | Ergebnis berechnen | परिणाम की गणना करें | 結果を計算
            const result = this.evaluateExpression(expression);
            
            // Display result | Ergebnis anzeigen | परिणाम प्रदर्शित करें | 結果を表示
            this.display.value = this.formatResult(result);
            this.currentInput = this.display.value;
            this.shouldResetDisplay = true;

        } catch (error) {
            // Handle calculation errors | Berechnungsfehler behandeln | गणना त्रुटियों को संभालें | 計算エラーを処理
            this.display.value = 'Error';
            this.shouldResetDisplay = true;
            console.error('Calculation error:', error);
        }
    }

    /**
     * Validate mathematical expression
     * Mathematischen Ausdruck validieren
     * गणितीय अभिव्यक्ति को मान्य करें
     * 数学式を検証
     */
    private isValidExpression(expression: string): boolean {
        // Check for invalid characters | Ungültige Zeichen prüfen | अमान्य वर्णों की जांच करें | 無効な文字をチェック
        const validPattern = /^[0-9+\-*/.%() ]+$/;
        if (!validPattern.test(expression)) {
            return false;
        }

        // Check for balanced parentheses | Ausgeglichene Klammern prüfen | संतुलित कोष्ठक की जांच करें | バランスの取れた括弧をチェック
        let parenthesesCount = 0;
        for (const char of expression) {
            if (char === '(') parenthesesCount++;
            if (char === ')') parenthesesCount--;
            if (parenthesesCount < 0) return false;
        }

        return parenthesesCount === 0;
    }

    /**
     * Safely evaluate mathematical expression
     * Mathematischen Ausdruck sicher auswerten
     * गणितीय अभिव्यक्ति का सुरक्षित मूल्यांकन करें
     * 数学式を安全に評価
     */
    private evaluateExpression(expression: string): number {
        // Use Function constructor for safe evaluation
        // Function-Konstruktor für sichere Auswertung verwenden
        // सुरक्षित मूल्यांकन के लिए फ़ंक्शन कंस्ट्रक्टर का उपयोग करें
        // 安全な評価のためにFunctionコンストラクタを使用
        const sanitizedExpression = expression.replace(/[^0-9+\-*/.%() ]/g, '');
        return Function('"use strict"; return (' + sanitizedExpression + ')')();
    }

    /**
     * Format calculation result for display
     * Berechnungsergebnis für Anzeige formatieren
     * प्रदर्शन के लिए गणना परिणाम को प्रारूपित करें
     * 表示用に計算結果をフォーマット
     */
    private formatResult(result: number): string {
        // Handle special cases | Sonderfälle behandeln | विशेष मामलों को संभालें | 特殊なケースを処理
        if (!isFinite(result)) {
            return 'Error';
        }

        // Format to avoid floating point precision issues
        // Floating-Point-Präzisionsprobleme vermeiden
        // फ्लोटिंग पॉइंट सटीकता समस्याओं से बचें
        // 浮動小数点精度の問題を回避
        if (result % 1 === 0) {
            return result.toString();
        } else {
            return parseFloat(result.toFixed(10)).toString();
        }
    }

    /**
     * Add two numbers
     * Zwei Zahlen addieren
     * दो संख्याओं को जोड़ें
     * 二つの数値を足し算
     */
    public static add(a: number, b: number): number {
        return a + b;
    }

    /**
     * Subtract two numbers
     * Zwei Zahlen subtrahieren
     * दो संख्याओं को घटाएं
     * 二つの数値を引き算
     */
    public static subtract(a: number, b: number): number {
        return a - b;
    }

    /**
     * Multiply two numbers
     * Zwei Zahlen multiplizieren
     * दो संख्याओं को गुणा करें
     * 二つの数値を掛け算
     */
    public static multiply(a: number, b: number): number {
        return a * b;
    }

    /**
     * Divide two numbers
     * Zwei Zahlen dividieren
     * दो संख्याओं को भाग दें
     * 二つの数値を割り算
     */
    public static divide(a: number, b: number): number {
        if (b === 0) {
            throw new Error('Division by zero | Division durch Null | शून्य से भाग | ゼロ除算');
        }
        return a / b;
    }

    /**
     * Calculate modulo of two numbers
     * Modulo von zwei Zahlen berechnen
     * दो संख्याओं का मॉड्यूलो निकालें
     * 二つの数値の剰余を計算
     */
    public static modulo(a: number, b: number): number {
        if (b === 0) {
            throw new Error('Modulo by zero | Modulo durch Null | शून्य से मॉड्यूलो | ゼロでの剰余');
        }
        return a % b;
    }

    /**
     * Calculate power of two numbers
     * Potenz von zwei Zahlen berechnen
     * दो संख्याओं की घात निकालें
     * 二つの数値のべき乗を計算
     */
    public static power(base: number, exponent: number): number {
        return Math.pow(base, exponent);
    }
}

// Global variables and functions for HTML onclick events
// Globale Variablen und Funktionen für HTML-onclick-Events
// HTML onclick इवेंट्स के लिए ग्लोबल वेरिएबल्स और फ़ंक्शन
// HTML onclickイベント用のグローバル変数と関数

let calculatorInstance: Calculator;

// Initialize calculator when DOM is loaded
// Rechner initialisieren, wenn DOM geladen ist
// DOM लोड होने पर कैलकुलेटर को प्रारंभ करें
// DOMが読み込まれたときに電卓を初期化
document.addEventListener('DOMContentLoaded', () => {
    calculatorInstance = new Calculator();
});

// Global functions accessible from HTML
// Von HTML aus zugängliche globale Funktionen
// HTML से पहुंच योग्य ग्लोबल फ़ंक्शन
// HTMLからアクセス可能なグローバル関数

function appendToDisplay(value: string): void {
    if (calculatorInstance) {
        calculatorInstance.appendToDisplay(value);
    }
}

function clearDisplay(): void {
    if (calculatorInstance) {
        calculatorInstance.clearDisplay();
    }
}

function clearEntry(): void {
    if (calculatorInstance) {
        calculatorInstance.clearEntry();
    }
}

function deleteLast(): void {
    if (calculatorInstance) {
        calculatorInstance.deleteLast();
    }
}

function calculate(): void {
    if (calculatorInstance) {
        calculatorInstance.calculate();
    }
}
