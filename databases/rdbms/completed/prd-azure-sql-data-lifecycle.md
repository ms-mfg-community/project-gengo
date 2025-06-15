# Product Requirements Document: Azure SQL Database Operations Demo

## Document Information
**Version:** 1.0  
**Author:** GitHub Copilot Workshop Team  
**Date:** 2023-07-20  
**Status:** Draft  

## 1. Executive Summary

This document outlines a demonstration scenario for GitHub Copilot workshops, focusing on basic database CRUD operations using Azure SQL. The demo will showcase how GitHub Copilot can assist with generating SQL queries for a table named `demos` in the Azure SQL database.

### 1.1 Models Tested

#### 1.1.1 Gemini 2.5 Pro

- **Date Tested:** 14jun2025
- **Tested By:** GitHub Copilot Workshop Team
- **Tested On:** Azure SQL Database
- **Tested With:** T-SQL queries
- **Tested Features:** CRUD operations, query generation, and safety practices
- **Tested Prompts:** Natural language prompts for SQL generation
- **Tested Results:** Successful generation of SQL queries for all CRUD operations with appropriate safety measures and context awareness.
- **Tested Limitations:** No significant limitations observed; Copilot effectively handled complex queries and provided relevant suggestions based on context.

#### 1.1.2 OpenAI GPT-4.1

- **Date Tested:** 14jun2025
- **Tested By:** GitHub Copilot Workshop Team
- **Tested On:** Azure SQL Database
- **Tested With:** T-SQL queries
- **Tested Features:** CRUD operations, query generation, and safety practices
- **Tested Prompts:** Natural language prompts for SQL generation
- **Tested Results:** Successful generation of SQL queries for all CRUD operations with appropriate safety measures and context awareness.
- **Tested Limitations:** No significant limitations observed; Copilot effectively handled complex queries and provided relevant suggestions based on context.

#### 1.1.3 Claude 3.7 Sonnet
- **Date Tested:** 14jun2025
- **Tested By:** GitHub Copilot Workshop Team
- **Tested On:** Azure SQL Database
- **Tested With:** T-SQL queries
- **Tested Features:** CRUD operations, query generation, and safety practices
- **Tested Prompts:** Natural language prompts for SQL generation
- **Tested Results:** 
 
## 2. Connection Details

**Connection Information:**
- **Server:** svr-ghc-01.database.windows.net
- **Database:** demos
- **Username:** sqladmin
- **Authentication:** SQL Authentication
- **Port:** 1433

## 3. Demo Scenario: "Workshop Content Management System"

### 3.1 Overview

As an instructor managing GitHub Copilot workshops, you maintain a database of demonstration scenarios in the `demos` table. 
During the workshop, you'll showcase how GitHub Copilot helps you manage this content through basic database operations.

### 3.2 Table Structure

The `demos` table contains information about different demonstration scenarios used in workshops:
-- Table structure reference
-- Key columns include:
-- id: Unique identifier
-- category: Main topic category (e.g., 'programming', 'databases')
-- language: Programming language used (e.g., 'csharp', 'python')
-- scenario: Description of the demonstration
-- confidence_percent: Success rate of the demo

### 3.3 Demo Sequence

#### 3.3.1 Exploring Data (READ)

**Scenario:** "Let's see what demonstrations we have available for our workshop."
-- Basic SELECT query
SELECT TOP 5 id, category, language, scenario
FROM dbo.demos;

-- Filtering data
SELECT id, category, language, scenario, confidence_percent
FROM dbo.demos
WHERE category = 'programming' AND confidence_percent > 70
ORDER BY confidence_percent DESC;

-- Searching with pattern matching
SELECT id, category, language, scenario
FROM dbo.demos
WHERE scenario LIKE '%calculator%'
OR scenario LIKE '%Azure SQL%';

#### 3.3.2 Adding New Content (CREATE)

**Scenario:** "We need to add a new demonstration for our upcoming workshop."
-- INSERT statement
INSERT INTO dbo.demos (
    id, points, category, sub_category, language, 
    role, person, ide_type, prompt_type, shot_type, 
    is_test, test_type, epoch, confidence_percent, scenario, 
    github_org, reference, data_source, notes
)
VALUES (
    (SELECT ISNULL(MAX(id), 0) + 1 FROM dbo.demos), -- Auto-increment ID
    25, -- Points value
    'databases', -- Category
    'azure-sql', -- Sub-category
    'tsql', -- Language
    'instructor', -- Role
    'workshop presenter', -- Person
    'azure_data_studio', -- IDE type
    'chat', -- Prompt type
    'one', -- Shot type
    0, -- Is test
    'na', -- Test type
    0, -- Epoch
    95, -- Confidence percent
    'Demonstrate how to use GitHub Copilot for generating SQL queries', -- Scenario
    'github-workshop', -- GitHub org
    'databases/rdbms/workspace/sql/dmo-azure-sql-data-lifecycle.sql', -- Reference
    'workshop-demos', -- Data source
    'Created during GitHub Copilot workshop demo' -- Notes
);

#### 3.3.3 Updating Content (UPDATE)

**Scenario:** "We need to update the confidence score for one of our demonstrations based on feedback."
-- UPDATE statement
UPDATE dbo.demos
SET confidence_percent = 90,
    notes = CONCAT(notes, ' | Updated during workshop on ', CONVERT(VARCHAR, GETDATE(), 120))
