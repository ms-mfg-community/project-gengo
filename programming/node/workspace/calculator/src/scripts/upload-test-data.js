/**
 * Script to upload calculator test data from CSV to Azure SQL Database
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import csv from 'csv-parser';
import sql from 'mssql';
import readlineSync from 'readline-sync';
import dotenv from 'dotenv';

// Get __dirname equivalent in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load environment variables from .env file
dotenv.config({ path: path.resolve(__dirname, '../../.env') });

// Path to the CSV file
const csvFilePath = path.resolve(__dirname, '../test/calculator-test.csv');

// Define table schema
const createTableQuery = `
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = '${process.env.DB_TABLE}')
BEGIN
    CREATE TABLE [dbo].[${process.env.DB_TABLE}] (
        [id] [int] IDENTITY(1,1) PRIMARY KEY,
        [operation] [nvarchar](50) NOT NULL,
        [operandA] [float] NOT NULL,
        [operandB] [float] NOT NULL,
        [result] [nvarchar](50) NOT NULL,
        [status] [nvarchar](10) NOT NULL
    )
END
`;

// Main function for database operations
async function uploadDataToAzure() {
  console.log('Connecting to Azure SQL Database...');
  
  // Prompt for secure password input with asterisk masking
  const password = readlineSync.question('Please enter your database password: ', {
    hideEchoBack: true, // The typed characters will be hidden
    mask: '*'           // Mask with asterisks instead of hiding completely
  });
  
  try {
    // Configure SQL connection
    const config = {
      user: process.env.DB_USER,
      password: password,
      server: process.env.DB_SERVER,
      database: process.env.DB_DATABASE,
      options: {
        encrypt: true,
        trustServerCertificate: false
      }
    };

    console.log(`Connecting to database: ${process.env.DB_DATABASE} on server: ${process.env.DB_SERVER}`);
    
    // Connect to the database
    await sql.connect(config);
    console.log('Connected successfully!');
    
    // Create table if it doesn't exist
    console.log(`Checking if table ${process.env.DB_TABLE} exists...`);
    await sql.query(createTableQuery);
    console.log(`Table ${process.env.DB_TABLE} is ready.`);
    
    // Clear existing data (optional)
    console.log('Clearing existing data...');
    await sql.query(`DELETE FROM [dbo].[${process.env.DB_TABLE}]`);
    
    // Read CSV file and insert data
    console.log('Reading data from CSV file...');
    const records = [];
    
    await new Promise((resolve, reject) => {
      fs.createReadStream(csvFilePath)
        .pipe(csv())
        .on('data', (row) => {
          records.push(row);
        })
        .on('end', () => {
          console.log(`Parsed ${records.length} records from CSV.`);
          resolve();
        })
        .on('error', (error) => {
          reject(error);
        });
    });
    
    // Insert records in batches
    console.log('Inserting records into database...');
    const table = new sql.Table(process.env.DB_TABLE);
    table.create = false;
    
    // Define table structure
    table.columns.add('operation', sql.NVarChar(50), { nullable: false });
    table.columns.add('operandA', sql.Float, { nullable: false });
    table.columns.add('operandB', sql.Float, { nullable: false });
    table.columns.add('result', sql.NVarChar(50), { nullable: false });
    table.columns.add('status', sql.NVarChar(10), { nullable: false });
    
    // Add records to table
    records.forEach(record => {
      table.rows.add(
        record.operation,
        parseFloat(record.operandA),
        parseFloat(record.operandB),
        record.result,
        record.status
      );
    });
    
    // Bulk insert records
    const request = new sql.Request();
    await request.bulk(table);
    
    console.log(`Successfully uploaded ${records.length} records to ${process.env.DB_TABLE}!`);
    
  } catch (err) {
    console.error('Database operation failed:', err);
  } finally {
    // Close SQL connection
    await sql.close();
    console.log('Database connection closed.');
  }
}

// Execute the main function
uploadDataToAzure();