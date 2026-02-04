USE [ITI_System]
GO

-- =============================================
-- Stored Procedures for 'course' table
-- =============================================

-- Select all courses
CREATE OR ALTER PROCEDURE dbo.sp_course_select_all
AS
BEGIN
    SELECT * FROM dbo.course;
END
GO

-- Select course by ID
CREATE OR ALTER PROCEDURE dbo.sp_course_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.course WHERE id = @id;
END
GO

-- Insert a new course
CREATE OR ALTER PROCEDURE dbo.sp_course_insert
    @name VARCHAR(100) = NULL,
    @course_code VARCHAR(20) = NULL,
    @duration INT = NULL
AS
BEGIN
    INSERT INTO dbo.course (name, course_code, duration)
    VALUES (@name, @course_code, @duration);
END
GO

-- Update an existing course
CREATE OR ALTER PROCEDURE dbo.sp_course_update
    @id INT,
    @name VARCHAR(100) = NULL,
    @course_code VARCHAR(20) = NULL,
    @duration INT = NULL
AS
BEGIN
    UPDATE dbo.course
    SET name = ISNULL(@name, name),
        course_code = ISNULL(@course_code, course_code),
        duration = ISNULL(@duration, duration)
    WHERE id = @id;
END
GO

-- Delete a course by ID
CREATE OR ALTER PROCEDURE dbo.sp_course_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.course WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'department' table
-- =============================================

-- Select all departments
CREATE OR ALTER PROCEDURE dbo.sp_department_select_all
AS
BEGIN
    SELECT * FROM dbo.department;
END
GO

-- Select department by ID
CREATE OR ALTER PROCEDURE dbo.sp_department_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.department WHERE id = @id;
END
GO

-- Insert a new department
CREATE OR ALTER PROCEDURE dbo.sp_department_insert
    @name VARCHAR(100),
    @mgrId INT = NULL,
    @mhiredAt DATE = NULL
AS
BEGIN
    INSERT INTO dbo.department (name, mgrId, mhiredAt)
    VALUES (@name, @mgrId, @mhiredAt);
END
GO

-- Update an existing department
CREATE OR ALTER PROCEDURE dbo.sp_department_update
    @id INT,
    @name VARCHAR(100) = NULL,
    @mgrId INT = NULL,
    @mhiredAt DATE = NULL
AS
BEGIN
    UPDATE dbo.department
    SET name = ISNULL(@name, name),
        mgrId = ISNULL(@mgrId, mgrId),
        mhiredAt = ISNULL(@mhiredAt, mhiredAt)
    WHERE id = @id;
END
GO

-- Delete a department by ID
CREATE OR ALTER PROCEDURE dbo.sp_department_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.department WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'exam' table
-- =============================================

-- Select all exams
CREATE OR ALTER PROCEDURE dbo.sp_exam_select_all
AS
BEGIN
    SELECT * FROM dbo.exam;
END
GO

-- Select exam by ID
CREATE OR ALTER PROCEDURE dbo.sp_exam_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.exam WHERE id = @id;
END
GO

-- Insert a new exam
CREATE OR ALTER PROCEDURE dbo.sp_exam_insert
    @name VARCHAR(100) = NULL,
    @date DATE = NULL,
    @duration INT = NULL
AS
BEGIN
    INSERT INTO dbo.exam (name, date, duration)
    VALUES (@name, @date, @duration);
END
GO

-- Update an existing exam
CREATE OR ALTER PROCEDURE dbo.sp_exam_update
    @id INT,
    @name VARCHAR(100) = NULL,
    @date DATE = NULL,
    @duration INT = NULL
AS
BEGIN
    UPDATE dbo.exam
    SET name = ISNULL(@name, name),
        date = ISNULL(@date, date),
        duration = ISNULL(@duration, duration)
    WHERE id = @id;
END
GO

-- Delete an exam by ID
CREATE OR ALTER PROCEDURE dbo.sp_exam_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.exam WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'instructor' table
-- =============================================

-- Select all instructors
CREATE OR ALTER PROCEDURE dbo.sp_instructor_select_all
AS
BEGIN
    SELECT * FROM dbo.instructor;