WHERE scenario LIKE '%GitHub Copilot%'
AND category = 'databases';

-- Verify the update
SELECT id, scenario, confidence_percent, notes
FROM dbo.demos
WHERE scenario LIKE '%GitHub Copilot%';

#### 3.3.4 Removing Content (DELETE)

**Scenario:** "Let's implement a safe removal process for outdated demonstrations."
-- Safe DELETE with verification
-- First, identify what would be deleted
SELECT id, category, scenario
FROM dbo.demos
WHERE id = [specific_id_to_delete];

-- Then perform the delete with a safety WHERE clause
-- DELETE FROM dbo.demos
-- WHERE id = [specific_id_to_delete]
-- AND category = 'databases'; -- Added safety check

## 4. Teaching Points for GitHub Copilot

### 4.1 Key Demonstration Elements

1. **Contextual Awareness:**
   - Show how Copilot understands SQL syntax
   - Demonstrate context from previous queries
   - Show how Copilot helps with table column suggestions

2. **Safety Practices:**
   - Highlight safety measures in DELETEs (using WHERE clauses)
   - Show transaction handling recommendations
   - Demonstrate verification steps before modifications

3. **Pattern Recognition:**
   - Start with simple queries and extend complexity
   - Show how patterns in one query translate to others
   - Demonstrate comment-driven query generation

4. **Error Prevention:**
   - Identify potential syntax errors
   - Suggest proper data types for column values
   - Provide guidance on JOIN conditions and filtering

## 5. Workshop Flow

1. **Introduction** (2 minutes)
   - Explain the demo table and its purpose
   - Set context for database operations

2. **READ Operations** (5 minutes)
   - Basic SELECT queries
   - Filtering and sorting
   - Search functionality

3. **CREATE Operation** (3 minutes)
   - Adding new workshop content
   - Handling ID generation

4. **UPDATE Operation** (3 minutes)
   - Modifying existing content
   - Audit trail techniques

5. **DELETE Operation** (2 minutes)
   - Safe deletion practices
   - Verification steps

6. **Q&A and Discussion** (5 minutes)
   - Review generated SQL
   - Discuss alternatives
   - Address questions

## 6. Success Criteria

- Attendees understand how GitHub Copilot assists with SQL query generation
- All CRUD operations are successfully demonstrated
- Safety practices are emphasized throughout
- Participants gain confidence in using Copilot for database operations

## 7. Sample Natural Language Prompts and Expected T-SQL Code

This section provides example prompts that can be given to GitHub Copilot during the workshop, along with the expected T-SQL code that Copilot should generate.

### 7.1 READ Operation Prompts

#### Prompt 0: (System Prompt) You are an expert SQL developer and GitHub Copilot instructor. 
#### You will be given a series of natural language prompts to generate SQL queries for the `demos` table in the Azure SQL database. 
#### The table contains information about various programming demos, including their categories, languages, and confidence scores.
#### For each prompt, generate the appropriate T-SQL code that fulfills the request and place it only in the active *.sql context file so we can immediately run the query and see the results.

#### Prompt 1: "Show me the top 10 demos in the database with their categories and languages."

#### Prompt 2: "Find all C# programming demos with confidence over 60% sorted by highest confidence"

#### 

### 7.2 CREATE Operation Prompts

#### Prompt 1: "Write code to add a new demo for a TypeScript web application workshop"

#### Prompt 2: "Write code to select and display the new Typescript web application workshop record that was just created"

#### Prompt 3: "Write code to remove the new demo for a TypeScript web application workshop"

#### Prompt 4: "Create a stored procedure that adds a new demo with minimal required parameters"

### 7.3 UPDATE Operation Prompts

#### Prompt 1: "Update the confidence score and notes for demo ID 5"

#### Prompt 2: "Update the demo ID 5 to use the following values; confidence_percent = 70, notes = 'update notes for id 5' and points = 40"

#### Prompt 3: "Write a query to increase all database demo confidence scores by 5% if they're below 80%"

### 7.4 DELETE Operation Prompts

#### Prompt 1: "Create a safe way to delete demo ID 5 with verification"

#### Prompt 2: (Ask mode prompt) "How can I remove all demos with confidence below 30% and save their IDs"

#### Prompt 3: (Ask mode prompt) "Is there a way to soft delete scenario records instead of hard deleting them?"

## 8. Tips for Effective GitHub Copilot Prompts

When crafting prompts for SQL generation during the workshop, consider these practices:

1. **Be specific about the table name**: Always mention "demos table" or "dbo.demos" in your prompt
2. **Include key column names**: Reference specific columns like "category", "language", or "confidence_percent" to help Copilot generate more accurate queries
3. **Describe the business intent**: Rather than asking for "a SELECT query", ask for "a query to find Java demos with high confidence ratings"
4. **Use descriptive comments**: Start with a comment that describes what the SQL should accomplish
5. **Build incrementally**: Start with a simple prompt, then add complexity step by step
6. **Leverage natural language**: You can use phrases like "Show me...", "Find all...", or "Update the..." rather than technical jargon

For example, instead of typing:SELECT * FROM demos WHERE confidence_percent > 80
Try a prompt like:-- Find all demos with a confidence percentage greater than 80%
GitHub Copilot will often generate the complete and optimized SQL query based on these natural language descriptions.