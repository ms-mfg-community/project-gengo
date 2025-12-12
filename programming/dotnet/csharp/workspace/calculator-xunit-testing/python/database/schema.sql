-- Calculator Database Schema
-- Tables for test data and calculation history

CREATE TABLE IF NOT EXISTS test_cases (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_number REAL NOT NULL,
    second_number REAL NOT NULL,
    operation TEXT NOT NULL,
    expected_value REAL NOT NULL,
    result TEXT DEFAULT 'unknown',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS calculation_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    operand1 REAL NOT NULL,
    operator TEXT NOT NULL,
    operand2 REAL NOT NULL,
    result REAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster queries on operation type
CREATE INDEX IF NOT EXISTS idx_test_cases_operation ON test_cases(operation);
CREATE INDEX IF NOT EXISTS idx_history_operator ON calculation_history(operator);
CREATE INDEX IF NOT EXISTS idx_history_created_at ON calculation_history(created_at);
