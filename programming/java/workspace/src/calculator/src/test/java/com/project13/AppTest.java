package calculator.src.test.java.com.project13;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import java.util.logging.Logger;
import java.util.logging.Level;

import calculator.src.main.java.com.project13.App;
import calculator.src.main.java.com.project13.CalculationResult;

/**
 * Unit tests for the App class calculation methods
 */
public class AppTest {
    
    private static final double DELTA = 0.0001;
    private static final Logger logger = Logger.getLogger(AppTest.class.getName());
    
    @BeforeEach
    public void setup() {
        // Configure logger to show all messages
        logger.setLevel(Level.INFO);
    }
    
    /**
     * Logs the details of a calculation operation
     * @param methodName The name of the method being tested
     * @param a First operand
     * @param b Second operand
     * @param expectedResult Expected result
     * @param actualResult Actual result
     */
    private void logCalculationDetails(String methodName, double a, double b, double expectedResult, double actualResult) {
        logger.info(String.format(
            "Testing %s: %f %s %f = %f (expected: %f)",
            methodName, a, getOperatorSymbol(methodName), b, actualResult, expectedResult
        ));
    }
    
    /**
     * Returns the operator symbol based on the method name
     */
    private String getOperatorSymbol(String methodName) {
        switch (methodName.toLowerCase()) {
            case "add": return "+";
            case "subtract": return "-";
            case "multiply": return "*";
            case "divide": return "/";
            case "modulo": return "%";
            case "power": return "^";
            default: return "?";
        }
    }
    
    @Test
    @DisplayName("Test addition method")
    public void testAdd() {
        double result = App.add(2.0, 3.0);
        logCalculationDetails("add", 2.0, 3.0, 5.0, result);
        assertEquals(5.0, result, DELTA, "2.0 + 3.0 should equal 5.0");
        
        result = App.add(-4.0, 3.0);
        logCalculationDetails("add", -4.0, 3.0, -1.0, result);
        assertEquals(-1.0, result, DELTA, "-4.0 + 3.0 should equal -1.0");
        
        result = App.add(0.0, 0.0);
        logCalculationDetails("add", 0.0, 0.0, 0.0, result);
        assertEquals(0.0, result, DELTA, "0.0 + 0.0 should equal 0.0");
        
        result = App.add(2.5, 3.0);
        logCalculationDetails("add", 2.5, 3.0, 5.5, result);
        assertEquals(5.5, result, DELTA, "2.5 + 3.0 should equal 5.5");
    }
    
    @Test
    @DisplayName("Test subtraction method")
    public void testSubtract() {
        double result = App.subtract(5.0, 3.0);
        logCalculationDetails("subtract", 5.0, 3.0, 2.0, result);
        assertEquals(2.0, result, DELTA, "5.0 - 3.0 should equal 2.0");
        
        result = App.subtract(-4.0, 3.0);
        logCalculationDetails("subtract", -4.0, 3.0, -7.0, result);
        assertEquals(-7.0, result, DELTA, "-4.0 - 3.0 should equal -7.0");
        
        result = App.subtract(0.0, 0.0);
        logCalculationDetails("subtract", 0.0, 0.0, 0.0, result);
        assertEquals(0.0, result, DELTA, "0.0 - 0.0 should equal 0.0");
        
        result = App.subtract(2.5, 3.0);
        logCalculationDetails("subtract", 2.5, 3.0, -0.5, result);
        assertEquals(-0.5, result, DELTA, "2.5 - 3.0 should equal -0.5");
    }
    
    @Test
    @DisplayName("Test multiplication method")
    public void testMultiply() {
        double result = App.multiply(5.0, 3.0);
        logCalculationDetails("multiply", 5.0, 3.0, 15.0, result);
        assertEquals(15.0, result, DELTA, "5.0 * 3.0 should equal 15.0");
        
        result = App.multiply(-4.0, 3.0);
        logCalculationDetails("multiply", -4.0, 3.0, -12.0, result);
        assertEquals(-12.0, result, DELTA, "-4.0 * 3.0 should equal -12.0");
        
        result = App.multiply(0.0, 5.0);
        logCalculationDetails("multiply", 0.0, 5.0, 0.0, result);
        assertEquals(0.0, result, DELTA, "0.0 * 5.0 should equal 0.0");
        
        result = App.multiply(2.5, 3.0);
        logCalculationDetails("multiply", 2.5, 3.0, 7.5, result);
        assertEquals(7.5, result, DELTA, "2.5 * 3.0 should equal 7.5");
    }
    
