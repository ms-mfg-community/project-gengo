"""
Service that manages calculation history.

This service maintains a session-only history of calculations with a
maximum limit of 50 items. It provides methods to add, clear, and replay
calculations from history.
"""

from datetime import datetime
from typing import List, Optional


class CalculationRecord:
    """Represents a single calculation record in the history."""
    
    def __init__(self, operand1: str, operator: str, operand2: str, 
                 result: str, timestamp: Optional[datetime] = None):
        """
        Initialize a calculation record.
        
        Args:
            operand1: First operand of the calculation
            operator: Operator used (+, -, *, /, %, ^)
            operand2: Second operand of the calculation
            result: Result of the calculation
            timestamp: When the calculation was performed (defaults to now)
        """
        self.operand1 = operand1
        self.operator = operator
        self.operand2 = operand2
        self.result = result
        self.timestamp = timestamp or datetime.now()
    
    def get_display_text(self) -> str:
        """
        Get formatted display string for the calculation.
        
        Returns:
            Formatted string like "5 + 3 = 8 (2:45 PM)"
        """
        time_str = self.timestamp.strftime("%I:%M %p")
        return f"{self.operand1} {self.operator} {self.operand2} = {self.result} ({time_str})"
    
    def to_dict(self) -> dict:
        """
        Convert record to dictionary for JSON serialization.
        
        Returns:
            Dictionary representation of the record
        """
        return {
            'operand1': self.operand1,
            'operator': self.operator,
            'operand2': self.operand2,
            'result': self.result,
            'timestamp': self.timestamp.isoformat(),
            'display_text': self.get_display_text()
        }


class HistoryService:
    """
    Service that manages calculation history (session-only, max 50 items).
    
    Maintains a list of calculation records and provides methods for
    managing the history including adding new records, clearing history,
    and replaying calculations.
    """
    
    MAX_ITEMS = 50
    
    def __init__(self):
        """Initialize the history service with an empty history."""
        self._calculations: List[CalculationRecord] = []
    
    @property
    def calculations(self) -> List[CalculationRecord]:
        """
        List of calculation records (newest first).
        
        Returns:
            Read-only list of calculation records
        """
        return self._calculations.copy()
    
    def add_calculation(self, operand1: str, operator: str, 
                       operand2: str, result: str) -> None:
        """
        Adds a new calculation to history.
        
        Args:
            operand1: First operand
            operator: Operation performed
            operand2: Second operand
            result: Result of the calculation
        """
        record = CalculationRecord(operand1, operator, operand2, result)
        self._calculations.insert(0, record)
        
        # Keep only last MAX_ITEMS items (FIFO)
        if len(self._calculations) > self.MAX_ITEMS:
            self._calculations.pop()
    
    def clear_history(self) -> None:
        """Clears all history."""
        self._calculations.clear()
    
    def replay_calculation(self, index: int) -> Optional[str]:
        """
        Replays a calculation from history.
        
        Args:
            index: Index of the calculation to replay
            
        Returns:
            The result value, or None if index is invalid
        """
        if 0 <= index < len(self._calculations):
            return self._calculations[index].result
        return None
    
    @property
    def is_empty(self) -> bool:
        """
        Checks if history is empty.
        
        Returns:
            True if history is empty, False otherwise
        """
        return len(self._calculations) == 0
    
    @property
    def count(self) -> int:
        """
        Gets the count of items in history.
        
        Returns:
            Number of items in history
        """
        return len(self._calculations)
    
    def get_all_as_dicts(self) -> List[dict]:
        """
        Get all calculations as dictionaries for JSON serialization.
        
        Returns:
            List of calculation dictionaries
        """
        return [calc.to_dict() for calc in self._calculations]
