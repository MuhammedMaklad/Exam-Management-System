using ExamMinimalApi.Models;

namespace ExamMinimalApi.Contracts
{
    public interface IExamService
    {
        Task<int> GenerateExamAsync(int courseId, int mcqQuestions, int tfQuestions);
        Task<ExamResponse?> GetExamAsync(int examId);
        Task SaveStudentAnswersAsync(int examId, string studentFullName, List<StudentAnswer> answers);

        Task<ExamResult?> CorrectExamAsync(int examId, string studentFullName);
        Task<IEnumerable<Exam>> GetAllExamsAsync();
    }
}
