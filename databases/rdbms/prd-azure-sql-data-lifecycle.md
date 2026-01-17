# Product Requirements Document: Azure SQL Database Operations Demo

\n\nDocument Information

**Version:** 1.0

**Author:** GitHub Copilot Workshop Team

**Date:** 2023-07-20

**Status:** Draft

\n\n1. Executive Summary

This document outlines a demonstration scenario for GitHub Copilot workshops, focusing on basic database CRUD operations using Azure SQL. The demo will showcase how GitHub Copilot can assist with generating SQL queries for a table named `demos` in the Azure SQL database.

\n\n1.1 Models Tested

\n\n1.1.1 Gemini 2.5 Pro

\n\n**Date Tested:** 14jun2025
\n\n**Tested By:** GitHub Copilot Workshop Team
\n\n**Tested On:** Azure SQL Database
\n\n**Tested With:** T-SQL queries
\n\n**Tested Features:** CRUD operations, query generation, and safety practices
\n\n**Tested Prompts:** Natural language prompts for SQL generation
\n\n**Tested Results:** Successful generation of SQL queries for all CRUD operations with appropriate safety measures and context awareness.
\n\n**Tested Limitations:** No significant limitations observed; Copilot effectively handled complex queries and provided relevant suggestions based on context.

\n\n1.1.2 OpenAI GPT-4.1

\n\n**Date Tested:** 14jun2025
\n\n**Tested By:** GitHub Copilot Workshop Team
\n\n**Tested On:** Azure SQL Database
\n\n**Tested With:** T-SQL queries
\n\n**Tested Features:** CRUD operations, query generation, and safety practices
\n\n**Tested Prompts:** Natural language prompts for SQL generation
\n\n**Tested Results:** Successful generation of SQL queries for all CRUD operations with appropriate safety measures and context awareness. **NOTE**: GPT-4.1 was the fasted model tested.
\n\n**Tested Limitations:** No significant limitations observed; Copilot effectively handled complex queries and provided relevant suggestions based on context.

\n\n1.1.3 Claude 3.7 Sonnet

\n\n**Date Tested:** 14jun2025
\n\n**Tested By:** GitHub Copilot Workshop Team
\n\n**Tested On:** Azure SQL Database
\n\n**Tested With:** T-SQL queries
\n\n**Tested Features:** CRUD operations, query generation, and safety practices
\n\n**Tested Prompts:** Natural language prompts for SQL generation
\n\n**Tested Results:** Successful generation of SQL queries for all CRUD operations with appropriate safety measures and context awareness. **NOTE**: Claude 3.7 Sonnet was the most explainable model tested with detailed explanations of SQL syntax and logic.
\n\n**Tested Limitations:** No significant limitations observed; Copilot effectively handled complex queries and provided relevant suggestions based on context.

\n\n2. Connection Details
# Connection Information:
\n\n**Server:** svr-ghc-01.database.windows.net
\n\n**Database:** demos
\n\n**Username:** sqladmin
\n\n**Authentication:** SQL Authentication
\n\n**Port:** 1433

\n\n3. Demo Scenario: "Workshop Content Management System"

\n\n3.1 Overview

As an instructor managing GitHub Copilot workshops, you maintain a database of demonstration scenarios in the `demos` table.

During the workshop, you'll showcase how GitHub Copilot helps you manage this content through basic database operations.

\n\n3.2 Table Structure

The `demos` table contains information about different demonstration scenarios used in workshops:

-- Table structure reference

-- Key columns include:

-- id: Unique identifier

-- category: Main topic category (e.g., 'programming', 'databases')

-- language: Programming language used (e.g., 'csharp', 'python')

-- scenario: Description of the demonstration

-- confidence_percent: Success rate of the demo

\n\n3.3 Demo Sequence

\n\n3.3.1 Exploring Data (READ)

**Scenario:** "Let's see what demonstrations we have available for our workshop."

-- Basic SELECT query

-- Filtering data

-- Searching with pattern matching

\n\n3.3.2 Adding New Content (CREATE)

**Scenario:** "We need to add a new demonstration for our upcoming workshop."

-- INSERT statement

\n\n3.3.3 Updating Content (UPDATE)

**Scenario:** "We need to update the confidence score for one of our demonstrations based on feedback."

-- UPDATE statement

\n\n3.3.4 Removing Content (DELETE)

**Scenario:** "Let's implement a safe removal process for outdated demonstrations."

-- Safe DELETE with verification

-- First, identify what would be deleted

\n\n4. Teaching Points for GitHub Copilot

\n\n4.1 Key Demonstration Elements

\n\n**Contextual Awareness:**
\n\nShow how Copilot understands SQL syntax
\n\nDemonstrate context from previous queries
\n\nShow how Copilot helps with table column suggestions

\n\n**Safety Practices:**
\n\nHighlight safety measures in DELETEs (using WHERE clauses)
\n\nShow transaction handling recommendations
\n\nDemonstrate verification steps before modifications

\n\n**Pattern Recognition:**
\n\nStart with simple queries and extend complexity
\n\nShow how patterns in one query translate to others
\n\nDemonstrate comment-driven query generation

