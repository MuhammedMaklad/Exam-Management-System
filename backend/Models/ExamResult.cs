namespace ExamMinimalApi.Models
{
    public class ExamResult
    {
        public int StudentId { get; set; }
        public int ExamId { get; set; }
        public int CorrectAnswers { get; set; }
        public int TotalQuestions { get; set; }
        public int Percentage { get; set; }
    }
}
