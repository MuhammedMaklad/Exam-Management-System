USE [ITI_System]
GO

-- =============================================
-- Clear Data & Reset Identity Seeds
-- (in reverse order of dependencies)
-- =============================================
DELETE FROM [dbo].[student_answers];
DELETE FROM [dbo].[student_exam_course];
DELETE FROM [dbo].[exam_question];
DELETE FROM [dbo].[track_instructor];
DELETE FROM [dbo].[track_course];
DELETE FROM [dbo].[student_course];
DELETE FROM [dbo].[instructor_course];
DELETE FROM [dbo].[choice];
DELETE FROM [dbo].[question];
DELETE FROM [dbo].[exam];
DELETE FROM [dbo].[student];
DELETE FROM [dbo].[course];
DELETE FROM [dbo].[track];
DELETE FROM [dbo].[instructor];
DELETE FROM [dbo].[department];
GO

DBCC CHECKIDENT ('[dbo].department', RESEED, 0);
DBCC CHECKIDENT ('[dbo].instructor', RESEED, 0);
DBCC CHECKIDENT ('[dbo].track', RESEED, 0);
DBCC CHECKIDENT ('[dbo].course', RESEED, 0);
DBCC CHECKIDENT ('[dbo].student', RESEED, 0);
DBCC CHECKIDENT ('[dbo].question', RESEED, 0);
DBCC CHECKIDENT ('[dbo].exam', RESEED, 0);
GO

-- =============================================
-- Populate Tables with Dummy Data
-- (in order of dependencies)
-- =============================================

-- 1. department
INSERT INTO [dbo].[department] ([name], [mgrId], [mhiredAt]) VALUES ('Software Development', NULL, '2022-01-10');
INSERT INTO [dbo].[department] ([name], [mgrId], [mhiredAt]) VALUES ('Open Source', NULL, '2022-01-15');
GO

-- 2. instructor
INSERT INTO [dbo].[instructor] ([name], [degree], [salary], [deptId]) VALUES ('Dr. Ahmed Ali', 'Ph.D.', 18000.00, 1);
INSERT INTO [dbo].[instructor] ([name], [degree], [salary], [deptId]) VALUES ('Eng. Fatma Said', 'M.Sc.', 14000.00, 2);
INSERT INTO [dbo].[instructor] ([name], [degree], [salary], [deptId]) VALUES ('Dr. John Smith', 'Ph.D.', 19500.00, 1);
GO

-- Update department managers after instructors are created
UPDATE [dbo].[department] SET [mgrId] = 1, [mhiredAt] = '2023-01-01' WHERE [id] = 1;
UPDATE [dbo].[department] SET [mgrId] = 2, [mhiredAt] = '2023-02-01' WHERE [id] = 2;
GO

-- 3. track
INSERT INTO [dbo].[track] ([name], [location], [deptId]) VALUES ('.NET Full Stack', 'Cairo', 1);
INSERT INTO [dbo].[track] ([name], [location], [deptId]) VALUES ('Embedded Systems', 'Alexandria', 2);
GO

-- 4. course
INSERT INTO [dbo].[course] ([name], [course_code], [duration]) VALUES ('SQL Server Development', 'DB-101', 40);
INSERT INTO [dbo].[course] ([name], [course_code], [duration]) VALUES ('C Programming', 'CS-101', 50);
INSERT INTO [dbo].[course] ([name], [course_code], [duration]) VALUES ('ASP.NET Core', 'WEB-301', 60);
GO

-- 5. student
-- Insert students; one will be a supervisor for another
INSERT INTO [dbo].[student] ([fname], [lname], [age], [address], [supId]) VALUES ('Khaled', 'Mohamed', 22, '123 Nasr St, Cairo', NULL);
INSERT INTO [dbo].[student] ([fname], [lname], [age], [address], [supId]) VALUES ('Sara', 'Youssef', 21, '456 Heliopolis, Cairo', NULL);
INSERT INTO [dbo].[student] ([fname], [lname], [age], [address], [supId]) VALUES ('Omar', 'Hassan', 23, '789 Maadi, Cairo', 1); -- Omar's supervisor is Khaled (ID=1)
GO

