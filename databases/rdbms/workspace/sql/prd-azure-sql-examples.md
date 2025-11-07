# Product Requirements Document: Azure SQL CRUD Operations Examples

## Document Information

**Version:** 1.0  
**Author:** GitHub Copilot Assistant  
**Date:** November 6, 2025  
**Status:** Draft  

## 1. Executive Summary

This document defines a comprehensive set of examples and demonstrations for Azure SQL CRUD (Create, Read, Update, Delete) operations using GitHub Copilot. The demonstrations showcase how GitHub Copilot assists developers in writing T-SQL queries efficiently and safely for the `demos` table in an Azure SQL database hosted on `<redacted>.database.windows.net`.

The examples are designed to teach best practices for database operations, demonstrate GitHub Copilot's contextual awareness, and provide a hands-on learning experience for workshop participants and developers.

## 2. Problem Statement

Developers working with Azure SQL databases need:

- A reliable way to perform CRUD operations safely and efficiently
- Examples that demonstrate best practices for T-SQL query writing
- Guidance on using GitHub Copilot to accelerate database development
- A reference implementation for common database operations

Manual SQL query writing is time-consuming and error-prone. GitHub Copilot can significantly accelerate this process while promoting best practices.

## 3. Goals and Objectives

- Provide comprehensive examples of CRUD operations for Azure SQL databases
- Demonstrate GitHub Copilot's capabilities in T-SQL query generation
- Showcase safety practices and error prevention techniques
- Enable developers to quickly learn and apply database operation patterns
- Create a reusable template for Azure SQL demonstrations

## 4. Scope

### 4.1 In Scope

- CRUD operations (Create, Read, Update, Delete) for the `demos` table
- Connection string configuration and authentication
- Safety practices including verification steps and transaction handling
- GitHub Copilot prompt engineering for SQL generation
- Query optimization and performance considerations
- Error handling and validation
- Schema discovery and documentation

### 4.2 Out of Scope

- Complex stored procedures and functions
- Database schema design and normalization
- Performance tuning and indexing strategies
- Advanced security configurations beyond connection string
- Migration strategies or ETL processes
- Multi-database operations or distributed transactions

## 5. Connection Details

### 5.1 Database Connection Information

**Connection String:**

