using ExamMinimalApi.Models;

namespace ExamMinimalApi.Contracts
{
    public interface IStudentService
    {
        Task<StudentValidationResponse> ValidateStudentAsync(string studentFullName, int trackId, int courseId);
        Task<Student?> GetStudentByFullNameAsync(string fullName);
        Task<IEnumerable<Student>> GetAllStudentsAsync();
    }
}