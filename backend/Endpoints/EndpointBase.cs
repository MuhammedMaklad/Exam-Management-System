namespace ExamMinimalApi;

public abstract class EndpointBase
{
  protected readonly ILogger Logger;
    
    protected EndpointBase(ILogger logger)
    {
        Logger = logger;
    }
}
