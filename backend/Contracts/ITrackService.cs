using ExamMinimalApi.Models;
namespace ExamMinimalApi.Contracts;

public interface ITrackService
{
  Task<List<Track>> GetTracks();
}
