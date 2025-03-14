package com.calculator;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the Calculator class.
 */
public class CalculatorTest {

    @Test
    @DisplayName("Test addition operation")
    public void testAddition() {
        assertEquals(8, Calculator.calculate(5, 3, '+'));
        assertEquals(0, Calculator.calculate(-5, 5, '+'));
        assertEquals(-2, Calculator.calculate(-5, 3, '+'));
    }
    
    @Test
    @DisplayName("Test subtraction operation")
    public void testSubtraction() {
        assertEquals(2, Calculator.calculate(5, 3, '-'));
        assertEquals(-2, Calculator.calculate(3, 5, '-'));
        assertEquals(-8, Calculator.calculate(-5, 3, '-'));
    }
    
    @Test
    @DisplayName("Test multiplication operation")
    public void testMultiplication() {
        assertEquals(15, Calculator.calculate(5, 3, '*'));
        assertEquals(-15, Calculator.calculate(-5, 3, '*'));
        assertEquals(15, Calculator.calculate(-5, -3, '*'));
    }
    
    @Test
    @DisplayName("Test division operation")
    public void testDivision() {
        assertEquals(2, Calculator.calculate(6, 3, '/'));
        assertEquals(2.5, Calculator.calculate(5, 2, '/'));
        assertEquals(-2, Calculator.calculate(-6, 3, '/'));
    }
    
    @Test
    @DisplayName("Test division by zero")
    public void testDivisionByZero() {
        assertEquals(0, Calculator.calculate(5, 0, '/'));
    }
    
    @Test
    @DisplayName("Test invalid operator")
    public void testInvalidOperator() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            Calculator.calculate(5, 3, '%');
        });
        
        assertTrue(exception.getMessage().contains("Unsupported operator"));
    }
}