import './styles.css';
import { CalculatorUI } from './calculatorUI';
document.addEventListener('DOMContentLoaded', () => {
    new CalculatorUI();
});
// Enable HMR
if (import.meta.hot) {
    import.meta.hot.accept();
}
