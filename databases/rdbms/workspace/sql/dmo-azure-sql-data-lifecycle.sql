-- Query to show top 10 demos in the database sorted by points and confidence_percent
-- This returns the most valuable demos based on a combination of points and confidence

SELECT TOP 10
    id,
    category,
    language,
    points,
    confidence_percent
FROM
    demos
WHERE
    points IS NOT NULL
    AND confidence_percent IS NOT NULL
ORDER BY
    points DESC,
    confidence_percent DESC;

-- Query to find all C# programming demos with confidence over 60% sorted by highest confidence
SELECT
    id,
    category,
    sub_category,
    confidence_percent,
    points,
    role,
    scenario
FROM
    demos
WHERE
    language = 'csharp'
    AND confidence_percent > 60
ORDER BY
    confidence_percent DESC;

-- Query to insert a new demo for a TypeScript web application workshop
-- First, determine the next available ID value
DECLARE @NextID INT;
SELECT @NextID = ISNULL(MAX(id), 0) + 1 FROM demos;

INSERT INTO demos (
    id,  -- Adding id column which is required (no default value)
    points,
    category,
    sub_category,
    language,
    role,
    person,
    ide_type,
    prompt_type,
    shot_type,
    is_test,
    epoch,
    confidence_percent,
    scenario,
    github_org,
    data_source,
    notes
)
VALUES (
    @NextID, -- Dynamically determined next ID value
    85, -- points: high value for a comprehensive workshop
    'Web Development', -- category
    'Frontend Framework', -- sub_category
    'TypeScript', -- language
    'Developer', -- role
    'Instructor', -- person
    'VSCode', -- ide_type
    'Tutorial', -- prompt_type
    'Multi-step', -- shot_type
    0, -- is_test: not a test demo
    1, -- epoch
    75, -- confidence_percent: good confidence level
    'Building a responsive TypeScript web application with React and Material UI. The workshop covers component architecture, state management with Redux, and API integration.', -- scenario
    'microsoft', -- github_org
    'Internal Training', -- data_source
    'This workshop is designed for intermediate developers with basic TypeScript knowledge. It includes hands-on exercises and a final project.'  -- notes
);

-- Query to verify the new demo was added successfully
SELECT
    id,
    category,
    sub_category,
    language,
    confidence_percent,
    scenario
FROM
    demos
WHERE
    category = 'Web Development'
    AND language = 'TypeScript'
ORDER BY
    id DESC;

-- Query to remove the TypeScript web application workshop demo
-- This DELETE statement targets the specific demo record based on unique criteria
DELETE FROM demos
WHERE category = 'Web Development'
  AND sub_category = 'Frontend Framework'
  AND language = 'TypeScript'
  AND scenario LIKE 'Building a responsive TypeScript web application with%'
  AND role = 'Developer'
  AND person = 'Instructor'
  AND confidence_percent = 75;

-- Verify the demo was removed successfully
SELECT COUNT(*) AS RemainingTypescriptWorkshops
FROM demos
WHERE category = 'Web Development'
  AND sub_category = 'Frontend Framework'
  AND language = 'TypeScript'
  AND scenario LIKE 'Building a responsive TypeScript web application with%';

-- Create a stored procedure that adds a new demo with minimal required parameters
GO
CREATE OR ALTER PROCEDURE AddDemo
    @Category NVARCHAR(255),
    @Language NVARCHAR(255),
    @Scenario NVARCHAR(MAX),
    @Points INT = 50,                     -- Default value
    @ConfidencePercent INT = 70,          -- Default value
    @SubCategory NVARCHAR(255) = NULL,
    @Role NVARCHAR(255) = 'Developer',    -- Default value
    @Person NVARCHAR(255) = NULL,
    @IdeType NVARCHAR(255) = NULL,
    @IsTest BIT = 0                       -- Default value: not a test
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables for the procedure
    DECLARE @NextID INT;
    DECLARE @CurrentTime DATETIME2 = GETDATE();

    -- Generate the next available ID
    SELECT @NextID = ISNULL(MAX(id), 0) + 1 FROM demos;

    -- Insert the new demo with minimal required parameters and reasonable defaults for others
    INSERT INTO demos (
        id,
        category,
        language,
        scenario,
        points,
        confidence_percent,
        sub_category,
        role,
        person,
        ide_type,
        prompt_type,
        shot_type,
        is_test,
        epoch,
        embedding_updated_at
    )
    VALUES (
        @NextID,
        @Category,
        @Language,
        @Scenario,
        @Points,
        @ConfidencePercent,
        @SubCategory,
        @Role,
        @Person,
        @IdeType,
        'Standard',                 -- Default prompt_type
        'Single',                   -- Default shot_type
        @IsTest,
        1,                          -- Default epoch
        @CurrentTime                -- Current timestamp for embedding_updated_at
    );

    -- Return the ID of the newly inserted demo
    SELECT @NextID AS NewDemoID;
END;
GO

-- Example usage of the stored procedure
EXEC AddDemo
    @Category = 'Database',
    @Language = 'SQL',
    @Scenario = 'Basic CRUD operations with Azure SQL Database',
    @Points = 65,
    @ConfidencePercent = 80,
    @SubCategory = 'Azure SQL',
    @Role = 'Database Developer',
    @IdeType = 'Azure Data Studio';

