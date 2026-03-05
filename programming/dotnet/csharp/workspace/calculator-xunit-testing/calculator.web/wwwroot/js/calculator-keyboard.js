/* Calculator Keyboard Interop Module */
window.calculatorKeyboard = {
    _dotNetRef: null,

    init: function (dotNetRef) {
        this._dotNetRef = dotNetRef;
        document.addEventListener('keydown', this._handleKeyDown.bind(this));
    },

    _handleKeyDown: function (e) {
        if (!this._dotNetRef) return;

        var validKeys = [
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            '.', '+', '-', '*', '/', '^', '%', '=',
            'Enter', 'Backspace', 'Delete', 'c', 'C'
        ];

        if (validKeys.indexOf(e.key) !== -1) {
            e.preventDefault();
            this._dotNetRef.invokeMethodAsync('HandleKeyPress', e.key);
        }
    }
};
