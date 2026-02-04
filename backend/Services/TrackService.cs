using System.Data;
using Dapper;
using ExamMinimalApi.Models;
using ExamMinimalApi.Contracts;

namespace ExamMinimalApi.Services;

public class TrackService : ITrackService
{
  private readonly IDbConnection _dbConnection;
  private readonly ILogger<TrackService> _logger;
  public TrackService(IDbConnection dbConnection, ILogger<TrackService> logger)
  {
    _dbConnection = dbConnection;
    _logger = logger;
  }
  public async Task<List<Track>> GetTracks()
  {
    var result = await _dbConnection.QueryAsync<Track>(
      "sp_track_select_all",
      commandType: CommandType.StoredProcedure
    );
    // _logger.LogInformation(result.ToList().ToString());
    return result.ToList();
  }
}
