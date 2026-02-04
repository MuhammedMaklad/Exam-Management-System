namespace ExamMinimalApi.Models
{
    public class Exam
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int Duration { get; set; }
        public int CourseId { get; set; }
    }
}
