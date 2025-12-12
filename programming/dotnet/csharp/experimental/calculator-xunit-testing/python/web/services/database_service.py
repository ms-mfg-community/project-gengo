"""
Database service for CRUD operations on calculator data.

Provides methods for creating, reading, updating, and deleting
calculation history records from SQLite database.
"""

from datetime import datetime
from typing import List, Optional, Dict, Any

from database import get_db_connection


class CalculationRecord:
    """
    Represents a calculation record in the database.
    
    Attributes:
        id: Unique identifier
        operand1: First operand
        operator: Operation symbol (+, -, *, /, %, ^)
        operand2: Second operand
        result: Calculation result
        created_at: ISO format timestamp
    """
    
    def __init__(self, operand1: float, operator: str, operand2: float, 
                 result: float, created_at: str = "", id: int = 0):
        """Initialize a calculation record."""
        self.id = id
        self.operand1 = operand1
        self.operator = operator
        self.operand2 = operand2
        self.result = result
        self.created_at = created_at or datetime.now().isoformat()
    
    def to_dict(self) -> Dict[str, Any]:
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
            'created_at': self.created_at
        }


class DatabaseService:
    """
    Service for managing calculation history in SQLite database.
    
    Implements basic CRUD operations:
    - CREATE: Add new calculations to history
    - READ: Retrieve calculations from history
    - UPDATE: Modify existing calculations
    - DELETE: Remove calculations from history
    """
    
    def create_calculation(self, operand1: float, operator: str, 
                          operand2: float, result: float) -> int:
        """
        Create a new calculation record in the database.
        
        Args:
            operand1: First operand
            operator: Operation symbol
            operand2: Second operand
            result: Calculation result
            
        Returns:
            ID of the created record
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute(
                """
                INSERT INTO calculation_history 
                (operand1, operator, operand2, result)
                VALUES (?, ?, ?, ?)
                """,
                (operand1, operator, operand2, result)
            )
            conn.commit()
            return cursor.lastrowid
        
        finally:
            conn.close()
    
    def get_all_history(self, limit: int = 50) -> List[CalculationRecord]:
        """
        Retrieve all calculation history records.
        
        Args:
            limit: Maximum number of records to return (most recent first)
            
        Returns:
            List of CalculationRecord objects ordered by most recent first
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute(
                """
                SELECT id, operand1, operator, operand2, result, created_at
                FROM calculation_history
                ORDER BY created_at DESC
                LIMIT ?
                """,
                (limit,)
            )
            
            records = []
            for row in cursor.fetchall():
                records.append(CalculationRecord(
                    operand1=row['operand1'],
                    operator=row['operator'],
                    operand2=row['operand2'],
                    result=row['result'],
                    created_at=row['created_at'],
                    id=row['id']
                ))
            
            return records
        
        finally:
            conn.close()
    
    def get_calculation(self, record_id: int) -> Optional[CalculationRecord]:
        """
        Retrieve a specific calculation by ID.
        
        Args:
            record_id: ID of the calculation to retrieve
            
        Returns:
            CalculationRecord if found, None otherwise
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute(
                """
                SELECT id, operand1, operator, operand2, result, created_at
                FROM calculation_history
                WHERE id = ?
                """,
                (record_id,)
            )
            
            row = cursor.fetchone()
            if row:
                return CalculationRecord(
                    operand1=row['operand1'],
                    operator=row['operator'],
                    operand2=row['operand2'],
                    result=row['result'],
                    created_at=row['created_at'],
                    id=row['id']
                )
            
            return None
        
        finally:
            conn.close()
    
    def update_calculation(self, record_id: int, operand1: Optional[float] = None,
                          operator: Optional[str] = None, operand2: Optional[float] = None,
                          result: Optional[float] = None) -> bool:
        """
        Update an existing calculation record.
        
        Args:
            record_id: ID of the record to update
            operand1: New first operand (optional)
            operator: New operator (optional)
            operand2: New second operand (optional)
            result: New result (optional)
            
        Returns:
            True if update successful, False if record not found
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            # Get current record
            record = self.get_calculation(record_id)
            if not record:
                return False
            
            # Use provided values or keep existing ones
            new_operand1 = operand1 if operand1 is not None else record.operand1
            new_operator = operator if operator is not None else record.operator
            new_operand2 = operand2 if operand2 is not None else record.operand2
            new_result = result if result is not None else record.result
            
            cursor.execute(
                """
                UPDATE calculation_history
                SET operand1 = ?, operator = ?, operand2 = ?, result = ?
                WHERE id = ?
                """,
                (new_operand1, new_operator, new_operand2, new_result, record_id)
            )
            
            conn.commit()
            return cursor.rowcount > 0
        
        finally:
            conn.close()
    
    def delete_calculation(self, record_id: int) -> bool:
        """
        Delete a specific calculation record.
        
        Args:
            record_id: ID of the record to delete
            
        Returns:
            True if deletion successful, False if record not found
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute(
                "DELETE FROM calculation_history WHERE id = ?",
                (record_id,)
            )
            
            conn.commit()
            return cursor.rowcount > 0
        
        finally:
            conn.close()
    
    def delete_all_history(self) -> int:
        """
        Delete all calculation history records.
        
        Returns:
            Number of records deleted
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute("DELETE FROM calculation_history")
            conn.commit()
            return cursor.rowcount
        
        finally:
            conn.close()
    
    def get_history_count(self) -> int:
        """
        Get the total number of calculation history records.
        
        Returns:
            Number of records in history
        """
        conn = get_db_connection()
        cursor = conn.cursor()
        
        try:
            cursor.execute("SELECT COUNT(*) FROM calculation_history")
            count = cursor.fetchone()[0]
            return count
        
        finally:
            conn.close()
