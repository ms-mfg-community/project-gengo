# Python Flask To-Do List API - Prompts

This document contains prompts to guide you through creating a simple Flask API for managing a to-do list.

## Setup and Initial Configuration

1. **Project Setup**: Create a project folder structure for a Flask API to manage a to-do list application with GET, POST, PUT, and DELETE endpoints. Use this hierarchy and names at the path: C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\python\workspace
todo_api/
├── app.py
└── requirements.txt

2. **Dependencies**: Create a requirements.txt file with the necessary dependencies for a Flask API project.

## Basic Flask Application Setup

3. **Create Basic Flask App**: Create a basic Flask application with a simple route that returns "Hello, World!" to ensure everything is working properly.

4. **In-Memory Database**: Create an in-memory "database" using a Python list to store to-do tasks with fields for id, title, and completion status.

## API Endpoints Implementation

5. **GET Endpoint**: Implement a GET endpoint at '/tasks' that returns all tasks in JSON format.

6. **POST Endpoint**: Create a POST endpoint at '/tasks' that adds a new task to the list with a unique ID and sets the completion status to False by default.

7. **PUT Endpoint**: Implement a PUT endpoint at '/tasks/<task_id>' that marks a specific task as complete.

8. **DELETE Endpoint**: Create a DELETE endpoint at '/tasks/<task_id>' that removes a specific task from the list.

## Testing and Enhancement

9. **Run and Test**: Run the Flask application in debug mode and test each endpoint using tools like Postman, cURL, or a web browser.

10. **Error Handling**: Add error handling to all endpoints to manage cases like task not found, invalid input, etc.

11. **Enhance Task Update**: Extend the PUT endpoint to allow updating the task title as well as the completion status.

## Advanced Features (Optional)

12. **Task Filtering**: Add query parameter support to the GET endpoint to filter tasks by completion status.

13. **Task Sorting**: Implement sorting functionality for the tasks list by creation date or alphabetically by title.

14. **Persistent Storage**: Modify the application to use a SQLite database instead of an in-memory list for persistent storage.

15. **API Authentication**: Add basic authentication to secure the API endpoints.

## Sample Data for Testing

```json
[
  {"id": 1, "title": "Buy groceries", "done": false},
  {"id": 2, "title": "Walk the dog", "done": false},
  {"id": 3, "title": "Finish Flask API project", "done": false}
]
```

## Example cURL Commands for Testing

```bash
# Get all tasks
curl -X GET http://localhost:5000/tasks

# Add a new task
curl -X POST http://localhost:5000/tasks -H "Content-Type: application/json" -d '{"title": "Learn Flask"}'

# Mark a task as complete
curl -X PUT http://localhost:5000/tasks/1

# Delete a task
curl -X DELETE http://localhost:5000/tasks/2
```