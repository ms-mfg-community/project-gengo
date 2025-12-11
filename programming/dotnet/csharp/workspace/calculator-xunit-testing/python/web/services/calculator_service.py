"""
Service that manages calculator state and operations.

This service maintains the state of the calculator including operands,
pending operations, and display value. It handles button clicks and
performs calculations.
"""

import math
import sys
import os
from typing import Optional, Callable

# Add parent directory to path to import calculator module
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))
from calculator.calculator import Calculator


class CalculatorService:
    """
    Service that manages calculator state and operations.
    
    Maintains the state of the calculator and provides methods for handling
    user interactions such as number inputs, operator selections, and
    calculation execution.
    """
    
    def __init__(self):
        """Initialize the calculator service with default state."""
        self._first_operand: Optional[float] = None
        self._second_operand: Optional[float] = None
        self._pending_operation: Optional[str] = None
        self._should_reset_display: bool = False
        self._last_first_operand: str = ""
        self._last_second_operand: str = ""
        self.display: str = "0"
        self._on_calculation_completed: Optional[Callable] = None
    
    def set_calculation_completed_callback(self, callback: Callable) -> None:
        """
        Set callback for when a calculation is completed.
        
        Args:
            callback: Function to call with (operand1, operator, operand2, result)
        """
        self._on_calculation_completed = callback
    
    def handle_number_click(self, digit: str) -> None:
        """
        Handles number button clicks.
        
        Args:
            digit: The digit or decimal point clicked
        """
        if self._should_reset_display:
            self.display = "0." if digit == "." else digit
            self._should_reset_display = False
        else:
            if digit == "." and "." in self.display:
                return
            
            if self.display == "0" and digit != ".":
                self.display = digit
            elif self.display == "0" and digit == ".":
                self.display = "0."
            else:
                self.display += digit
    
    def handle_operator_click(self, op: str) -> None:
        """
        Handles operator button clicks.
        
        Args:
            op: The operator clicked (+, -, *, /, %, ^)
        """
        try:
            current_value = float(self.display)
            
            if self._first_operand is None:
                self._first_operand = current_value
                self._last_first_operand = self.display
            elif self._pending_operation:
                self._second_operand = current_value
                self._last_second_operand = self.display
                self._perform_pending_operation()
                try:
                    self._first_operand = float(self.display)
                except ValueError:
                    self._first_operand = 0.0
                self._last_first_operand = self.display
                self._second_operand = None
            
            self._pending_operation = op
            self._should_reset_display = True
        except ValueError:
            pass
    
    def handle_equals(self) -> None:
        """Handles equals button click."""
        if self._first_operand is not None and self._pending_operation:
            try:
                current_value = float(self.display)
                self._second_operand = current_value
                self._last_second_operand = self.display
                self._perform_pending_operation()
                
                # Raise event with calculation details for history
                if self._on_calculation_completed:
                    self._on_calculation_completed(
                        self._last_first_operand,
                        self._pending_operation,
                        self._last_second_operand,
                        self.display
                    )
                
                self._first_operand = None
                self._pending_operation = None
                self._should_reset_display = True
            except ValueError:
                pass
    
    def handle_clear(self) -> None:
        """Handles clear button click."""
        self.display = "0"
        self._first_operand = None
        self._second_operand = None
        self._pending_operation = None
        self._should_reset_display = False
        self._last_first_operand = ""
        self._last_second_operand = ""
    
    def _perform_pending_operation(self) -> None:
        """Performs the pending operation."""
        if (self._first_operand is None or 
            self._second_operand is None or 
            not self._pending_operation):
            return
        
        result = Calculator.perform_calculation(
            self._first_operand,
            self._pending_operation,
            self._second_operand
        )
        
        if math.isnan(result):
            self.display = "Error"
        else:
            self.display = self._format_result(result)
    
    def _format_result(self, value: float) -> str:
        """
        Formats the result for display.
        
        Args:
            value: The value to format
            
        Returns:
            Formatted string representation
        """
        if math.isinf(value) or math.isnan(value):
            return "Error"
        
        # Format to remove unnecessary trailing zeros
        formatted = f"{value:.15g}"
        if len(formatted) > 12:
            formatted = formatted[:12] + "..."
        
        return formatted
