CREATE OR ALTER PROCEDURE sp_generate_exam
(
    @course_id INT,
    @mcq_questions INT,
    @tf_questions INT
)
AS
BEGIN
    SET NOCOUNT ON;
    ;WITH MCQ AS
    (
        SELECT TOP (@mcq_questions) id
        FROM question
        WHERE crsId = @course_id AND type = 'MCQ'
        ORDER BY NEWID()
    ),
    TF AS
    (
        SELECT TOP (@tf_questions) id
        FROM question
        WHERE crsId = @course_id AND type = 'T/F'
        ORDER BY NEWID()
    )
    SELECT * INTO #SelectedQuestions
    FROM
    (
        SELECT id FROM MCQ
        UNION ALL
        SELECT id FROM TF
    ) AS AllQuestions;

    DECLARE @course_exams INT = (SELECT COUNT(*) FROM exam WHERE courseId = @course_id);
    DECLARE @course_name VARCHAR(50) = (SELECT name FROM course WHERE id = @course_id);

    INSERT INTO exam (name, duration, courseId)
    VALUES (CONCAT(@course_name, '-', @course_exams + 1), 30, @course_id);

    DECLARE @exam_id INT = SCOPE_IDENTITY()
    INSERT INTO exam_question (examId, questionId)
    SELECT @exam_id, id
    FROM #SelectedQuestions;

    DROP TABLE #SelectedQuestions;
END

exec sp_exam_select_all
exec sp_generate_exam 1, 5, 5

