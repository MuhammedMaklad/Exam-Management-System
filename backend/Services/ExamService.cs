using Dapper;
using ExamMinimalApi.Contracts;
using ExamMinimalApi.Models;
using System.Data;

namespace ExamMinimalApi.Services
{
    public class ExamService : IExamService
    {
        private readonly IDbConnection _dbConnection;

        public ExamService(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<int> GenerateExamAsync(int courseId, int mcqQuestions, int tfQuestions)
        {
            System.Console.WriteLine($"course-id {courseId}, mcqQuestion {mcqQuestions}, tfQuestions {tfQuestions}");
            var parameters = new DynamicParameters();
            parameters.Add("@course_id", courseId);
            parameters.Add("@mcq_questions", mcqQuestions);
            parameters.Add("@tf_questions", tfQuestions);

            await _dbConnection.ExecuteAsync(
                "sp_generate_exam_v2",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            var examId = await _dbConnection.QueryFirstOrDefaultAsync<int>(
                "SELECT TOP 1 id FROM exam WHERE courseId = @courseId ORDER BY id DESC",
                new { courseId }
            );

            return examId;
        }

         public async Task<ExamResponse?> GetExamAsync(int courseId)
        {
            var examId = await _dbConnection.QueryFirstOrDefaultAsync<int>(
                @"SELECT TOP 1 id 
                FROM exam 
                WHERE courseId = @courseId 
                ORDER BY id DESC",
                new { courseId }
            );

            if (examId == null)
                return null;

            // Get exam details
            var examInfo = await _dbConnection.QueryFirstOrDefaultAsync<Exam>(
                "SELECT id, name, duration, courseId FROM exam WHERE id = @examId",
                new { examId }
            );

            if (examInfo == null)
                return null;

            // Get questions with choices (flattened)
            var parameters = new DynamicParameters();
            parameters.Add("@exam_id", examId);

            var flatQuestions = await _dbConnection.QueryAsync<ExamQuestionFlat>(
                "sp_get_exam",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            // Group by question and aggregate choices
            var groupedQuestions = flatQuestions
                .GroupBy(q => new
                {
                    q.QuestionId,
                    q.QuestionText,
                    q.QuestionAnswer,
                    q.QuestionGrade
                })
                .Select(g => new ExamQuestionResponse
                {
                    QuestionId = g.Key.QuestionId,
                    QuestionText = g.Key.QuestionText,
                    QuestionAnswer = g.Key.QuestionAnswer,
                    QuestionGrade = g.Key.QuestionGrade,
                    Choices = g.Select(x => x.ChoiceText).ToList()
                })
                .ToList();

            return new ExamResponse
            {
                ExamId = examInfo.Id,
                ExamName = examInfo.Name,
                Duration = examInfo.Duration,
                Questions = groupedQuestions
            };
        }

        public async Task SaveStudentAnswersAsync(int examId, string studentFullName, List<StudentAnswer> answers)
        {
            while (answers.Count < 10)
            {
                answers.Add(new StudentAnswer { QuestionId = 0, Answer = string.Empty });
            }

            var answersToSave = answers.Take(10).ToList();

            var parameters = new DynamicParameters();
            parameters.Add("@exam_id", examId);
            parameters.Add("@student_full_name", studentFullName);
            
            // Add question IDs and answers
            parameters.Add("@qId1", answersToSave[0].QuestionId);
            parameters.Add("@ans1", answersToSave[0].Answer);
            
            parameters.Add("@qId2", answersToSave[1].QuestionId);
            parameters.Add("@ans2", answersToSave[1].Answer);
            
            parameters.Add("@qId3", answersToSave[2].QuestionId);
            parameters.Add("@ans3", answersToSave[2].Answer);
            
            parameters.Add("@qId4", answersToSave[3].QuestionId);
            parameters.Add("@ans4", answersToSave[3].Answer);
            
            parameters.Add("@qId5", answersToSave[4].QuestionId);
            parameters.Add("@ans5", answersToSave[4].Answer);
            
            parameters.Add("@qId6", answersToSave[5].QuestionId);
            parameters.Add("@ans6", answersToSave[5].Answer);
            
            parameters.Add("@qId7", answersToSave[6].QuestionId);
            parameters.Add("@ans7", answersToSave[6].Answer);
            
            parameters.Add("@qId8", answersToSave[7].QuestionId);
            parameters.Add("@ans8", answersToSave[7].Answer);
            
            parameters.Add("@qId9", answersToSave[8].QuestionId);
            parameters.Add("@ans9", answersToSave[8].Answer);
            
            parameters.Add("@qId10", answersToSave[9].QuestionId);
            parameters.Add("@ans10", answersToSave[9].Answer);

            await _dbConnection.ExecuteAsync(
                "sp_save_student_answers",
                parameters,
                commandType: CommandType.StoredProcedure
            );
        }
        public async Task<ExamResult?> CorrectExamAsync(int examId, string studentFullName)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@exam_id", examId);
            parameters.Add("@student_full_name", studentFullName);

            var result = await _dbConnection.QueryFirstOrDefaultAsync<ExamResult>(
                "sp_correct_exam",
                parameters,
                commandType: CommandType.StoredProcedure
            );

            return result;
        }

        public async Task<IEnumerable<Exam>> GetAllExamsAsync()
        {
            var sql = "SELECT id, name, duration, courseId FROM exam";
            var exams = await _dbConnection.QueryAsync<Exam>(sql);
            return exams;
        }
    }
}