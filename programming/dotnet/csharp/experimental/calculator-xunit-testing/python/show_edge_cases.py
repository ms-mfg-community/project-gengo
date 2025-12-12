"""
Display edge test cases from the database.
"""

from database import get_db_connection

conn = get_db_connection()
cursor = conn.cursor()

# Get edge test cases
print('EDGE TEST CASES')
print('=' * 90)

# Zero cases
print('\n[ZERO OPERANDS]')
cursor.execute("""SELECT id, first_number, operation, second_number, expected_value 
                  FROM test_cases 
                  WHERE first_number = 0.0 OR second_number = 0.0 
                  ORDER BY operation, id""")
for row in cursor.fetchall():
    print(f'  ID {row[0]:2d}: {row[1]:7.1f} {row[2]} {row[3]:7.1f} = {row[4]:7.1f}')

# Negative cases
print('\n[NEGATIVE NUMBERS]')
cursor.execute("""SELECT id, first_number, operation, second_number, expected_value 
                  FROM test_cases 
                  WHERE first_number < 0 OR second_number < 0 
                  ORDER BY operation, id""")
for row in cursor.fetchall():
    print(f'  ID {row[0]:2d}: {row[1]:7.1f} {row[2]} {row[3]:7.1f} = {row[4]:7.1f}')

# Exponentiation edge cases
print('\n[EXPONENTIATION EDGE CASES]')
cursor.execute("""SELECT id, first_number, operation, second_number, expected_value 
                  FROM test_cases 
                  WHERE operation = '^' 
                  ORDER BY id""")
for row in cursor.fetchall():
    print(f'  ID {row[0]:2d}: {row[1]:7.1f} {row[2]} {row[3]:7.1f} = {row[4]:7.1f}')

# Modulo with negatives
print('\n[MODULO WITH NEGATIVES]')
cursor.execute("""SELECT id, first_number, operation, second_number, expected_value 
                  FROM test_cases 
                  WHERE operation = '%' AND (first_number < 0 OR second_number < 0) 
                  ORDER BY id""")
for row in cursor.fetchall():
    print(f'  ID {row[0]:2d}: {row[1]:7.1f} {row[2]} {row[3]:7.1f} = {row[4]:7.1f}')

# Decimal/fractional numbers
print('\n[FRACTIONAL NUMBERS]')
cursor.execute("""SELECT id, first_number, operation, second_number, expected_value 
                  FROM test_cases 
                  WHERE first_number LIKE '%.%' OR second_number LIKE '%.%' OR expected_value LIKE '%.%'
                  ORDER BY operation, id""")
rows = cursor.fetchall()
if rows:
    for row in rows:
        print(f'  ID {row[0]:2d}: {row[1]:7.1f} {row[2]} {row[3]:7.1f} = {row[4]:7.1f}')
else:
    # Fallback query for fractional detection
    cursor.execute("""SELECT id, first_number, operation, second_number, expected_value 
                      FROM test_cases 
                      ORDER BY operation, id""")
    for row in cursor.fetchall():
        if (row[1] % 1 != 0) or (row[3] % 1 != 0) or (row[4] % 1 != 0):
            print(f'  ID {row[0]:2d}: {row[1]:7.1f} {row[2]} {row[3]:7.1f} = {row[4]:7.1f}')

conn.close()
