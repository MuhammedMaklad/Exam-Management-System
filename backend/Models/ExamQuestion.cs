namespace ExamMinimalApi.Models
{
    // Response model for the flattened database result
    public class ExamQuestionFlat
    {
        public int QuestionId { get; set; }
        public string QuestionText { get; set; } = string.Empty;
        public string QuestionAnswer { get; set; } = string.Empty;
        public int QuestionGrade { get; set; }
        public string ChoiceText { get; set; } = string.Empty;
    }

    // Structured response for the API
    public class ExamQuestionResponse
    {
        public int QuestionId { get; set; }
        public string QuestionText { get; set; } = string.Empty;
        public string QuestionAnswer { get; set; } = string.Empty;
        public int QuestionGrade { get; set; }
        public List<string> Choices { get; set; } = new List<string>();
    }

    // Complete exam response
    public class ExamResponse
    {
        public int ExamId { get; set; }
        public string ExamName { get; set; } = string.Empty;
        public int Duration { get; set; }
        public List<ExamQuestionResponse> Questions { get; set; } = new List<ExamQuestionResponse>();
    }
}
