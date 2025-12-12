// Keyboard support for calculator
window.calculatorKeyboard = {
    initialize: function (dotnetHelper) {
        this.dotnetHelper = dotnetHelper;
        document.addEventListener('keydown', this.handleKeyDown.bind(this));
    },

    handleKeyDown: function (event) {
        const key = event.key;

        // Number keys (0-9)
        if (key >= '0' && key <= '9') {
            event.preventDefault();
            this.dotnetHelper.invokeMethodAsync('HandleNumberClick', key);
            return;
        }

        // Decimal point
        if (key === '.') {
            event.preventDefault();
            this.dotnetHelper.invokeMethodAsync('HandleNumberClick', '.');
            return;
        }

        // Operators
        const operators = {
            '+': '+',
            '-': '-',
            '*': '*',
            '/': '/',
            '^': '^'
        };

        if (operators[key]) {
            event.preventDefault();
            this.dotnetHelper.invokeMethodAsync('HandleOperatorClick', operators[key]);
            return;
        }

        // Equals
        if (key === 'Enter' || key === '=') {
            event.preventDefault();
            this.dotnetHelper.invokeMethodAsync('HandleEquals');
            return;
        }

        // Clear
        if (key === 'Backspace' || key === 'Delete' || key.toUpperCase() === 'C') {
            event.preventDefault();
            this.dotnetHelper.invokeMethodAsync('HandleClear');
            return;
        }
    }
};
