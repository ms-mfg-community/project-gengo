"""
Database initialization and management module.

Handles database connection, schema creation, and test data seeding.
"""

import csv
import os
import sqlite3
from pathlib import Path
from typing import Optional


# Database file path
DB_DIR = Path(__file__).parent / "data"
DB_PATH = DB_DIR / "calculator.db"


def get_db_connection() -> sqlite3.Connection:
    """
    Get a database connection.
    
    Returns:
        sqlite3.Connection: Database connection with row factory configured
    """
    conn = sqlite3.connect(str(DB_PATH))
    conn.row_factory = sqlite3.Row
    return conn


def init_db() -> None:
    """
    Initialize the database with schema and seed test data on first run.
    
    Creates tables if they don't exist and loads test data from CSV
    only on the first run (when database is empty).
    """
    # Ensure data directory exists
    DB_DIR.mkdir(parents=True, exist_ok=True)
    
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Load and execute schema
        schema_path = Path(__file__).parent / "schema.sql"
        with open(schema_path, 'r') as schema_file:
            schema_sql = schema_file.read()
            cursor.executescript(schema_sql)
        
        # Seed test data only on first run (if test_cases table is empty)
        cursor.execute("SELECT COUNT(*) FROM test_cases")
        test_data_exists = cursor.fetchone()[0] > 0
        
        if not test_data_exists:
            seed_test_data(cursor)
        
        conn.commit()
    except Exception as e:
        print(f"Error initializing database: {e}")
        conn.rollback()
        raise
    finally:
        conn.close()


def seed_test_data(cursor: sqlite3.Cursor) -> None:
    """
    Seed test data from CSV file into test_cases table.
    
    Args:
        cursor: sqlite3.Cursor for database operations
    """
    csv_path = Path(__file__).parent.parent / "tests" / "test_data" / "CalculatorTestData.csv"
    
    if not csv_path.exists():
        print(f"Warning: Test data CSV not found at {csv_path}")
        return
    
    with open(csv_path, 'r', encoding='utf-8-sig') as csv_file:
        csv_reader = csv.reader(csv_file)
        next(csv_reader)  # Skip header
        
        for row in csv_reader:
            if not row or len(row) < 4:
                continue
            
            try:
                first_number = float(row[0].strip())
                second_number = float(row[1].strip())
                operation = row[2].strip()
                expected_value = float(row[3].strip())
                result = row[4].strip() if len(row) > 4 else "unknown"
                
                cursor.execute(
                    """
                    INSERT INTO test_cases 
                    (first_number, second_number, operation, expected_value, result)
                    VALUES (?, ?, ?, ?, ?)
                    """,
                    (first_number, second_number, operation, expected_value, result)
                )
            except (ValueError, IndexError) as e:
                print(f"Warning: Error parsing CSV row {row}: {e}")
                continue
