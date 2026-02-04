namespace ExamMinimalApi.Models
{
    public class GenerateExamRequest
    {
        public int CourseId { get; set; }
        public int McqQuestions { get; set; }
        public int TfQuestions { get; set; }
    }

    public class StudentAnswer
    {
        public int QuestionId { get; set; }
        public string Answer { get; set; } = string.Empty;
    }
    public class SaveStudentAnswersRequest
    {
        public string StudentFullName { get; set; } = string.Empty;
        public List<StudentAnswer> Answers { get; set; } = new List<StudentAnswer>();
    }

    public class CorrectExamRequest
    {
        public string StudentFullName { get; set; } = string.Empty;
    }
}