END
GO

-- Select instructor by ID
CREATE OR ALTER PROCEDURE dbo.sp_instructor_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.instructor WHERE id = @id;
END
GO

-- Insert a new instructor
CREATE OR ALTER PROCEDURE dbo.sp_instructor_insert
    @name VARCHAR(100) = NULL,
    @degree VARCHAR(50) = NULL,
    @salary DECIMAL(10, 2) = NULL,
    @deptId INT = NULL
AS
BEGIN
    INSERT INTO dbo.instructor (name, degree, salary, deptId)
    VALUES (@name, @degree, @salary, @deptId);
END
GO

-- Update an existing instructor
CREATE OR ALTER PROCEDURE dbo.sp_instructor_update
    @id INT,
    @name VARCHAR(100) = NULL,
    @degree VARCHAR(50) = NULL,
    @salary DECIMAL(10, 2) = NULL,
    @deptId INT = NULL
AS
BEGIN
    UPDATE dbo.instructor
    SET name = ISNULL(@name, name),
        degree = ISNULL(@degree, degree),
        salary = ISNULL(@salary, salary),
        deptId = ISNULL(@deptId, deptId)
    WHERE id = @id;
END
GO

-- Delete an instructor by ID
CREATE OR ALTER PROCEDURE dbo.sp_instructor_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.instructor WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'question' table
-- =============================================

-- Select all questions
CREATE OR ALTER PROCEDURE dbo.sp_question_select_all
AS
BEGIN
    SELECT * FROM dbo.question;
END
GO

-- Select question by ID
CREATE OR ALTER PROCEDURE dbo.sp_question_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.question WHERE id = @id;
END
GO

-- Insert a new question
CREATE OR ALTER PROCEDURE dbo.sp_question_insert
    @type VARCHAR(50) = NULL,
    @grade INT = NULL,
    @answer VARCHAR(255) = NULL,
    @crsId INT = NULL
AS
BEGIN
    INSERT INTO dbo.question (type, grade, answer, crsId)
    VALUES (@type, @grade, @answer, @crsId);
END
GO

-- Update an existing question
CREATE OR ALTER PROCEDURE dbo.sp_question_update
    @id INT,
    @type VARCHAR(50) = NULL,
    @grade INT = NULL,
    @answer VARCHAR(255) = NULL,
    @crsId INT = NULL
AS
BEGIN
    UPDATE dbo.question
    SET type = ISNULL(@type, type),
        grade = ISNULL(@grade, grade),
        answer = ISNULL(@answer, answer),
        crsId = ISNULL(@crsId, crsId)
    WHERE id = @id;
END
GO

-- Delete a question by ID
CREATE OR ALTER PROCEDURE dbo.sp_question_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.question WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'student' table
-- =============================================

-- Select all students
CREATE OR ALTER PROCEDURE dbo.sp_student_select_all
AS
BEGIN
    SELECT * FROM dbo.student;
END
GO

-- Select student by ID
CREATE OR ALTER PROCEDURE dbo.sp_student_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.student WHERE id = @id;
END
GO

-- Insert a new student
CREATE OR ALTER PROCEDURE dbo.sp_student_insert
    @fname VARCHAR(50) = NULL,
    @lname VARCHAR(50) = NULL,
    @age INT = NULL,
    @address VARCHAR(150) = NULL,
    @supId INT = NULL
AS
BEGIN
    INSERT INTO dbo.student (fname, lname, age, address, supId)
    VALUES (@fname, @lname, @age, @address, @supId);
END
GO

-- Update an existing student
CREATE OR ALTER PROCEDURE dbo.sp_student_update
    @id INT,
    @fname VARCHAR(50) = NULL,
    @lname VARCHAR(50) = NULL,
    @age INT = NULL,
    @address VARCHAR(150) = NULL,
    @supId INT = NULL
AS
BEGIN
    UPDATE dbo.student
    SET fname = ISNULL(@fname, fname),
        lname = ISNULL(@lname, lname),
        age = ISNULL(@age, age),
        address = ISNULL(@address, address),
        supId = ISNULL(@supId, supId)
    WHERE id = @id;
