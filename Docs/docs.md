sp_generate_exam

Description: This stored procedure generates an exam for a given course by randomly
selecting a specified number of Multiple Choice Questions (MCQ) and True/False (T/F)
questions. It then creates a new exam entry in the exam table, assigns a name based on
the course and the number of existing exams for that course, and links the selected
questions to the new exam in the exam_question table.

Parameters:

- @course_id INT: The ID of the course for which the exam is to be generated.
- @mcq_questions INT: The number of MCQ questions to include in the exam.
- @tf_questions INT: The number of True/False questions to include in the exam.

  sp_generate_exam_v2

  Description: This is an alternative version of sp_generate_exam that serves the same
  purpose. It generates an exam for a given course by randomly selecting a specified
  number of Multiple Choice Questions (MCQ) and True/False (T/F) questions. It uses a
  table variable (@SelectedQuestions) instead of a temporary table (#SelectedQuestions) to
  store the selected question IDs. It then creates a new exam entry in the exam table,
  assigns a name, and links the selected questions to the new exam.

  Parameters:

- @course_id INT: The ID of the course for which the exam is to be generated.
- @mcq_questions INT: The number of MCQ questions to include in the exam.
- @tf_questions INT: The number of True/False questions to include in the exam.

  sp_get_exam

  Description: This stored procedure retrieves the details of all questions and their
  associated choices for a specific exam. It joins the question, exam_question, and choice
  tables to provide a comprehensive view of the exam content.

  Parameters:

- @exam_id INT: The ID of the exam for which to retrieve details.

  fn_get_exam_answers

  Description: This table-valued function returns the correct answers for all questions
  belonging to a specified exam. It joins the question and exam_question tables to filter
  questions by exam ID and retrieve their answers.

  Parameters:

- @exam_id INT: The ID of the exam for which to retrieve answers.

  dbo.sp_save_student_answers

  Description: This stored procedure saves a student's answers for a given exam. It first
  verifies the existence of the student and the exam/course. If the student has not
  previously taken this specific exam for this course, it inserts a new record into
  student_exam_course. Then, it inserts the provided question IDs and their corresponding
  answers into the student_answers table. The procedure uses a transaction for atomicity
  and includes error handling.

  Parameters:

- @exam_id INT: The ID of the exam.
- @student_full_name VARCHAR(150): The full name of the student (first name and last
  name concatenated).
- @qId1 to @qId10 INT: The IDs of the questions (up to 10 questions).
- @ans1 to @ans10 VARCHAR(20): The student's answers for the corresponding questions.

  sp_correct_exam

  Description: This stored procedure calculates and returns the correction results for a
  student's performance on a specific exam. It determines the number of correct answers,
  the total number of questions, the earned grade, the total possible grade, and the
  percentage score.

  Parameters:

- @exam_id INT: The ID of the exam to be corrected.
- @student_full_name VARCHAR(255): The full name of the student whose exam is being
  corrected.

  sp_get_track_courses

  Description: This stored procedure retrieves a list of courses associated with a
  specific track. It joins the course and track_course tables to filter courses by the
  provided track ID.

  Parameters:

- @trackId INT: The ID of the track for which to retrieve associated courses.