```text
Server=tcp:<redacted>.database.windows.net,1433;Initial Catalog=demos;Persist Security Info=False;User ID=<redacted>;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

**Connection Parameters:**

- **Server:** svr-ghc-01.database.windows.net
- **Port:** 1433 (default)
- **Database:** demos
- **Username:** sqladmin
- **Password:** {To be prompted from user}
- **Authentication:** SQL Authentication
- **Encryption:** True
- **Trust Server Certificate:** False
- **Connection Timeout:** 30 seconds
- **Multiple Active Result Sets:** False

### 5.2 Target Table

**Table Name:** `demos`  
**Schema:** `dbo` (default)

## 6. User Stories / Use Cases

### 6.1 As a Developer

- I want to connect to the Azure SQL database using sqlcmd so that I can execute T-SQL queries
- I want to view all records in the demos table so that I understand the data structure
- I want to insert new demo records efficiently using GitHub Copilot assistance
- I want to update existing records with validation to prevent data corruption
- I want to delete records safely with verification steps to avoid accidental data loss

### 6.2 As a Workshop Instructor

- I want to demonstrate GitHub Copilot's SQL generation capabilities to attendees
- I want to showcase best practices for database operations in a real-world scenario
- I want to provide reusable examples that attendees can reference later
- I want to emphasize safety and error prevention in database operations

### 6.3 As a Database Administrator

- I want to ensure all operations follow security best practices
- I want to verify that queries are optimized and won't impact database performance
- I want to maintain audit trails for data modifications

## 7. Functional Requirements

| Requirement ID | Description | Priority |
|---|---|---|
| FR-1 | System shall support connecting to Azure SQL using sqlcmd with the provided connection string | High |
| FR-2 | System shall provide examples for SELECT queries with filtering, sorting, and pagination | High |
| FR-3 | System shall demonstrate INSERT operations with automatic ID generation | High |
| FR-4 | System shall demonstrate UPDATE operations with WHERE clause validation | High |
| FR-5 | System shall demonstrate DELETE operations with verification steps | High |
| FR-6 | System shall include schema discovery queries to document table structure | Medium |
| FR-7 | System shall provide transaction-wrapped examples for critical operations | Medium |
| FR-8 | System shall include error handling patterns for each operation type | Medium |
| FR-9 | System shall demonstrate GitHub Copilot prompt patterns for SQL generation | High |
| FR-10 | System shall export query results to CSV for documentation purposes | Low |

## 8. Non-Functional Requirements

### 8.1 Security

- All examples must use parameterized queries where applicable
- Connection strings must not contain hardcoded passwords
- Sensitive data must not be exposed in query outputs
- All operations must respect database permissions and roles

### 8.2 Performance

- Queries should be optimized with appropriate WHERE clauses
- Bulk operations should use efficient batch processing
- Connection timeouts should be appropriately configured
- Query execution time should be monitored and logged

### 8.3 Usability

- Examples must be clearly documented with comments
- Each operation must include usage instructions
- Error messages must be informative and actionable
- Code must be formatted consistently following T-SQL best practices

### 8.4 Maintainability

- Examples should be modular and reusable
- Code should follow naming conventions
- Documentation should be inline and comprehensive
- Version control should track all changes

## 9. Demonstration Sequence

### 9.1 Pre-requisites Setup (5 minutes)

1. Verify sqlcmd installation and version
2. Prompt user for database password
3. Test database connectivity
4. Verify table existence and schema

### 9.2 Schema Discovery (5 minutes)

**Objective:** Understand the `demos` table structure

**Operations:**

- Query system tables to get column definitions
- Export schema to CSV for reference
- Document primary keys, data types, and constraints
- Add schema file to context for subsequent operations

**GitHub Copilot Prompt:**

```sql
-- Generate a query to retrieve the complete schema for the demos table including column names, data types, nullable status, and constraints
-- Save results to table_schema.csv
```


### 9.3 READ Operations (10 minutes)

**Objective:** Demonstrate various SELECT query patterns

#### Example 1: Basic SELECT

**GitHub Copilot Prompt:**

```sql
-- Show all records from the demos table
```

#### Example 2: Filtered SELECT

**GitHub Copilot Prompt:**

```sql
-- Find all demos where category is 'programming' and confidence_percent is greater than 70
```

#### Example 3: Sorted and Limited Results

**GitHub Copilot Prompt:**

```sql
-- Show top 10 demos ordered by confidence_percent descending
```

#### Example 4: Pattern Matching

**GitHub Copilot Prompt:**

```sql
-- Find all demos where scenario contains 'GitHub Copilot' (case-insensitive)
```

#### Example 5: Aggregation

**GitHub Copilot Prompt:**

```sql
-- Show the average confidence_percent grouped by category
```


### 9.4 CREATE Operations (10 minutes)

**Objective:** Demonstrate INSERT operations with various patterns

#### Example 1: Single Record Insert with Auto-Increment ID

**GitHub Copilot Prompt:**

```sql
-- Insert a new demo record for a Python data science workshop
-- Calculate the next available ID automatically
-- Set category='programming', language='python', scenario='Data Science with Pandas', confidence_percent=85
```

#### Example 2: Insert and Return Inserted Record

**GitHub Copilot Prompt:**

```sql
-- Insert a new C# demo and immediately return the inserted record with its generated ID
```

#### Example 3: Bulk Insert

**GitHub Copilot Prompt:**

```sql
-- Insert multiple demo records in a single statement for JavaScript, TypeScript, and Go workshops
```

#### Example 4: Insert with Transaction

**GitHub Copilot Prompt:**

```sql
-- Insert a new demo within a transaction with error handling and rollback capability
```


### 9.5 UPDATE Operations (10 minutes)

**Objective:** Demonstrate safe UPDATE patterns with verification

#### Example 1: Single Record Update

**GitHub Copilot Prompt:**

```sql
-- Update the confidence_percent to 90 for demo with ID 5
-- Include a verification SELECT before and after the update
```

#### Example 2: Multi-Column Update

**GitHub Copilot Prompt:**

```sql
-- Update demo ID 5 to set confidence_percent=75, notes='Updated after workshop feedback', points=45
```

#### Example 3: Conditional Bulk Update

**GitHub Copilot Prompt:**

```sql
-- Increase confidence_percent by 10 for all demos where category='databases' and confidence_percent < 80
```

#### Example 4: Update with Calculation

**GitHub Copilot Prompt:**

```sql
-- For all demos with confidence_percent below 60, increase it by 15% of its current value
```


### 9.6 DELETE Operations (10 minutes)

**Objective:** Demonstrate safe DELETE patterns with verification

#### Example 1: Safe Single Record Delete

**GitHub Copilot Prompt:**

```sql
-- Delete demo with ID 5 but first show what will be deleted for verification
```

#### Example 2: Conditional Delete with Backup

**GitHub Copilot Prompt:**

```sql
-- Before deleting demos with confidence_percent < 30, save their IDs to a temporary table for audit
```

#### Example 3: Soft Delete Pattern

**GitHub Copilot Prompt:**

```sql
-- Instead of hard deleting, show how to add an 'is_deleted' flag and update it rather than removing the record
```

#### Example 4: Delete with Transaction

**GitHub Copilot Prompt:**

```sql
-- Delete all demos where language='obsolete' within a transaction with rollback capability
```


## 10. GitHub Copilot Best Practices

### 10.1 Effective Prompt Patterns

#### Pattern 1: Descriptive Comments

```sql
-- [Action] [Target] [Conditions] [Additional Requirements]
-- Example: Find all Python demos with confidence above 80% sorted by scenario name
```

#### Pattern 2: Contextual References

```sql
-- In the demos table, show me...
-- For the demos database, create a query that...
```

#### Pattern 3: Incremental Complexity

- Start simple: "Show all demos"
- Add filters: "Show all Python demos"
- Add sorting: "Show all Python demos sorted by confidence"
- Add limits: "Show top 5 Python demos sorted by confidence descending"

#### Pattern 4: Safety-First Language

```sql
-- Safely delete... (verify first)
-- Update with verification...
-- Show what would be affected before...
```


### 10.2 Common Prompting Mistakes to Avoid

- ❌ Vague: "Get data from table"
- ✅ Specific: "Select all columns from demos table where category='programming'"
- ❌ No context: "Delete records"
- ✅ With context: "Delete records from demos table where confidence_percent < 20 after verifying count"
- ❌ No safety: "Update all records"
- ✅ Safety-first: "Show which records would be affected, then update demos with confidence < 50"


## 11. Success Criteria / KPIs

### 11.1 Technical Success Metrics

- All CRUD operations execute successfully without errors
- Queries return expected results matching test cases
- No accidental data loss or corruption occurs
- Connection handles are properly managed and closed
- Execution times are within acceptable ranges (< 5 seconds per query)

### 11.2 Learning Outcome Metrics

- Participants can independently write basic SELECT queries with Copilot assistance
- Participants understand the importance of WHERE clauses in UPDATE and DELETE operations
- Participants can craft effective GitHub Copilot prompts for SQL generation
- Participants demonstrate awareness of SQL injection prevention
- Participants can troubleshoot common SQL errors with Copilot assistance

### 11.3 Quality Metrics

- All generated SQL follows T-SQL best practices
- Code includes appropriate comments and documentation
- Error handling is implemented for critical operations
- Transactions are used where data integrity is critical
- All examples are reusable and modular

## 12. Assumptions and Dependencies

### 12.1 Assumptions

- User has access to the Azure SQL database with appropriate permissions
- sqlcmd utility is installed and configured on the user's machine
- User has basic familiarity with SQL syntax and database concepts
- GitHub Copilot extension is installed and activated
- Network connectivity to Azure is stable and reliable

### 12.2 Dependencies

- **sqlcmd:** Modern Go-based version or legacy sqlcmd.exe
- **Azure SQL Database:** Active and accessible at svr-ghc-01.database.windows.net
- **GitHub Copilot:** Active subscription and VS Code extension
- **PowerShell:** For scripting connection and automation tasks
- **CSV Export Capability:** For saving schema and query results

## 13. Milestones & Timeline

| Milestone | Description | Duration | Status |
|---|---|---|---|
| M1 | PRD Creation and Review | 1 day | In Progress |
| M2 | Connection Setup and Testing | 0.5 days | Pending |
| M3 | Schema Discovery Examples | 0.5 days | Pending |
| M4 | READ Operation Examples | 1 day | Pending |
| M5 | CREATE Operation Examples | 1 day | Pending |
| M6 | UPDATE Operation Examples | 1 day | Pending |
| M7 | DELETE Operation Examples | 1 day | Pending |
| M8 | Documentation and Comments | 1 day | Pending |
| M9 | Testing and Validation | 1 day | Pending |
| M10 | Workshop Delivery Preparation | 0.5 days | Pending |

**Total Estimated Duration:** 8.5 days

## 14. Example Usage Instructions

### 14.1 Initial Setup

#### Step 1: Set Password Variable (PowerShell)

```powershell
$password = Read-Host "Enter database password" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
```

#### Step 2: Test Connection

```powershell
sqlcmd -S tcp:svr-ghc-01.database.windows.net,1433 -d demos -U sqladmin -P $plainPassword -Q "SELECT @@VERSION"
```

#### Step 3: Run Examples from SQL File

```powershell
# Execute the examples SQL file
sqlcmd -S tcp:svr-ghc-01.database.windows.net,1433 -d demos -U sqladmin -P $plainPassword -i "dmo-azure-sql-data-lifecycle.sql" -o "results.txt"
```


### 14.2 Interactive sqlcmd Session

```powershell
# Start interactive session
sqlcmd -S tcp:svr-ghc-01.database.windows.net,1433 -d demos -U sqladmin -P $plainPassword

