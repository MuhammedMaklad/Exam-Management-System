using ExamMinimalApi.Contracts;
namespace ExamMinimalApi.Endpoints
{
    public static class CourseEndpoints
    {
        public static void MapCourseEndpoints(this IEndpointRouteBuilder app)
        {
            var group = app.MapGroup("/api/courses");

            group.MapGet("/getCourses", async (ICourseService courseService) =>
            {
                try
                {
                    return Results.Ok(await courseService.GetAllCourses());
                }
                catch (Exception)
                {
                    return Results.BadRequest(new { Error = "Something went wrong" });
                }
            })
            .WithName("GetCourses");

            group.MapGet("/getTrackCourses/{trackId:int}", async (int trackId, ICourseService courseService) =>
            {
                try
                {
                    return Results.Ok(await courseService.GetTrackCourses(trackId));
                }
                catch (Exception)
                {
                    
                    throw;
                }
            }).WithName("GetTrackCourses");
        }
    }
}