END
GO

-- Delete a student by ID
CREATE OR ALTER PROCEDURE dbo.sp_student_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.student WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'track' table
-- =============================================

-- Select all tracks
CREATE OR ALTER PROCEDURE dbo.sp_track_select_all
AS
BEGIN
    SELECT * FROM dbo.track;
END
GO

-- Select track by ID
CREATE OR ALTER PROCEDURE dbo.sp_track_select_by_id
    @id INT
AS
BEGIN
    SELECT * FROM dbo.track WHERE id = @id;
END
GO

-- Insert a new track
CREATE OR ALTER PROCEDURE dbo.sp_track_insert
    @name VARCHAR(100) = NULL,
    @location VARCHAR(100) = NULL,
    @deptId INT = NULL,
    @mgrId INT = NULL,
    @mhiredAt DATE = NULL
AS
BEGIN
    INSERT INTO dbo.track (name, location, deptId, mgrId, mhiredAt)
    VALUES (@name, @location, @deptId, @mgrId, @mhiredAt);
END
GO

-- Update an existing track
CREATE OR ALTER PROCEDURE dbo.sp_track_update
    @id INT,
    @name VARCHAR(100) = NULL,
    @location VARCHAR(100) = NULL,
    @deptId INT = NULL,
    @mgrId INT = NULL,
    @mhiredAt DATE = NULL
AS
BEGIN
    UPDATE dbo.track
    SET name = ISNULL(@name, name),
        location = ISNULL(@location, location),
        deptId = ISNULL(@deptId, deptId),
        mgrId = ISNULL(@mgrId, mgrId),
        mhiredAt = ISNULL(@mhiredAt, mhiredAt)
    WHERE id = @id;
END
GO

-- Delete a track by ID
CREATE OR ALTER PROCEDURE dbo.sp_track_delete
    @id INT
AS
BEGIN
    DELETE FROM dbo.track WHERE id = @id;
END
GO

-- =============================================
-- Stored Procedures for 'choice' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_choice_select_all
AS BEGIN SELECT * FROM dbo.choice; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_choice_select_by_questionId @questionId INT
AS BEGIN SELECT * FROM dbo.choice WHERE questionId = @questionId; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_choice_insert @questionId INT, @choice VARCHAR(255)
AS BEGIN INSERT INTO dbo.choice (questionId, choice) VALUES (@questionId, @choice); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_choice_update @questionId INT, @oldChoice VARCHAR(255), @newChoice VARCHAR(255)
AS BEGIN UPDATE dbo.choice SET choice = @newChoice WHERE questionId = @questionId AND choice = @oldChoice; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_choice_delete @questionId INT, @choice VARCHAR(255)
AS BEGIN DELETE FROM dbo.choice WHERE questionId = @questionId AND choice = @choice; END
GO

-- =============================================
-- Stored Procedures for 'exam_question' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_exam_question_select_all
AS BEGIN SELECT * FROM dbo.exam_question; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_exam_question_insert @examId INT, @questionId INT
AS BEGIN INSERT INTO dbo.exam_question (examId, questionId) VALUES (@examId, @questionId); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_exam_question_delete @examId INT, @questionId INT
AS BEGIN DELETE FROM dbo.exam_question WHERE examId = @examId AND questionId = @questionId; END
GO

-- =============================================
-- Stored Procedures for 'instructor_course' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_instructor_course_select_all
AS BEGIN SELECT * FROM dbo.instructor_course; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_instructor_course_insert @insId INT, @courseId INT
AS BEGIN INSERT INTO dbo.instructor_course (insId, courseId) VALUES (@insId, @courseId); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_instructor_course_delete @insId INT, @courseId INT
AS BEGIN DELETE FROM dbo.instructor_course WHERE insId = @insId AND courseId = @courseId; END
GO