# Inside sqlcmd, run queries interactively
# Type GO after each query to execute
# Type EXIT to quit
```

## 15. Security Considerations

### 15.1 Password Management

- **Never hardcode passwords** in scripts or connection strings
- Use secure credential storage (Azure Key Vault, environment variables)
- Prompt for passwords at runtime using secure input methods
- Clear password variables after use

### 15.2 Connection Security

- Always use encrypted connections (Encrypt=True)
- Verify server certificates when possible (TrustServerCertificate=False)
- Use appropriate connection timeouts
- Implement retry logic for transient failures

### 15.3 Query Security

- Always use parameterized queries when accepting user input
- Validate and sanitize all input data
- Follow principle of least privilege for database user permissions
- Implement audit logging for sensitive operations

### 15.4 Data Protection

- Mask sensitive data in query outputs and logs
- Implement row-level security where appropriate
- Use database encryption for data at rest
- Regularly review and rotate credentials

## 16. Troubleshooting Guide

### 16.1 Connection Issues

**Problem:** "Cannot connect to server"

**Solutions:**

- Verify firewall rules allow your IP address
- Check connection string format
- Verify server name and port
- Test network connectivity with `Test-NetConnection`

**Problem:** "Login failed for user 'sqladmin'"

**Solutions:**

- Verify password is correct
- Check if account is locked or disabled
- Verify SQL authentication is enabled on the server
- Confirm user has appropriate permissions

### 16.2 Query Execution Issues

**Problem:** "Invalid object name 'demos'"

**Solutions:**

- Verify you're connected to the correct database
- Check table name spelling and schema (use `dbo.demos`)
- Confirm table exists with `SELECT * FROM INFORMATION_SCHEMA.TABLES`

**Problem:** "Transaction deadlock"

**Solutions:**

- Implement retry logic with exponential backoff
- Optimize query order to reduce lock contention
- Keep transactions short and focused
- Review isolation levels


## 17. Key Takeaways

1. **GitHub Copilot accelerates SQL development** by generating accurate queries from natural language prompts
2. **Safety-first approach** is critical for UPDATE and DELETE operations
3. **Descriptive prompts** yield better Copilot suggestions
4. **Verification steps** should always precede destructive operations
5. **Transaction handling** ensures data integrity for critical operations
6. **Schema documentation** improves context for subsequent operations
7. **Incremental complexity** helps build understanding and confidence
8. **Error handling** should be built into all production code

## 18. Questions for Review

1. Are all CRUD operation examples comprehensive and clear?
2. Do the GitHub Copilot prompts effectively demonstrate best practices?
3. Is the security guidance sufficient for production scenarios?
4. Should additional operation types be included (e.g., MERGE, stored procedures)?
5. Are the success criteria measurable and achievable?
6. Is the documentation clear enough for self-service learning?

## 19. Call to Action

### 19.1 For Developers

- Review the examples and adapt them to your specific scenarios
- Practice writing effective GitHub Copilot prompts
- Implement safety practices in all database operations
- Share feedback and suggestions for improvement

### 19.2 For Instructors

- Use this PRD as a workshop guide
- Customize examples based on audience skill level
- Collect feedback from participants
- Contribute additional examples and patterns

### 19.3 For Contributors

- Submit pull requests with additional examples
- Report issues or inaccuracies
- Suggest improvements to documentation
- Share success stories and use cases

## 20. Appendix

### 20.1 Reference Links

- [Microsoft T-SQL Reference](https://docs.microsoft.com/en-us/sql/t-sql/)
- [Azure SQL Database Documentation](https://docs.microsoft.com/en-us/azure/sql-database/)
- [sqlcmd Utility Documentation](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

### 20.2 Related Documents

- [`prd-azure-sql-data-lifecycle.md`](../prd-azure-sql-data-lifecycle.md) - Original PRD reference
- [`dmo-azure-sql-data-lifecycle.sql`](dmo-azure-sql-data-lifecycle.sql) - SQL implementation file
- [`.github/copilot-instructions.md`](../../../../.github/copilot-instructions.md) - Repository coding standards

### 20.3 Glossary

- **CRUD:** Create, Read, Update, Delete - basic database operations
- **T-SQL:** Transact-SQL - Microsoft's SQL dialect for SQL Server and Azure SQL
- **sqlcmd:** Command-line utility for executing SQL queries
- **GitHub Copilot:** AI-powered code completion tool
- **PRD:** Product Requirements Document
- **DML:** Data Manipulation Language (SELECT, INSERT, UPDATE, DELETE)
- **DDL:** Data Definition Language (CREATE, ALTER, DROP)

---


