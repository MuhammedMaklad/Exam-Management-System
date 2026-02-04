using ExamMinimalApi.Models;

namespace ExamMinimalApi.Contracts;

public interface ICourseService
{
  Task<List<Course>> GetAllCourses();
  Task<List<Course>> GetTrackCourses(int trackId);
}
