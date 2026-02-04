USE [ITI_System]
GO

PRINT '=================================================='
PRINT 'Testing All Stored Procedures'
PRINT 'NOTE: This script uses transactions and rolls back changes.'
PRINT 'Your existing data will not be modified.'
PRINT '=================================================='
GO

-- =============================================
-- Test 'course' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [course] procedures...'
BEGIN TRAN
BEGIN TRY
    -- 1. Test INSERT
    PRINT '  1. Testing sp_course_insert...'
    EXEC dbo.sp_course_insert @name = 'Test Course', @course_code = 'TEST101', @duration = 30;
    DECLARE @courseId INT = SCOPE_IDENTITY();
    IF @courseId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.course WHERE id = @courseId AND name = 'Test Course')
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    -- 2. Test SELECT BY ID
    PRINT '  2. Testing sp_course_select_by_id...'
    EXEC dbo.sp_course_select_by_id @id = @courseId;
    PRINT '     -> SELECT BY ID executed.'

    -- 3. Test UPDATE (partial)
    PRINT '  3. Testing sp_course_update (partial)...'
    EXEC dbo.sp_course_update @id = @courseId, @name = 'Updated Test Course';
    IF EXISTS(SELECT 1 FROM dbo.course WHERE id = @courseId AND name = 'Updated Test Course' AND course_code = 'TEST101')
        PRINT '     -> Partial UPDATE successful.'
    ELSE
        THROW 50002, 'Partial UPDATE FAILED.', 1;

    -- 4. Test DELETE
    PRINT '  4. Testing sp_course_delete...'
    EXEC dbo.sp_course_delete @id = @courseId;
    IF NOT EXISTS(SELECT 1 FROM dbo.course WHERE id = @courseId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
        
    -- 5. Test SELECT ALL (will be empty if run on a clean DB)
    PRINT '  5. Testing sp_course_select_all...'
    EXEC dbo.sp_course_select_all;
    PRINT '     -> SELECT ALL executed.'

END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [course] tests complete. Transaction rolled back.'
GO

-- =============================================
-- Test 'department' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [department] procedures...'
BEGIN TRAN
BEGIN TRY
    -- 1. Test INSERT
    PRINT '  1. Testing sp_department_insert...'
    EXEC dbo.sp_department_insert @name = 'Test Department';
    DECLARE @deptId INT = SCOPE_IDENTITY();
    IF @deptId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.department WHERE id = @deptId AND name = 'Test Department')
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    -- 2. Test UPDATE
    PRINT '  2. Testing sp_department_update...'
    EXEC dbo.sp_department_update @id = @deptId, @name = 'Updated Department';
    IF EXISTS(SELECT 1 FROM dbo.department WHERE id = @deptId AND name = 'Updated Department')
        PRINT '     -> UPDATE successful.'
    ELSE
        THROW 50002, 'UPDATE FAILED.', 1;
        
    -- 3. Test DELETE
    PRINT '  3. Testing sp_department_delete...'
    EXEC dbo.sp_department_delete @id = @deptId;
    IF NOT EXISTS(SELECT 1 FROM dbo.department WHERE id = @deptId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [department] tests complete. Transaction rolled back.'
GO


-- =============================================
-- Test 'instructor' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [instructor] procedures...'
BEGIN TRAN
BEGIN TRY
    -- Arrange: Need a department first
    INSERT INTO dbo.department (name) VALUES ('Temp Dept for Instructor Test');
    DECLARE @tempDeptId INT = SCOPE_IDENTITY();

    -- 1. Test INSERT
    PRINT '  1. Testing sp_instructor_insert...'
    EXEC dbo.sp_instructor_insert @name = 'Test Instructor', @degree = 'M.Sc.', @salary = 9000, @deptId = @tempDeptId;
    DECLARE @insId INT = SCOPE_IDENTITY();
    IF @insId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.instructor WHERE id = @insId AND name = 'Test Instructor')
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    -- 2. Test UPDATE
    PRINT '  2. Testing sp_instructor_update...'
    EXEC dbo.sp_instructor_update @id = @insId, @salary = 9500.50;
    IF EXISTS(SELECT 1 FROM dbo.instructor WHERE id = @insId AND salary = 9500.50)
        PRINT '     -> UPDATE successful.'
    ELSE
        THROW 50002, 'UPDATE FAILED.', 1;
        
    -- 3. Test DELETE
    PRINT '  3. Testing sp_instructor_delete...'
    EXEC dbo.sp_instructor_delete @id = @insId;
    IF NOT EXISTS(SELECT 1 FROM dbo.instructor WHERE id = @insId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [instructor] tests complete. Transaction rolled back.'
GO


-- =============================================
-- Test 'student' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [student] procedures...'
BEGIN TRAN
BEGIN TRY
    -- 1. Test INSERT
    PRINT '  1. Testing sp_student_insert...'
    EXEC dbo.sp_student_insert @fname = 'Test', @lname = 'Student', @age = 25, @address = '123 Test St';
    DECLARE @studId INT = SCOPE_IDENTITY();
    IF @studId IS NOT NULL AND EXISTS(SELECT 1 FROM dbo.student WHERE id = @studId AND fname = 'Test')
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    -- 2. Test UPDATE
    PRINT '  2. Testing sp_student_update...'
    EXEC dbo.sp_student_update @id = @studId, @age = 26, @address = '456 Updated Ave';
    IF EXISTS(SELECT 1 FROM dbo.student WHERE id = @studId AND age = 26 AND @address = '456 Updated Ave')
        PRINT '     -> UPDATE successful.'
    ELSE
        THROW 50002, 'UPDATE FAILED.', 1;
        
    -- 3. Test DELETE
    PRINT '  3. Testing sp_student_delete...'
    EXEC dbo.sp_student_delete @id = @studId;
    IF NOT EXISTS(SELECT 1 FROM dbo.student WHERE id = @studId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [student] tests complete. Transaction rolled back.'
GO

-- Add similar test blocks for exam, question, and track...

-- =============================================
-- Test 'exam' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [exam] procedures...'
BEGIN TRAN
BEGIN TRY
    PRINT '  1. Testing sp_exam_insert...'
    EXEC dbo.sp_exam_insert @name = 'Test Exam', @duration = 120;
    DECLARE @examId INT = SCOPE_IDENTITY();
    IF @examId IS NOT NULL
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    PRINT '  2. Testing sp_exam_update...'
    EXEC dbo.sp_exam_update @id = @examId, @name = 'Updated Test Exam';
    IF EXISTS(SELECT 1 FROM dbo.exam WHERE id = @examId AND name = 'Updated Test Exam')
        PRINT '     -> UPDATE successful.'
    ELSE
        THROW 50002, 'UPDATE FAILED.', 1;

    PRINT '  3. Testing sp_exam_delete...'
    EXEC dbo.sp_exam_delete @id = @examId;
    IF NOT EXISTS(SELECT 1 FROM dbo.exam WHERE id = @examId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [exam] tests complete. Transaction rolled back.'
GO

-- =============================================
-- Test 'question' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [question] procedures...'
BEGIN TRAN
BEGIN TRY
    -- Arrange: Need a course first
    INSERT INTO dbo.course (name) VALUES ('Temp Course for Question Test');
    DECLARE @tempCourseId INT = SCOPE_IDENTITY();

    PRINT '  1. Testing sp_question_insert...'
    EXEC dbo.sp_question_insert @type = 'MCQ', @grade = 5, @answer = 'B', @crsId = @tempCourseId;
    DECLARE @qId INT = SCOPE_IDENTITY();
    IF @qId IS NOT NULL
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    PRINT '  2. Testing sp_question_update...'
    EXEC dbo.sp_question_update @id = @qId, @grade = 6;
     IF EXISTS(SELECT 1 FROM dbo.question WHERE id = @qId AND grade = 6)
        PRINT '     -> UPDATE successful.'
    ELSE
        THROW 50002, 'UPDATE FAILED.', 1;

    PRINT '  3. Testing sp_question_delete...'
    EXEC dbo.sp_question_delete @id = @qId;
    IF NOT EXISTS(SELECT 1 FROM dbo.question WHERE id = @qId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [question] tests complete. Transaction rolled back.'
GO


-- =============================================
-- Test 'track' procedures
-- =============================================
PRINT '--------------------------------------------------'
PRINT 'Testing [track] procedures...'
BEGIN TRAN
BEGIN TRY
    -- Arrange: Need a department first
    INSERT INTO dbo.department (name) VALUES ('Temp Dept for Track Test');
    DECLARE @tempDeptId_ForTrack INT = SCOPE_IDENTITY();

    PRINT '  1. Testing sp_track_insert...'
    EXEC dbo.sp_track_insert @name = 'Test Track', @location = 'Online', @deptId = @tempDeptId_ForTrack;
    DECLARE @trackId INT = SCOPE_IDENTITY();
    IF @trackId IS NOT NULL
        PRINT '     -> INSERT successful.'
    ELSE
        THROW 50001, 'INSERT FAILED.', 1;

    PRINT '  2. Testing sp_track_update...'
    EXEC dbo.sp_track_update @id = @trackId, @location = 'Remote';
    IF EXISTS(SELECT 1 FROM dbo.track WHERE id = @trackId AND location = 'Remote')
        PRINT '     -> UPDATE successful.'
    ELSE
        THROW 50002, 'UPDATE FAILED.', 1;

    PRINT '  3. Testing sp_track_delete...'
    EXEC dbo.sp_track_delete @id = @trackId;
    IF NOT EXISTS(SELECT 1 FROM dbo.track WHERE id = @trackId)
        PRINT '     -> DELETE successful.'
    ELSE
        THROW 50003, 'DELETE FAILED.', 1;
END TRY
BEGIN CATCH
    PRINT '     -> ERROR: ' + ERROR_MESSAGE();
END CATCH
ROLLBACK TRAN
PRINT '... [track] tests complete. Transaction rolled back.'
GO

PRINT '=================================================='
PRINT 'All tests concluded.'
PRINT '=================================================='
GO