-- Another example with minimal parameters (using defaults for others)
EXEC AddDemo
    @Category = 'Web Development',
    @Language = 'JavaScript',
    @Scenario = 'Building a simple interactive web form with validation';

select * from dbo.demos where id = 116;

delete from dbo.demos where id = 116;

-- Query to update confidence score and notes for demo ID 5
BEGIN TRANSACTION;

-- First, select the demo to verify it exists and check current values
SELECT id, category, language, confidence_percent, notes
FROM demos
WHERE id = 5;

-- Update the confidence score and notes
UPDATE demos
SET
    confidence_percent = 85, -- Updating confidence score to 85%
    notes = 'Updated on June 15, 2025. This demo has been reviewed and improved based on user feedback. The increased confidence score reflects enhanced reliability and effectiveness of the demonstration materials.'
WHERE id = 5;

-- Verify the update was successful
SELECT id, category, language, confidence_percent, notes
FROM demos
WHERE id = 5;

COMMIT; -- Commit the transaction if the update looks correct
-- To rollback instead, use: ROLLBACK;

-- Query to reset the confidence score by removing the notes and reducing confidence_percent by 5 for demo ID 5
BEGIN TRANSACTION;

-- First, select the demo to verify it exists and check current values
SELECT id, category, language, confidence_percent, notes
FROM demos
WHERE id = 5;

-- Reset confidence score by reducing it by 5 and clear the notes field
UPDATE demos
SET
    confidence_percent = confidence_percent - 5, -- Reducing confidence score by 5%
    notes = NULL -- Removing the notes completely
WHERE id = 5;

-- Verify the update was successful
SELECT id, category, language, confidence_percent, notes
FROM demos
WHERE id = 5;

COMMIT; -- Commit the transaction if the update looks correct
-- To rollback instead, use: ROLLBACK;

-- Query to update demo ID 5 with specific values
BEGIN TRANSACTION;

-- First, select the demo to verify it exists and check current values
SELECT id, category, language, points, confidence_percent, notes
FROM demos
WHERE id = 5;

-- Update the demo with the specified values
UPDATE demos
SET
    confidence_percent = 70, -- Set confidence score to 70%
    notes = 'update notes for id 5', -- Set specific notes text
    points = 40 -- Set points to 40
WHERE id = 5;

-- Verify the update was successful
SELECT id, category, language, points, confidence_percent, notes
FROM demos
WHERE id = 5;

COMMIT; -- Commit the transaction if the update looks correct
-- To rollback instead, use: ROLLBACK;

-- Query to increase all database demo confidence scores by 5% if they're below 80%
BEGIN TRANSACTION;

-- First, show the current values for database demos with confidence scores below 80%
SELECT
    id,
    category,
    sub_category,
    language,
    confidence_percent AS current_confidence
FROM
    demos
WHERE
    category = 'Database'
    AND confidence_percent < 80;

-- Update database demos with confidence scores below 80%
UPDATE demos
SET
    confidence_percent = confidence_percent + 5,
    notes = CASE
                WHEN notes IS NULL THEN 'Confidence increased by 5% on June 15, 2025 as part of database demos quality improvement.'
                ELSE notes + ' Confidence increased by 5% on June 15, 2025 as part of database demos quality improvement.'
            END
WHERE
    category = 'Database'
    AND confidence_percent < 80;

-- Show the updated values to verify the changes
SELECT
    id,
    category,
    sub_category,
    language,
    confidence_percent AS updated_confidence
FROM
    demos
WHERE
    category = 'Database'
    AND confidence_percent BETWEEN 75 AND 85; -- Range to capture both updated and non-updated demos

COMMIT; -- Commit the transaction if the changes look correct
-- To rollback instead, use: ROLLBACK;

-- Query to decrease (reset) all database demo confidence scores by 5% if they're below 80%
BEGIN TRANSACTION;

-- First, show the current values for database demos with confidence scores below 80%
SELECT
    id,
    category,
    sub_category,
    language,
    confidence_percent AS current_confidence
FROM
    demos
WHERE
    category = 'Database'
    AND confidence_percent < 80;

-- Update database demos with confidence scores below 80% by decreasing confidence by 5%
UPDATE demos
SET
    confidence_percent = confidence_percent - 5,
    notes = CASE
                WHEN notes IS NULL THEN 'Confidence reset (decreased by 5%) on June 15, 2025 as part of database demos quality standardization.'
                ELSE CONCAT(notes, ' Confidence reset (decreased by 5%) on June 15, 2025 as part of database demos quality standardization.')
            END
WHERE
    category = 'database'
    AND confidence_percent < 80;

-- Show the updated values to verify the changes
SELECT
    id,
    category,
    sub_category,
    language,
    confidence_percent AS updated_confidence
FROM
    demos
WHERE
    category = 'Database'
    AND confidence_percent < 80; -- To see the affected records

COMMIT; -- Commit the transaction if the changes look correct
-- To rollback instead, use: ROLLBACK;

select * from dbo.demos where category = 'databases';

-- Query to find all demos with confidence_percent greater than 70% and points greater than 50

