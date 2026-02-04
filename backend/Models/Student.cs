namespace ExamMinimalApi.Models
{
    public class Student
    {
        public int Id { get; set; }
        public string Fname { get; set; } = string.Empty;
        public string Lname { get; set; } = string.Empty;
        public string FullName => $"{Fname} {Lname}";
    }

    public class StudentValidationRequest
    {
        public string StudentFullName { get; set; } = string.Empty;
        public int TrackId { get; set; }
        public int CourseId { get; set; }
    }

    public class StudentValidationResponse
    {
        public bool IsValid { get; set; }
        public string Message { get; set; } = string.Empty;
        public StudentInfo? Student { get; set; }
    }

    public class StudentInfo
    {
        public int StudentId { get; set; }
        public string FullName { get; set; } = string.Empty;
        public int TrackId { get; set; }
        public string TrackName { get; set; } = string.Empty;
        public int CourseId { get; set; }
        public string CourseName { get; set; } = string.Empty;
    }
}