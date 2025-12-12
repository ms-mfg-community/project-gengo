"""
Service that manages calculation history with persistent database storage.

This service provides access to calculation history stored in SQLite database,
maintaining compatibility with existing session-based interface while enabling
persistent storage. Maximum history items per user session: 50.
"""

from datetime import datetime
from typing import List, Optional

from services.database_service import DatabaseService, CalculationRecord as DBCalculationRecord


class CalculationRecord:
    """Represents a single calculation record in the history."""
    
    def __init__(self, operand1: str, operator: str, operand2: str, 
                 result: str, timestamp: Optional[datetime] = None, id: int = 0):
        """
        Initialize a calculation record.
        
        Args:
            operand1: First operand of the calculation
            operator: Operator used (+, -, *, /, %, ^)
            operand2: Second operand of the calculation
            result: Result of the calculation
            timestamp: When the calculation was performed (defaults to now)
            id: Database ID of the record
        """
        self.id = id
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
            'id': self.id,
            'operand1': self.operand1,
            'operator': self.operator,
            'operand2': self.operand2,
            'result': self.result,
            'timestamp': self.timestamp.isoformat(),
            'display_text': self.get_display_text()
        }


class HistoryService:
    """
    Service that manages calculation history with persistent database storage.
    
    Uses SQLite database backend for persistent storage while maintaining
    session-based interface compatibility. Enforces maximum 50 items per session.
    """
    
    MAX_ITEMS = 50
    
    def __init__(self):
        """Initialize the history service with database backend."""
        self._db_service = DatabaseService()
    
    @property
    def calculations(self) -> List[CalculationRecord]:
        """
        List of calculation records from database (newest first).
        
        Returns:
            List of calculation records, limited to MAX_ITEMS
        """
        db_records = self._db_service.get_all_history(limit=self.MAX_ITEMS)
        
        records = []
        for db_rec in db_records:
            # Parse ISO format timestamp
            timestamp = datetime.fromisoformat(db_rec.created_at)
            record = CalculationRecord(
                operand1=str(db_rec.operand1),
                operator=db_rec.operator,
                operand2=str(db_rec.operand2),
                result=str(db_rec.result),
                timestamp=timestamp,
                id=db_rec.id
            )
            records.append(record)
        
        return records
    
    def add_calculation(self, operand1: str, operator: str, 
                       operand2: str, result: str) -> None:
        """
        Adds a new calculation to database history.
        
        Args:
            operand1: First operand
            operator: Operation performed
            operand2: Second operand
            result: Result of the calculation
        """
        # Convert to float for storage
        try:
            op1 = float(operand1)
            op2 = float(operand2)
            res = float(result)
        except (ValueError, TypeError):
            # Skip invalid numeric conversions
            return
        
        self._db_service.create_calculation(op1, operator, op2, res)
        
        # Enforce max items by deleting oldest if exceeded
        count = self._db_service.get_history_count()
        if count > self.MAX_ITEMS:
            # Get oldest record and delete it
            all_records = self._db_service.get_all_history(limit=None)
            if all_records:
                oldest = all_records[-1]  # Last in descending order = oldest
                self._db_service.delete_calculation(oldest.id)
    
    def clear_history(self) -> None:
        """Clears all calculation history from database."""
        self._db_service.delete_all_history()
    
    def replay_calculation(self, index: int) -> Optional[str]:
        """
        Replays a calculation from history by index.
        
        Args:
            index: Index of the calculation to replay (from most recent)
            
        Returns:
            The result value, or None if index is invalid
        """
        records = self.calculations
        if 0 <= index < len(records):
            return records[index].result
        return None
    
    @property
    def is_empty(self) -> bool:
        """
        Checks if history is empty.
        
        Returns:
            True if history is empty, False otherwise
        """
        return self._db_service.get_history_count() == 0
    
    @property
    def count(self) -> int:
        """
        Gets the count of items in history.
        
        Returns:
            Number of items in history
        """
        return self._db_service.get_history_count()
    
    def get_all_as_dicts(self) -> List[dict]:
        """
        Get all calculations as dictionaries for JSON serialization.
        
        Returns:
            List of calculation dictionaries, newest first
        """
        return [calc.to_dict() for calc in self.calculations]
