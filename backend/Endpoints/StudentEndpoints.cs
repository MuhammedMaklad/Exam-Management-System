using ExamMinimalApi.Models;
using ExamMinimalApi.Contracts;
using Microsoft.AspNetCore.Mvc;

namespace ExamMinimalApi.Endpoints
{
    public static class StudentEndpoints
    {
        public static void MapStudentEndpoints(this IEndpointRouteBuilder app)
        {
            var group = app.MapGroup("/api/students");
            
            group.MapPost("/validate", async ([FromBody] StudentValidationRequest request, IStudentService studentService) =>
            {
                try
                {
                    var result = await studentService.ValidateStudentAsync(
                        request.StudentFullName,
                        request.TrackId,
                        request.CourseId
                    );

                    if (result.IsValid)
                    {
                        return Results.Ok(result);
                    }
                    else
                    {
                        return Results.BadRequest(result);
                    }
                }
                catch (Exception ex)
                {
                    return Results.BadRequest(new { Error = ex.Message });
                }
            });
        }
    }
}
