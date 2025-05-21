from flask import Flask, request, jsonify
import uuid

# Initialize the Flask application
app = Flask(__name__)

# In-memory database using a list to store to-do tasks
# Each task is a dictionary with the following structure:
# {
#    'id': string (UUID),
#    'title': string,
#    'completed': boolean
# }
todos = []

@app.route('/tasks', methods=['GET'])
def get_tasks():
    """
    GET endpoint to retrieve all tasks
    
    This endpoint returns the complete list of all tasks currently stored
    in the in-memory database.
    
    Returns:
        JSON: List of all tasks with their ID, title, and completion status
    """
    return jsonify(todos)

@app.route('/tasks', methods=['POST'])
def create_task():
    """
    POST endpoint to create a new task
    
    This endpoint accepts a JSON payload and creates a new task in the 
    in-memory database. The task is automatically assigned a UUID and 
    marked as not completed by default.
    
    Request body should contain:
        - title: string - The title/description of the task
        
    Returns:
        JSON: The newly created task with ID, title, and completed status
        Status code: 201 (Created) on success, 400 (Bad Request) if title is missing
    """
    # Parse the incoming JSON data
    data = request.get_json()
    
    # Validate that the request contains a title
    if not data or 'title' not in data:
        return jsonify({'error': 'Title is required'}), 400
    
    # Create a new task object with a unique ID
    new_task = {
        'id': str(uuid.uuid4()),  # Generate a unique ID using UUID4
        'title': data['title'],
        'completed': False  # New tasks are always marked as not completed
    }
    
    # Add the new task to our in-memory database
    todos.append(new_task)
    return jsonify(new_task), 201

@app.route('/tasks/<task_id>', methods=['PUT'])
def update_task(task_id):
    """
    PUT endpoint to mark a specific task as complete
    
    This endpoint finds a task by its ID and updates its completion status
    to True. The task ID is provided as a URL parameter.
    
    Parameters:
        task_id: string - The UUID of the task to update
        
    Returns:
        JSON: The updated task with completed status set to True
        Status code: 200 (OK) on success, 404 (Not Found) if task doesn't exist
    """
    # Find the task with the given ID
    for task in todos:
        if task['id'] == task_id:
            task['completed'] = True
            return jsonify(task)
    
    # If task was not found, return an error
    return jsonify({'error': 'Task not found'}), 404

@app.route('/tasks/<task_id>', methods=['DELETE'])
def delete_task(task_id):
    """
    DELETE endpoint to remove a specific task from the list
    
    This endpoint removes a task from the in-memory database
    by its ID. The task ID is provided as a URL parameter.
    
    Parameters:
        task_id: string - The UUID of the task to delete
        
    Returns:
        JSON: Success message containing the title of the deleted task
        Status code: 200 (OK) on success, 404 (Not Found) if task doesn't exist
    """
    # Find the index of the task with the given ID
    for index, task in enumerate(todos):
        if task['id'] == task_id:
            # Remove the task at the found index and store it for the response message
            deleted_task = todos.pop(index)
            return jsonify({'message': f"Task '{deleted_task['title']}' deleted successfully"}), 200
    
    # If task was not found, return an error
    return jsonify({'error': 'Task not found'}), 404

# Run the application in debug mode if this file is executed directly
# Debug mode enables auto-reload when code changes and provides detailed error messages
if __name__ == "__main__":
    app.run(debug=True)



