using ExamMinimalApi.Models;
using ExamMinimalApi.Contracts;

namespace ExamMinimalApi.Endpoints
{
    public static class ExamEndpoints
    {
        public static void MapExamEndpoints(this IEndpointRouteBuilder app)
        {
            var group = app.MapGroup("/api/exams");

            group.MapGet("/", async (IExamService examService) =>
            {
                try
                {
                    var exams = await examService.GetAllExamsAsync();
                    return Results.Ok(exams);
                }
                catch (Exception ex)
                {
                    return Results.BadRequest(new { Error = ex.Message });
                }
            })
            .WithName("GetAllExams");

            
            group.MapPost("/generate", async (GenerateExamRequest request, IExamService examService) =>
            {
                try
                {
                    var examId = await examService.GenerateExamAsync(request.CourseId, request.McqQuestions, request.TfQuestions);
                    return Results.Ok(new { ExamId = examId, Message = "Exam generated successfully" });
                }
                catch (Exception ex)
                {
                    return Results.BadRequest(new { Error = ex.Message });
                }
            })
            .WithName("GenerateExam");

            group.MapGet("/{courseId}", async (int courseId, IExamService examService) =>
            {
                try
                {
                    var exam = await examService.GetExamAsync(courseId);
                    if (exam == null)
                    {
                        return Results.NotFound(new { Error = "Exam not found" });
                    }
                    return Results.Ok(exam);
                }
                catch (Exception ex)
                {
                    return Results.BadRequest(new { Error = ex.Message });
                }
            })
            .WithName("GetExam");

            group.MapPost("/{examId}/answers", async (int examId, SaveStudentAnswersRequest request, IExamService examService) =>
            {
                try
                {
                    System.Console.WriteLine(request.Answers.Count);
                    await examService.SaveStudentAnswersAsync(examId, request.StudentFullName, request.Answers);
                    return Results.Ok(new { Message = "Answers saved successfully" });
                }
                catch (Exception ex)
                {
                    System.Console.WriteLine(ex);
                    return Results.BadRequest(new { Error = ex.Message });
                }
            })
            .WithName("SaveStudentAnswers");

            group.MapPost("/{examId}/correct", async (int examId, CorrectExamRequest request, IExamService examService) =>
            {
                try
                {
                    var result = await examService.CorrectExamAsync(examId, request.StudentFullName);
                    if (result == null)
                    {
                        return Results.NotFound(new { Error = "Exam or student not found" });
                    }
                    return Results.Ok(result);
                }
                catch (Exception ex)
                {
                    return Results.BadRequest(new { Error = ex.Message });
                }
            })
            .WithName("CorrectExam");

        }
    }
}
