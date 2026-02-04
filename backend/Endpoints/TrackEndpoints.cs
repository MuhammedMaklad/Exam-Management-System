using ExamMinimalApi.Contracts;
namespace ExamMinimalApi.Endpoints
{
    public static class TrackEndpoints
    {
        public static void MapTrackEndpoints(this IEndpointRouteBuilder app)
        {
            var group = app.MapGroup("/api/tracks");

            group.MapGet("/getTracks", async (ITrackService trackService) =>
            {
                System.Console.WriteLine("GetTracks");
                try
                {
                    return Results.Ok(await trackService.GetTracks());
                }
                catch (System.Exception)
                {
                    return Results.BadRequest(new { Error = "Something went wrong" });
                }
            })
            .WithName("GetTracks");
        }
    }
}