    @Test
    @DisplayName("Test division method with valid inputs")
    public void testDivideValid() {
        CalculationResult result = App.divide(6.0, 3.0);
        logger.info(String.format("Testing divide: %f / %f = %f (valid: %b)", 
                    6.0, 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation(), "Division 6.0 / 3.0 should be valid");
        assertEquals(2.0, result.getResult(), DELTA, "6.0 / 3.0 should equal 2.0");
        
        result = App.divide(-6.0, 3.0);
        logger.info(String.format("Testing divide: %f / %f = %f (valid: %b)", 
                    -6.0, 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation(), "Division -6.0 / 3.0 should be valid");
        assertEquals(-2.0, result.getResult(), DELTA, "-6.0 / 3.0 should equal -2.0");
        
        result = App.divide(0.0, 5.0);
        logger.info(String.format("Testing divide: %f / %f = %f (valid: %b)", 
                    0.0, 5.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation(), "Division 0.0 / 5.0 should be valid");
        assertEquals(0.0, result.getResult(), DELTA, "0.0 / 5.0 should equal 0.0");
    }
    
    @Test
    @DisplayName("Test division method with division by zero")
    public void testDivideByZero() {
        CalculationResult result = App.divide(6.0, 0.0);
        logger.info(String.format("Testing divide by zero: %f / %f (valid: %b)", 
                    6.0, 0.0, result.isValidOperation()));
        assertFalse(result.isValidOperation(), "Division by zero should be invalid");
    }
    
    @Test
    @DisplayName("Test modulo method with valid inputs")
    public void testModuloValid() {
        CalculationResult result = App.modulo(7.0, 3.0);
        logger.info(String.format("Testing modulo: %f %% %f = %f (valid: %b)", 
                    7.0, 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation(), "Modulo 7.0 % 3.0 should be valid");
        assertEquals(1.0, result.getResult(), DELTA, "7.0 % 3.0 should equal 1.0");
        
        result = App.modulo(-7.0, 3.0);
        logger.info(String.format("Testing modulo: %f %% %f = %f (valid: %b)", 
                    -7.0, 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation(), "Modulo -7.0 % 3.0 should be valid");
        assertEquals(-1.0, result.getResult(), DELTA, "-7.0 % 3.0 should equal -1.0");
        
        result = App.modulo(0.0, 5.0);
        logger.info(String.format("Testing modulo: %f %% %f = %f (valid: %b)", 
                    0.0, 5.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation(), "Modulo 0.0 % 5.0 should be valid");
        assertEquals(0.0, result.getResult(), DELTA, "0.0 % 5.0 should equal 0.0");
    }
    
    @Test
    @DisplayName("Test modulo method with modulo by zero")
    public void testModuloByZero() {
        CalculationResult result = App.modulo(6.0, 0.0);
        logger.info(String.format("Testing modulo by zero: %f %% %f (valid: %b)", 
                    6.0, 0.0, result.isValidOperation()));
        assertFalse(result.isValidOperation(), "Modulo by zero should be invalid");
    }
    
    @Test
    @DisplayName("Test power method")
    public void testPower() {
        double result = App.power(2.0, 3.0);
        logCalculationDetails("power", 2.0, 3.0, 8.0, result);
        assertEquals(8.0, result, DELTA, "2.0 ^ 3.0 should equal 8.0");
        
        result = App.power(2.0, -1.0);
        logCalculationDetails("power", 2.0, -1.0, 0.5, result);
        assertEquals(0.5, result, DELTA, "2.0 ^ -1.0 should equal 0.5");
        
        result = App.power(5.0, 0.0);
        logCalculationDetails("power", 5.0, 0.0, 1.0, result);
        assertEquals(1.0, result, DELTA, "5.0 ^ 0.0 should equal 1.0");
        
        result = App.power(0.0, 5.0);
        logCalculationDetails("power", 0.0, 5.0, 0.0, result);
        assertEquals(0.0, result, DELTA, "0.0 ^ 5.0 should equal 0.0");
        
        result = App.power(0.0, 0.0);
        logCalculationDetails("power", 0.0, 0.0, 1.0, result);
        assertEquals(1.0, result, DELTA, "0.0 ^ 0.0 should equal 1.0 (mathematical convention)");
    }
    
    @Test
    @DisplayName("Test calculate method with various operations")
    public void testCalculate() {
        // Test addition
        CalculationResult result = App.calculate(2.0, 3.0, "+");
        logger.info(String.format("Testing calculate: %f %s %f = %f (valid: %b)", 
                    2.0, "+", 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation());
        assertEquals(5.0, result.getResult(), DELTA);
        
        // Test subtraction
        result = App.calculate(5.0, 3.0, "-");
        logger.info(String.format("Testing calculate: %f %s %f = %f (valid: %b)", 
                    5.0, "-", 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation());
        assertEquals(2.0, result.getResult(), DELTA);
        
        // Test multiplication
        result = App.calculate(2.0, 3.0, "*");
        logger.info(String.format("Testing calculate: %f %s %f = %f (valid: %b)", 
                    2.0, "*", 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation());
        assertEquals(6.0, result.getResult(), DELTA);
        
        // Test division
        result = App.calculate(6.0, 2.0, "/");
        logger.info(String.format("Testing calculate: %f %s %f = %f (valid: %b)", 
                    6.0, "/", 2.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation());
        assertEquals(3.0, result.getResult(), DELTA);
        
        // Test modulo
        result = App.calculate(7.0, 3.0, "%");
        logger.info(String.format("Testing calculate: %f %s %f = %f (valid: %b)", 
                    7.0, "%", 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation());
        assertEquals(1.0, result.getResult(), DELTA);
        
        // Test power
        result = App.calculate(2.0, 3.0, "^");
        logger.info(String.format("Testing calculate: %f %s %f = %f (valid: %b)", 
                    2.0, "^", 3.0, result.getResult(), result.isValidOperation()));
        assertTrue(result.isValidOperation());
        assertEquals(8.0, result.getResult(), DELTA);
        
        // Test invalid operator
        result = App.calculate(2.0, 3.0, "$");
        logger.info(String.format("Testing calculate with invalid operator: %f %s %f (valid: %b)", 
                    2.0, "$", 3.0, result.isValidOperation()));
        assertFalse(result.isValidOperation());
    }
}
