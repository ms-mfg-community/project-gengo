package calculator.src.main.java.com.project13;

/**
 * Class to hold the result of a calculation along with operation validity
 */
public class CalculationResult {
    private final double result;
    private final boolean validOperation;

    public CalculationResult(double result, boolean validOperation) {
        this.result = result;
        this.validOperation = validOperation;
    }

    public double getResult() {
        return result;
    }

    public boolean isValidOperation() {
        return validOperation;
    }
}