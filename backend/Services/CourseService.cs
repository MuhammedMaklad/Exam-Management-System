using System.Data;
using Dapper;
using ExamMinimalApi.Contracts;
using ExamMinimalApi.Models;
namespace ExamMinimalApi.Services;

public class CourseService : ICourseService
{
  private readonly IDbConnection _dbConnection;

  public CourseService(IDbConnection dbConnection)
  {
    _dbConnection = dbConnection;
  }
  public async Task<List<Course>> GetAllCourses()
  {
    var result = await _dbConnection.QueryAsync<Course>(
      "sp_course_select_all",
      commandType: CommandType.StoredProcedure
    );
    return result.ToList();
  }

  public  async Task<List<Course>> GetTrackCourses(int trackId)
  {
    var result = await _dbConnection.QueryAsync<Course>(
      "sp_get_track_courses",
      new { trackId },
      commandType: CommandType.StoredProcedure
    );
    return result.ToList();
  }
}
