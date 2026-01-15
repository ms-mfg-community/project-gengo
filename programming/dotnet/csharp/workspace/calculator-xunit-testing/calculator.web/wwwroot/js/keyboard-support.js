/**
 * Keyboard support module for calculator application.
 * Handles global keyboard events and dispatches them to Blazor components.
 */

export function initializeKeyboardSupport(dotnetHelper) {
    document.addEventListener('keydown', (e) => {
        handleKeyPress(e, dotnetHelper);
    });
}

function handleKeyPress(event, dotnetHelper) {
    const key = event.key;

    // Digit keys 0-9
    if (/^\d$/.test(key)) {
        dotnetHelper.invokeMethodAsync('HandleDigitKey', key);
        event.preventDefault();
        return;
    }

    // Decimal point
    if (key === '.') {
        dotnetHelper.invokeMethodAsync('HandleDigitKey', '.');
        event.preventDefault();
        return;
    }

    // Operators
    const operatorMap = {
        '+': '+',
        '-': '-',
        '*': '*',
        '/': '/',
        '^': '^'
    };

    if (key in operatorMap) {
        dotnetHelper.invokeMethodAsync('HandleOperator', operatorMap[key]);
        event.preventDefault();
        return;
    }

    // Enter or = for calculation
    if (key === 'Enter' || key === '=') {
        dotnetHelper.invokeMethodAsync('HandleEquals');
        event.preventDefault();
        return;
    }

    // Clear (Backspace, Delete, C)
    if (key === 'Backspace' || key === 'Delete' || key.toUpperCase() === 'C') {
        dotnetHelper.invokeMethodAsync('HandleClear');
        event.preventDefault();
        return;
    }
}
