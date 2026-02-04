CREATE OR ALTER TRIGGER t_handle_insert_choice
ON choice
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN question q ON q.id = i.questionId
        WHERE
            (q.type = 'MCQ' AND
             (SELECT COUNT(*) FROM choice c WHERE c.questionId = i.questionId) >= 4)
         OR (q.type = 'T/F' AND
             (SELECT COUNT(*) FROM choice c WHERE c.questionId = i.questionId) >= 2)
    )
    BEGIN
        RAISERROR (
            'Choice limit exceeded for this question type.',
            16, 1
        );
        RETURN;
    END;

    INSERT INTO choice
    SELECT * FROM inserted;
END;
GO
