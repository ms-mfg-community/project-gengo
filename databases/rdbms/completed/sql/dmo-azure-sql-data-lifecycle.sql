-- Get the top 10 demos with key information
SELECT TOP 10
    id,
    category,
    language,
    scenario,
    confidence_percent
FROM dbo.demos
ORDER BY id;

-- Query for C# demos with high confidence
SELECT
    id,
    category,
    sub_category,
    scenario,
    confidence_percent
FROM dbo.demos
WHERE language = 'csharp'
  AND category = 'programming'
  AND confidence_percent > 60
ORDER BY confidence_percent DESC;

-- Aggregate statistics by category and language
SELECT
    category,
    language,
    COUNT(*) AS demo_count,
    AVG(confidence_percent) AS avg_confidence,
    MAX(confidence_percent) AS highest_confidence
FROM dbo.demos
GROUP BY category, language
ORDER BY demo_count DESC, avg_confidence DESC;

-- Insert a new TypeScript demo record
INSERT INTO dbo.demos (
    id, points, category, sub_category, language, 
    role, person, ide_type, prompt_type, shot_type, 
    is_test, test_type, epoch, confidence_percent, scenario, 
    github_org, reference, data_source, notes
)
VALUES (
    (SELECT ISNULL(MAX(id), 0) + 1 FROM dbo.demos), -- Auto-increment ID
    30, -- Points
    'programming', -- Category
    'web-development', -- Sub-category
    'typescript', -- Language
    'app-dev', -- Role
    'workshop presenter', -- Person
    'vs_code', -- IDE type
    'chat', -- Prompt type
    'multiple', -- Shot type
    0, -- Is test
    'na', -- Test type
    0, -- Epoch
    85, -- Confidence percent
    'Building a modern web application with TypeScript and React', -- Scenario
    'github-workshop', -- GitHub org
    'programming/typescript/workspace/web-app-demo.md', -- Reference
    'workshop-demos', -- Data source
    'Created for advanced TypeScript workshop' -- Notes
);

-- Select and display the new TypeScript web application workshop record
SELECT *
FROM dbo.demos
WHERE language = 'typescript' 
  AND category = 'programming' 
  AND scenario = 'Building a modern web application with TypeScript and React'
ORDER BY id DESC;

-- Delete the TypeScript demo record
DELETE FROM dbo.demos
WHERE id = (SELECT TOP 1 id FROM dbo.demos WHERE language = 'typescript' AND scenario = 'Building a modern web application with TypeScript and React' ORDER BY id DESC);
GO

-- Create stored procedure for simplified demo insertion
CREATE OR ALTER PROCEDURE dbo.sp_AddNewDemo
    @category NVARCHAR(255),
    @language NVARCHAR(255),
    @scenario NVARCHAR(MAX),
    @confidence_percent INT = 75,
    @person NVARCHAR(255) = 'workshop presenter',
    @ide_type NVARCHAR(255) = 'vs_code'
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @new_id INT;
    SELECT @new_id = ISNULL(MAX(id), 0) + 1 FROM dbo.demos;
    
    INSERT INTO dbo.demos (
        id, points, category, language, role, 
        person, ide_type, prompt_type, shot_type, 
        is_test, confidence_percent, scenario, notes
    )
    VALUES (
        @new_id, -- Auto-increment ID
        20, -- Default points
        @category,
        @language,
        'instructor', -- Default role
        @person,
        @ide_type,
        'chat', -- Default prompt type
        'one', -- Default shot type
        0, -- Not a test by default
        @confidence_percent,
        @scenario,
        'Added via stored procedure on ' + CONVERT(VARCHAR, GETDATE(), 120)
    );
    
    -- Return the ID of the newly created demo
    SELECT @new_id AS NewDemoId;
END;
GO

-- Delete the records from the results of the statement below
DELETE FROM dbo.demos
WHERE scenario LIKE '%stored procedure%';

-- Update specific demo with ID = 5
BEGIN TRANSACTION;

UPDATE dbo.demos
SET confidence_percent = 92,
    notes = CASE
               WHEN notes IS NULL THEN 'Updated after successful workshop run'
               ELSE notes + ' | Updated after successful workshop run'
            END,
    points = points + 5
WHERE id = 5;

-- Verify the update
SELECT id, scenario, confidence_percent, notes, points
FROM dbo.demos
WHERE id = 5;

COMMIT TRANSACTION;
GO

-- Reset demo ID 5 back to its original values
BEGIN TRANSACTION;

UPDATE dbo.demos
SET confidence_percent = 70, -- Original confidence_percent
    notes = 'update notes for id 5', -- Original notes
    points = 20 -- Original points
WHERE id = 5;

-- Verify the reset
SELECT id, scenario, confidence_percent, notes, points
FROM dbo.demos
WHERE id = 5;

COMMIT TRANSACTION;
GO

-- Conditional update for low-confidence database demos
BEGIN TRANSACTION;

UPDATE dbo.demos
SET confidence_percent = confidence_percent + 5,
    notes = CONCAT(ISNULL(notes, ''), ' | Confidence adjusted on ', CONVERT(VARCHAR, GETDATE(), 120))
WHERE category = 'databases'
  AND confidence_percent < 80;

-- Show affected records
SELECT id, category, language, scenario, confidence_percent
FROM dbo.demos
WHERE category = 'databases'
  AND confidence_percent < 85; -- Adjusted to show updated records correctly

COMMIT TRANSACTION;
GO

-- Safe deletion process with verification for ID = 5
BEGIN TRANSACTION;

-- First, verify what will be deleted
DECLARE @demo_to_delete_id INT = 5;
DECLARE @scenario_to_delete NVARCHAR(MAX);
DECLARE @category_to_delete NVARCHAR(255);

-- Get info about the record to be deleted
SELECT @scenario_to_delete = scenario, @category_to_delete = category
FROM dbo.demos
WHERE id = @demo_to_delete_id;

-- Print verification info
PRINT 'About to delete demo: ' + CAST(@demo_to_delete_id AS VARCHAR);
PRINT 'Category: ' + @category_to_delete;
PRINT 'Scenario: ' + @scenario_to_delete;

---- Perform the deletion
DELETE FROM dbo.demos
WHERE id = @demo_to_delete_id
AND category = @category_to_delete; -- Extra safety check

-- Verify deletion
IF EXISTS (SELECT 1 FROM dbo.demos WHERE id = @demo_to_delete_id)
BEGIN
    PRINT 'Deletion failed - record still exists';
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    PRINT 'Demo successfully deleted';
    COMMIT TRANSACTION;
END
GO





