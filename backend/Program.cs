using ExamMinimalApi.Models;
using ExamMinimalApi.Services;
using ExamMinimalApi;
using ExamMinimalApi.Endpoints;
using ExamMinimalApi.Contracts;
using Microsoft.Data.SqlClient;
using System.Data;
using Microsoft.AspNetCore.Http.HttpResults;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Register database connection
builder.Services.AddScoped<IDbConnection>(sp =>
    new SqlConnection(builder.Configuration.GetConnectionString("DefaultConnection")));

// Register services
builder.Services.AddScoped<IExamService, ExamService>();
builder.Services.AddScoped<ITrackService, TrackService>();
builder.Services.AddScoped<ICourseService, CourseService>();
builder.Services.AddScoped<IStudentService, StudentService>();


// Add CORS if needed
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy => policy.AllowAnyOrigin()
                       .AllowAnyMethod()
                       .AllowAnyHeader());
});

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");

// Middlewares
app.UseMiddleware<RequestLoggingMiddleware>();

// TeST Work
app.MapGet("/", () => { return Results.Ok("MUhammed on da code"); });

// API Endpoints
app.MapTrackEndpoints();
app.MapCourseEndpoints();
app.MapStudentEndpoints();
app.MapExamEndpoints();

app.Run();