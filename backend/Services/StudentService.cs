using Dapper;
using ExamMinimalApi.Models;
using ExamMinimalApi.Contracts;
using System.Data;

namespace ExamMinimalApi.Services
{
    public class StudentService : IStudentService
    {
        private readonly IDbConnection _dbConnection;

        public StudentService(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<StudentValidationResponse> ValidateStudentAsync(string studentFullName, int trackId, int courseId)
        {
            // Check if student exists
            var student = await GetStudentByFullNameAsync(studentFullName);
            
            if (student == null)
            {
                return new StudentValidationResponse
                {
                    IsValid = false,
                    Message = "Student not found in the system"
                };
            }

            // !Check if student is enrolled in the track
            var isInTrack = await _dbConnection.QueryFirstOrDefaultAsync<int?>(
                @"SELECT COUNT(*) 
                  FROM student
                  WHERE id = @studentId AND trackId = @trackId",
                new { studentId = student.Id, trackId }
            );

            if (isInTrack == 0 || isInTrack == null)
            {
                return new StudentValidationResponse
                {
                    IsValid = false,
                    Message = "Student is not enrolled in this track"
                };
            }

            // !Check if the course belongs to the track
            var courseTrack = await _dbConnection.QueryFirstOrDefaultAsync<dynamic>(
                @"SELECT tc.trackId, t.name as TrackName, c.name as CourseName
                  FROM track_course tc
                  INNER JOIN track t ON tc.trackId = t.id
                  INNER JOIN course c ON tc.courseId = c.id
                  WHERE tc.courseId = @courseId AND tc.trackId = @trackId",
                new { courseId, trackId }
            );

            if (courseTrack == null)
            {
                return new StudentValidationResponse
                {
                    IsValid = false,
                    Message = "Course does not belong to this track"
                };
            }

            // ?Check if student is enrolled in the course
            var isInCourse = await _dbConnection.QueryFirstOrDefaultAsync<int?>(
                @"SELECT COUNT(*) 
                  FROM student_course 
                  WHERE stdId = @studentId AND courseId = @courseId",
                new { studentId = student.Id, courseId }
            );

            if (isInCourse == 0 || isInCourse == null)
            {
                return new StudentValidationResponse
                {
                    IsValid = false,
                    Message = "Student is not enrolled in this course"
                };
            }

            return new StudentValidationResponse
            {
                IsValid = true,
                Message = "Student is valid for this track and course",
                Student = new StudentInfo
                {
                    StudentId = student.Id,
                    FullName = studentFullName,
                    TrackId = trackId,
                    TrackName = courseTrack.TrackName,
                    CourseId = courseId,
                    CourseName = courseTrack.CourseName
                }
            };
        }

        public async Task<Student?> GetStudentByFullNameAsync(string fullName)
        {
            var sql = @"SELECT id, fname, lname 
                       FROM student 
                       WHERE CONCAT(fname, ' ', lname) = @fullName";
            
            var student = await _dbConnection.QueryFirstOrDefaultAsync<Student>(sql, new { fullName });
            return student;
        }

        public async Task<IEnumerable<Student>> GetAllStudentsAsync()
        {
            var sql = "SELECT id, fname, lname FROM student";
            var students = await _dbConnection.QueryAsync<Student>(sql);
            return students;
        }
    }
}