\n\n**Error Prevention:**
\n\nIdentify potential syntax errors
\n\nSuggest proper data types for column values
\n\nProvide guidance on JOIN conditions and filtering

\n\n5. Workshop Flow

\n\n**Introduction** (2 minutes)
\n\nExplain the demo table and its purpose
\n\nSet context for database operations

\n\n**READ Operations** (5 minutes)
\n\nBasic SELECT queries
\n\nFiltering and sorting
\n\nSearch functionality

\n\n**CREATE Operation** (3 minutes)
\n\nAdding new workshop content
\n\nHandling ID generation

\n\n**UPDATE Operation** (3 minutes)
\n\nModifying existing content
\n\nAudit trail techniques

\n\n**DELETE Operation** (2 minutes)
\n\nSafe deletion practices
\n\nVerification steps

\n\n**Q&A and Discussion** (5 minutes)
\n\nReview generated SQL
\n\nDiscuss alternatives
\n\nAddress questions

\n\n6. Success Criteria

\n\nAttendees understand how GitHub Copilot assists with SQL query generation
\n\nAll CRUD operations are successfully demonstrated
\n\nSafety practices are emphasized throughout
\n\nParticipants gain confidence in using Copilot for database operations

\n\n7. Sample Natural Language Prompts and Expected T-SQL Code

This section provides example prompts that can be given to GitHub Copilot during the workshop, along with the expected T-SQL code that Copilot should generate.

\n\n7.1 READ Operation Prompts

\n\nPrompt 0: (System Prompt) You are an expert SQL developer and GitHub Copilot instructor.

\n\nYou will be given a series of natural language prompts to generate SQL queries for the `demos` table in the Azure SQL database

\n\nThe table contains information about various programming demos, including their categories, languages, and confidence scores.

\n\nFor each prompt, generate the appropriate T-SQL code that fulfills the request and place it only in the active \*.sql context file so we can immediately run the query and see the results. To discover the table structure, you perform the following operations

\n\nGenerate the T-SQL code to show the demos database schema, as well as how to execute it and save the results as a reference .csv file in the same directory as the active .sql file

\n\nUse the name `table_schema.csv`
\n\nThen add this results file to the context window that will be used as a reference to inform subsequent prompts for any relevant database tables.
\n\nUse semantic search to actually construct the best relevant query such that it can be immediately executed without any further manual modification"

\n\nPrompt 1: "Show me the top 10 demos in the database with their categories and languages."

\n\nPrompt 2: "Find all csharp programming demos with confidence over 60% sorted by highest confidence"

####

\n\n7.2 CREATE Operation Prompts

\n\nPrompt 1: "Write code to add a new demo for a TypeScript web application workshop."

"Calculate and automatically increment the ID for the new demo, set the category to 'web development', language to 'typescript', and confidence_percent to 80."

\n\nPrompt 2: "Write code to select and display the new Typescript web application workshop record that was just created"

\n\nPrompt 3: "Write code to remove the new demo for a TypeScript web application workshop"

\n\nPrompt 4: "Create a stored procedure that adds a new demo with minimal required parameters"

\n\n7.3 UPDATE Operation Prompts

\n\nPrompt 1: "Update the confidence score and notes for demo ID 5"

\n\nPrompt 2: "Update the demo ID 5 to use the following values; confidence_percent = 70, notes = 'update notes for id 5' and points = 40"

\n\nPrompt 3: "Reset the confidence score by removing the notes and reducing the confidence_percent by 5 for demo ID 5"

\n\nPrompt 4: "Write a query to increase all database demo confidence scores by 5% if they're below 80%"

\n\nPrompt 5: "Write a query to decrease (reset) all database demo confidence scores by 5% if they're below 80%"

\n\n7.4 DELETE Operation Prompts

\n\nPrompt 1: (Ask mode prompt) "Create a safe way to delete demo ID 5 with verification"

\n\nPrompt 2: (Ask mode prompt) "How can I remove all demos with confidence below 30% and save their IDs"

\n\nPrompt 3: (Ask mode prompt) "Is there a way to soft delete scenario records instead of hard deleting them?"

\n\n8. Tips for Effective GitHub Copilot Prompts

When crafting prompts for SQL generation during the workshop, consider these practices:

\n\n**Be specific about the table name**: Always mention "demos table" or "dbo.demos" in your prompt
\n\n**Include key column names**: Reference specific columns like "category", "language", or "confidence_percent" to help Copilot generate more accurate queries
\n\n**Describe the business intent**: Rather than asking for "a SELECT query", ask for "a query to find Java demos with high confidence ratings"
\n\n**Use descriptive comments**: Start with a comment that describes what the SQL should accomplish
\n\n**Build incrementally**: Start with a simple prompt, then add complexity step by step
\n\n**Leverage natural language**: You can use phrases like "Show me...", "Find all...", or "Update the..." rather than technical jargon

For example, instead of typing:SELECT \* FROM demos WHERE confidence_percent > 80

Try a prompt like:-- Find all demos with a confidence percentage greater than 80%

GitHub Copilot will often generate the complete and optimized SQL query based on these natural language descriptions.

\n