-- =============================================
-- Stored Procedures for 'student_answers' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_student_answers_select_all
AS BEGIN SELECT * FROM dbo.student_answers; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_answers_select_by_pk @stdId INT, @examId INT, @courseId INT, @qId INT
AS BEGIN SELECT * FROM dbo.student_answers WHERE stdId = @stdId AND examId = @examId AND courseId = @courseId AND qId = @qId; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_answers_insert @stdId INT, @examId INT, @courseId INT, @qId INT, @answer VARCHAR(255) = NULL
AS BEGIN INSERT INTO dbo.student_answers (stdId, examId, courseId, qId, answer) VALUES (@stdId, @examId, @courseId, @qId, @answer); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_answers_update @stdId INT, @examId INT, @courseId INT, @qId INT, @answer VARCHAR(255) = NULL
AS BEGIN UPDATE dbo.student_answers SET answer = @answer WHERE stdId = @stdId AND examId = @examId AND courseId = @courseId AND qId = @qId; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_answers_delete @stdId INT, @examId INT, @courseId INT, @qId INT
AS BEGIN DELETE FROM dbo.student_answers WHERE stdId = @stdId AND examId = @examId AND courseId = @courseId AND qId = @qId; END
GO

-- =============================================
-- Stored Procedures for 'student_course' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_student_course_select_all
AS BEGIN SELECT * FROM dbo.student_course; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_course_insert @stdId INT, @courseId INT
AS BEGIN INSERT INTO dbo.student_course (stdId, courseId) VALUES (@stdId, @courseId); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_course_delete @stdId INT, @courseId INT
AS BEGIN DELETE FROM dbo.student_course WHERE stdId = @stdId AND courseId = @courseId; END
GO

-- =============================================
-- Stored Procedures for 'student_exam_course' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_student_exam_course_select_all
AS BEGIN SELECT * FROM dbo.student_exam_course; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_exam_course_select_by_pk @stdId INT, @examId INT, @courseId INT
AS BEGIN SELECT * FROM dbo.student_exam_course WHERE stdId = @stdId AND examId = @examId AND courseId = @courseId; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_exam_course_insert @stdId INT, @examId INT, @courseId INT, @sgrade DECIMAL(5, 2) = NULL, @date DATE = NULL
AS BEGIN INSERT INTO dbo.student_exam_course (stdId, examId, courseId, sgrade, date) VALUES (@stdId, @examId, @courseId, @sgrade, @date); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_exam_course_update @stdId INT, @examId INT, @courseId INT, @sgrade DECIMAL(5, 2) = NULL, @date DATE = NULL
AS BEGIN UPDATE dbo.student_exam_course SET sgrade = ISNULL(@sgrade, sgrade), date = ISNULL(@date, date) WHERE stdId = @stdId AND examId = @examId AND courseId = @courseId; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_student_exam_course_delete @stdId INT, @examId INT, @courseId INT
AS BEGIN DELETE FROM dbo.student_exam_course WHERE stdId = @stdId AND examId = @examId AND courseId = @courseId; END
GO

-- =============================================
-- Stored Procedures for 'track_course' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_track_course_select_all
AS BEGIN SELECT * FROM dbo.track_course; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_track_course_insert @trackId INT, @courseId INT
AS BEGIN INSERT INTO dbo.track_course (trackId, courseId) VALUES (@trackId, @courseId); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_track_course_delete @trackId INT, @courseId INT
AS BEGIN DELETE FROM dbo.track_course WHERE trackId = @trackId AND courseId = @courseId; END
GO

-- =============================================
-- Stored Procedures for 'track_instructor' table
-- =============================================

CREATE OR ALTER PROCEDURE dbo.sp_track_instructor_select_all
AS BEGIN SELECT * FROM dbo.track_instructor; END
GO

CREATE OR ALTER PROCEDURE dbo.sp_track_instructor_insert @trackId INT, @instructorId INT
AS BEGIN INSERT INTO dbo.track_instructor (trackId, instructorId) VALUES (@trackId, @instructorId); END
GO

CREATE OR ALTER PROCEDURE dbo.sp_track_instructor_delete @trackId INT, @instructorId INT
AS BEGIN DELETE FROM dbo.track_instructor WHERE trackId = @trackId AND instructorId = @instructorId; END
GO