-- 6. question
INSERT INTO [dbo].[question] ([type], [grade], [answer], [crsId]) VALUES ('MCQ', 2, 'A', 1); -- Question for SQL Server
INSERT INTO [dbo].[question] ([type], [grade], [answer], [crsId]) VALUES ('T/F', 1, 'True', 2); -- Question for C Programming
INSERT INTO [dbo].[question] ([type], [grade], [answer], [crsId]) VALUES ('MCQ', 2, 'C', 3); -- Question for ASP.NET
GO

-- 7. exam
INSERT INTO [dbo].[exam] ([name], [date], [duration]) VALUES ('SQL Midterm Exam', '2023-08-15', 60);
INSERT INTO [dbo].[exam] ([name], [date], [duration]) VALUES ('Programming Final Exam', '2023-10-25', 120);
GO

-- 8. choice (for MCQ questions)
INSERT INTO [dbo].[choice] ([questionId], [choice]) VALUES (1, 'A) Structured Query Language');
INSERT INTO [dbo].[choice] ([questionId], [choice]) VALUES (1, 'B) Simple Query Language');
INSERT INTO [dbo].[choice] ([questionId], [choice]) VALUES (3, 'A) A client-side framework');
INSERT INTO [dbo].[choice] ([questionId], [choice]) VALUES (3, 'B) A database system');
INSERT INTO [dbo].[choice] ([questionId], [choice]) VALUES (3, 'C) A powerful web framework');
GO

-- 9. instructor_course (linking table)
INSERT INTO [dbo].[instructor_course] ([insId], [courseId]) VALUES (1, 1); -- Dr. Ahmed teaches SQL
INSERT INTO [dbo].[instructor_course] ([insId], [courseId]) VALUES (1, 3); -- Dr. Ahmed teaches ASP.NET
INSERT INTO [dbo].[instructor_course] ([insId], [courseId]) VALUES (2, 2); -- Eng. Fatma teaches C
GO

-- 10. student_course (linking table)
INSERT INTO [dbo].[student_course] ([stdId], [courseId]) VALUES (1, 1); -- Khaled takes SQL
INSERT INTO [dbo].[student_course] ([stdId], [courseId]) VALUES (1, 3); -- Khaled takes ASP.NET
INSERT INTO [dbo].[student_course] ([stdId], [courseId]) VALUES (2, 2); -- Sara takes C
INSERT INTO [dbo].[student_course] ([stdId], [courseId]) VALUES (3, 1); -- Omar takes SQL
GO

-- 11. track_course (linking table)
INSERT INTO [dbo].[track_course] ([trackId], [courseId]) VALUES (1, 1); -- .NET track has SQL
INSERT INTO [dbo].[track_course] ([trackId], [courseId]) VALUES (1, 3); -- .NET track has ASP.NET
INSERT INTO [dbo].[track_course] ([trackId], [courseId]) VALUES (2, 2); -- Embedded track has C
GO

-- 12. track_instructor (linking table)
INSERT INTO [dbo].[track_instructor] ([trackId], [instructorId]) VALUES (1, 1); -- .NET track has Dr. Ahmed
INSERT INTO [dbo].[track_instructor] ([trackId], [instructorId]) VALUES (2, 2); -- Embedded track has Eng. Fatma
GO

-- 13. exam_question (linking table)
INSERT INTO [dbo].[exam_question] ([examId], [questionId]) VALUES (1, 1); -- SQL Midterm has SQL question
INSERT INTO [dbo].[exam_question] ([examId], [questionId]) VALUES (2, 2); -- Programming Final has C question
INSERT INTO [dbo].[exam_question] ([examId], [questionId]) VALUES (2, 3); -- Programming Final has ASP.NET question
GO

-- 14. student_exam_course (records student grades for an exam)
INSERT INTO [dbo].[student_exam_course] ([stdId], [examId], [courseId], [sgrade], [date]) VALUES (1, 1, 1, 85.50, '2023-08-15');
INSERT INTO [dbo].[student_exam_course] ([stdId], [examId], [courseId], [sgrade], [date]) VALUES (2, 2, 2, 92.00, '2023-10-25');
GO

-- 15. student_answers (records student answers for questions in an exam)
INSERT INTO [dbo].[student_answers] ([stdId], [examId], [courseId], [qId], [answer]) VALUES (1, 1, 1, 1, 'A');
INSERT INTO [dbo].[student_answers] ([stdId], [examId], [courseId], [qId], [answer]) VALUES (2, 2, 2, 2, 'True');
GO
