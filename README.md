# Examination System

This project is a full-stack application for managing and conducting examinations. It consists of a .NET Core backend, a React frontend, and a SQL database.

## Project Structure

- `backend/`: The .NET Core Minimal API that serves as the backend for the application.
- `frontend/`: The React application that provides the user interface.
- `db scripts/`: SQL scripts for database schema, procedures, and data seeding.
- `ERD/`: Contains the Entity-Relationship Diagram for the database.

## Backend

The backend is a .NET Core Minimal API that provides a set of endpoints for managing exams, students, courses, and tracks.

### Technologies Used

- .NET 8
- ASP.NET Core Minimal API
- Dapper
- SQL Server

### Features

- **Courses**: CRUD operations for courses.
- **Exams**: Generate exams, get exam questions, and save exam results.
- **Students**: CRUD operations for students.
- **Tracks**: CRUD operations for tracks.

### Getting Started

1. Navigate to the `backend` directory: `cd backend`
2. Restore the dependencies: `dotnet restore`
3. Run the application: `dotnet run`

The API will be running at `http://localhost:5000`.

## Frontend

The frontend is a React application that provides a user interface for setting up and taking exams.

### Technologies Used

- React
- TypeScript
- Redux Toolkit
- Vite
- shadcn-ui

### Features

- **Exam Setup**: Configure and generate new exams.
- **Take Exam**: A dedicated page for students to take an exam with a timer.
- **Results**: View exam results.

### Getting Started

1. Navigate to the `frontend` directory: `cd frontend`
2. Install the dependencies: `npm install`
3. Run the application: `npm run dev`

The application will be running at `http://localhost:5173`.

## Database Scripts

The `db scripts` directory contains all the necessary SQL scripts to set up the database.

### Scripts

- `script.sql`: The main script to create the database schema.
- `course-questions-seed.sql`: Seeds the database with initial data for courses and questions.
- `exam-procedures.sql`: Contains stored procedures related to exam management.
- `procedure.sql`: Other stored procedures.
- `test-procedure.sql`: Stored procedures for testing purposes.
- `trigger.sql`: SQL triggers.
- `dummy.sql`: Dummy data for testing.

To set up the database, execute the scripts in the following order:

1. `script.sql`
2. `procedure.sql`
3. `exam-procedures.sql`
4. `test-procedure.sql`
5. `trigger.sql`
6. `course-questions-seed.sql`
7. `dummy.sql`

## ERD

The `ERD` directory is intended to contain the Entity-Relationship Diagram of the database, which visually represents the database schema and the relationships between tables.

## Reports

This folder contains SQL Server Reporting Services (SSRS) report definition files (.rdl) for the Exam Management System. These reports provide various analytics and insights into the system's data
