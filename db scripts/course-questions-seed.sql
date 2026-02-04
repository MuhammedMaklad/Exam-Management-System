-- Q1
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'B', 1, 'Which of the following is the correct way to declare a variable in C#?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'int'),
(@current_id, 'var'),
(@current_id, 'let'),
(@current_id, 'dim');
GO

-- Q2
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'A', 1, 'What does ASP.NET stand for?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'Active Server Pages .NET'),
(@current_id, 'Advanced Server Pages .NET'),
(@current_id, 'Application Server Pages .NET'),
(@current_id, 'Automatic Server Pages .NET');
GO

-- Q3
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'C', 1, 'Which method is used to start a session in ASP.NET?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'StartSession()'),
(@current_id, 'BeginSession()'),
(@current_id, 'OpenSession()'),
(@current_id, 'InitSession()');
GO

-- Q4
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'D', 1, 'What is the default authentication mode in ASP.NET?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'Forms'),
(@current_id, 'Windows'),
(@current_id, 'Passport'),
(@current_id, 'None');
GO

-- Q5
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'B', 1, 'Which control is used for client-side validation?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'RequiredFieldValidator'),
(@current_id, 'CompareValidator'),
(@current_id, 'RangeValidator'),
(@current_id, 'CustomValidator');
GO

-- Q6
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'A', 1, 'Which namespace is used for accessing the database in .NET?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'System.Data'),
(@current_id, 'System.IO'),
(@current_id, 'System.Net'),
(@current_id, 'System.Web');
GO

-- Q7
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'C', 1, 'What does the "ViewState" do in ASP.NET?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'Stores values between postbacks'),
(@current_id, 'Stores values on the server only'),
(@current_id, 'Stores values in cookies'),
(@current_id, 'Stores values in the database');
GO

-- Q8
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'D', 1, 'Which HTTP method is used to submit form data securely?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'GET'),
(@current_id, 'POST'),
(@current_id, 'PUT'),
(@current_id, 'DELETE');
GO

-- Q9
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'A', 1, 'What is the default file extension for an ASP.NET Web Form?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, '.aspx'),
(@current_id, '.html'),
(@current_id, '.cs'),
(@current_id, '.config');
GO

-- Q10
INSERT INTO dbo.question (type, grade, answer, crsId, description)
VALUES ('MCQ', 5, 'B', 1, 'Which directive is used to import namespaces in ASP.NET?');
GO
DECLARE @current_id INT = SCOPE_IDENTITY();
INSERT INTO dbo.choice VALUES
(@current_id, 'Import'),
(@current_id, 'Using'),
(@current_id, 'Include'),
(@current_id, 'Namespace');
GO


-- Insert 10 True/False questions for crsId = 1
DECLARE @QuestionData TABLE (
    RowNum INT IDENTITY(1,1),
    [type] VARCHAR(10),
    [grade] INT,
    [answer] VARCHAR(10),
    [crsId] INT,
    [description] VARCHAR(500)
);

-- Insert data into temp table
INSERT INTO @QuestionData ([type], [grade], [answer], [crsId], [description])
VALUES
('T/F', 5, 'True', 1, 'ASP.NET is a server-side web application framework.'),
('T/F', 5, 'False', 1, 'ViewState is stored on the server by default.'),
('T/F', 5, 'True', 1, 'C# is the primary language used in ASP.NET development.'),
('T/F', 5, 'False', 1, 'ASP.NET only supports Internet Explorer.'),
('T/F', 5, 'True', 1, 'You can use sessions to store user-specific data in ASP.NET.'),
('T/F', 5, 'False', 1, 'Web.config is optional for configuring an ASP.NET project.'),
('T/F', 5, 'True', 1, 'ASP.NET supports both Web Forms and MVC architectures.'),
('T/F', 5, 'False', 1, 'All ASP.NET pages must have a .aspx extension.'),
('T/F', 5, 'True', 1, 'The code-behind file contains server-side logic for an ASP.NET page.'),
('T/F', 5, 'True', 1, 'Server controls generate HTML dynamically.');

-- Variables for cursor
DECLARE @Type VARCHAR(10), @Grade INT, @Answer VARCHAR(10), @CrsId INT, @Desc VARCHAR(500);
DECLARE @QuestionId INT;

-- Cursor to process each row
DECLARE question_cursor CURSOR FOR 
    SELECT [type], [grade], [answer], [crsId], [description] 
    FROM @QuestionData;

OPEN question_cursor;
FETCH NEXT FROM question_cursor INTO @Type, @Grade, @Answer, @CrsId, @Desc;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Insert question
    INSERT INTO [dbo].[question] ([type], [grade], [answer], [crsId], [description])
    VALUES (@Type, @Grade, @Answer, @CrsId, @Desc);
    
    -- Get the inserted ID
    SET @QuestionId = SCOPE_IDENTITY();
    
    -- Insert choices for this question
    INSERT INTO [dbo].choice([questionId], [choice])
    VALUES (@QuestionId, 'True'), (@QuestionId, 'False');
    
    FETCH NEXT FROM question_cursor INTO @Type, @Grade, @Answer, @CrsId, @Desc;
END;

CLOSE question_cursor;
DEALLOCATE question_cursor;