#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
This script imports data from a CSV file into an Azure SQL Database table.
"""

import csv
import os
import getpass
import pyodbc
import sys

# Configuration
SERVER = 'svr-asi-01.database.windows.net'
DATABASE = 'ghc'
CSV_PATH = r'C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\databases\rdbms\completed\azure-sql\ghc_demos.csv'
TABLE_NAME = 'demos'

def main():
    """Main function to import CSV data to Azure SQL Database."""
    try:
        # Get credentials
        print("Azure SQL Database Import Script")
        print("--------------------------------")
        username = input("Enter SQL Server username: ")
        password = getpass.getpass("Enter SQL Server password: ")
        
        # Test file access
        if not os.path.exists(CSV_PATH):
            print(f"Error: CSV file not found at {CSV_PATH}")
            sys.exit(1)
            
        # Connect to the database
        print("\nConnecting to Azure SQL Database...")
        conn_str = (
            f"Driver={{ODBC Driver 18 for SQL Server}};"
            f"Server={SERVER};"
            f"Database={DATABASE};"
            f"UID={username};"
            f"PWD={password};"
            f"Encrypt=yes;TrustServerCertificate=no;"
        )
        
        with pyodbc.connect(conn_str) as conn:
            print("Connection successful!")
            cursor = conn.cursor()

            # Check if table exists and create it if not
            print(f"Checking if table {TABLE_NAME} exists...")
            create_table_sql = f"""
            IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[{TABLE_NAME}]') AND type in (N'U'))
            BEGIN
                CREATE TABLE [dbo].[{TABLE_NAME}](
                    [id] [int] NULL,
                    [points] [int] NULL,
                    [category] [nvarchar](255) NULL,
                    [sub_category] [nvarchar](255) NULL,
                    [language] [nvarchar](255) NULL,
                    [role] [nvarchar](255) NULL,
                    [person] [nvarchar](255) NULL,
                    [ide_type] [nvarchar](255) NULL,
                    [prompt_type] [nvarchar](255) NULL,
                    [shot_type] [nvarchar](255) NULL,
                    [is_test] [bit] NULL,
                    [test_type] [nvarchar](255) NULL,
                    [epoch] [int] NULL,
                    [confidence_percent] [int] NULL,
                    [scenario] [nvarchar](max) NULL,
                    [github_org] [nvarchar](255) NULL,
                    [reference] [nvarchar](max) NULL,
                    [data_source] [nvarchar](255) NULL,
                    [notes] [nvarchar](max) NULL
                )
            END
            """
            cursor.execute(create_table_sql)
            conn.commit()
            
            # Delete existing data
            print("Clearing any existing data...")
            cursor.execute(f"DELETE FROM [dbo].[{TABLE_NAME}]")
            conn.commit()
            
            # Read and import the data
            print("Reading CSV file...")
            with open(CSV_PATH, 'r', newline='', encoding='utf-8') as csvfile:
                reader = csv.reader(csvfile)
                header = next(reader)  # Skip the header row

                print("Beginning data import...")
                row_count = 0
                batch_size = 100
                batch = []
                
                insert_sql = f"""
                INSERT INTO [dbo].[{TABLE_NAME}] 
                (id, points, category, sub_category, language, role, person, ide_type, 
                prompt_type, shot_type, is_test, test_type, epoch, confidence_percent, 
                scenario, github_org, reference, data_source, notes) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """
                
                for row in reader:
                    # Convert empty strings to None and "TRUE"/"FALSE" to bit values
                    processed_row = []
                    for i, val in enumerate(row):
                        if val == '':
                            processed_row.append(None)
                        elif i == 10:  # is_test column
                            processed_row.append(1 if val.upper() == 'TRUE' else 0)
                        else:
                            processed_row.append(val)
                    
                    # Handle case where row might have fewer columns than expected
                    while len(processed_row) < 19:
                        processed_row.append(None)
                    
                    batch.append(processed_row)
                    row_count += 1
                    
                    # Execute in batches
                    if len(batch) >= batch_size:
                        cursor.executemany(insert_sql, batch)
                        conn.commit()
                        print(f"Imported {row_count} rows...")
                        batch = []
                
                # Insert any remaining rows
                if batch:
                    cursor.executemany(insert_sql, batch)
                    conn.commit()
                
                print(f"Import completed successfully! Imported {row_count} rows.")
                
                # Verify the data
                cursor.execute(f"SELECT COUNT(*) FROM [dbo].[{TABLE_NAME}]")
                count = cursor.fetchone()[0]
                print(f"Total records in table: {count}")

    except pyodbc.Error as e:
        print(f"Database error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()