CREATE OR ALTER PROCEDURE sp_generate_exam_v2
(
    @course_id INT,
    @mcq_questions INT,
    @tf_questions INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Declare table variable
    DECLARE @SelectedQuestions TABLE (id INT);
    
    -- Insert into table variable using CTE
    ;WITH MCQ AS
    (
        SELECT TOP (@mcq_questions) id
        FROM question
        WHERE crsId = @course_id AND type = 'MCQ'
        ORDER BY NEWID()
    ),
    TF AS
    (
        SELECT TOP (@tf_questions) id
        FROM question
        WHERE crsId = @course_id AND type = 'T/F'
        ORDER BY NEWID()
    )
    INSERT INTO @SelectedQuestions (id)
    SELECT id FROM MCQ
    UNION ALL
    SELECT id FROM TF;

    DECLARE @course_exams INT = (SELECT COUNT(*) FROM exam WHERE courseId = @course_id);
    DECLARE @course_name VARCHAR(50) = (SELECT name FROM course WHERE id = @course_id);

    INSERT INTO exam (name, duration, courseId)
    VALUES (CONCAT(@course_name, '-', @course_exams + 1), 30, @course_id);

    DECLARE @exam_id INT = SCOPE_IDENTITY()
    
    INSERT INTO exam_question (examId, questionId)
    SELECT @exam_id, id
    FROM @SelectedQuestions;
END

CREATE OR ALTER PROC sp_get_exam
(
    @exam_id INT
)
AS
BEGIN
    SELECT 
        question.id AS QuestionId,
        question.description AS QuestionText,
        question.answer AS QuestionAnswer,
		question.grade AS QuestionGrade,
        choice.choice AS ChoiceText
    FROM question 
    JOIN exam_question ON question.id = exam_question.questionId 
        AND exam_question.examId = @exam_id
    JOIN choice ON question.id = choice.questionId
END



CREATE OR ALTER FUNCTION fn_get_exam_answers (@exam_id INT)
RETURNS TABLE 
AS RETURN(
	SELECT question.answer 
    FROM question
    JOIN exam_question ON question.id = exam_question.questionId
    WHERE exam_question.examId = @exam_id
)

CREATE OR ALTER PROCEDURE dbo.sp_save_student_answers
(
    @exam_id INT,
    @student_full_name VARCHAR(150),

    @qId1 int,  @ans1 VARCHAR(20),
    @qId2 int,  @ans2 VARCHAR(20),
    @qId3 int,  @ans3 VARCHAR(20),
    @qId4 int,  @ans4 VARCHAR(20),
    @qId5 int,  @ans5 VARCHAR(20),
    @qId6 int,  @ans6 VARCHAR(20),
    @qId7 int,  @ans7 VARCHAR(20),
    @qId8 int,  @ans8 VARCHAR(20),
    @qId9 int,  @ans9 VARCHAR(20),
    @qId10 int, @ans10 VARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;  -- Auto rollback on runtime errors

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Get course id
        DECLARE @course_id INT = (
            SELECT courseId 
            FROM dbo.exam 
            WHERE id = @exam_id
        );

        DECLARE @student_id INT = (
            SELECT id
            FROM dbo.student
            WHERE CONCAT(fname, ' ', lname) = @student_full_name
        );

        IF @student_id IS NULL
            THROW 50001, 'Student not found', 1;

        IF @course_id IS NULL
            THROW 50002, 'Exam not found or no course linked', 1;

        IF NOT EXISTS (
            SELECT 1 
            FROM dbo.student_exam_course
            WHERE stdId = @student_id
              AND examId = @exam_id
              AND courseId = @course_id
        )
        BEGIN
            INSERT INTO dbo.student_exam_course(stdId, examId, courseId, date)
            VALUES (@student_id, @exam_id, @course_id, GETDATE());
        END

        INSERT INTO dbo.student_answers(stdId, examId, questionId, answer) VALUES
            (@student_id, @exam_id, @qId1,  @ans1),
            (@student_id, @exam_id, @qId2,  @ans2),
            (@student_id, @exam_id, @qId3,  @ans3),
            (@student_id, @exam_id, @qId4,  @ans4),
            (@student_id, @exam_id, @qId5,  @ans5),
            (@student_id, @exam_id, @qId6,  @ans6),
            (@student_id, @exam_id, @qId7,  @ans7),
            (@student_id, @exam_id, @qId8,  @ans8),
            (@student_id, @exam_id, @qId9,  @ans9),
            (@student_id, @exam_id, @qId10, @ans10);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END



CREATE OR ALTER PROCEDURE sp_correct_exam
(
    @exam_id INT,
    @student_full_name VARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @student_id INT;
    DECLARE @total_questions INT;
    DECLARE @correct_count INT;
    DECLARE @total_grade INT;
    DECLARE @earned_grade INT;
    DECLARE @percentage DECIMAL(5,2);

    SELECT @student_id = id
    FROM student
    WHERE CONCAT(fname, ' ', lname) = @student_full_name;

    SELECT @total_questions = COUNT(*)
    FROM exam_question
    WHERE examId = @exam_id;

    SELECT @total_grade = SUM(q.grade)
    FROM exam_question eq
    JOIN question q 
        ON q.id = eq.questionId
    WHERE eq.examId = @exam_id;

    SELECT 
        @earned_grade = ISNULL(SUM(q.grade), 0),
        @correct_count = COUNT(*)
    FROM exam_question eq
    JOIN question q 
        ON q.id = eq.questionId
    JOIN student_answers sa
        ON sa.examId = eq.examId
       AND sa.questionId = eq.questionId
       AND sa.stdId = @student_id
    WHERE eq.examId = @exam_id
      AND sa.answer = q.answer;

    IF @total_grade > 0
        SET @percentage = (@earned_grade * 100.0) / @total_grade;
    ELSE
        SET @percentage = 0;

    SELECT 
        @student_id     AS StudentId,
        @exam_id        AS ExamId,
        @correct_count  AS CorrectAnswers,
        @total_questions AS TotalQuestions,
        @earned_grade   AS EarnedGrade,
        @total_grade    AS TotalGrade,
        @percentage     AS Percentage;
END


CREATE OR ALTER PROCEDURE sp_get_track_courses
(
    @trackId INT
)
AS 
BEGIN
    SELECT 
        course.id, 
        course.name 
    FROM course
    JOIN track_course ON course.id = track_course.courseId
    WHERE track_course.trackId = @trackId
END

exec sp_get_track_courses 1