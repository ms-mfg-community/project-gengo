from flask import Flask, request, jsonify
import uuid

app = Flask(__name__)

# In-memory database using a list to store to-do tasks
# Each task is a dictionary with id, title, and completed status
todos = []

@app.route('/tasks', methods=['GET'])
def get_tasks():
    """
    GET endpoint to retrieve all tasks
    Returns:
        JSON: List of all tasks
    """
    return jsonify(todos)

@app.route('/tasks', methods=['POST'])
def create_task():
    """
    POST endpoint to create a new task
    Request body should contain:
        - title: string
    Returns:
        JSON: The newly created task
    """
    data = request.get_json()
    
    if not data or 'title' not in data:
        return jsonify({'error': 'Title is required'}), 400
    
    new_task = {
        'id': str(uuid.uuid4()),  # Generate a unique ID
        'title': data['title'],
        'completed': False
    }
    
    todos.append(new_task)
    return jsonify(new_task), 201

@app.route('/tasks/<task_id>', methods=['PUT'])
def update_task(task_id):
    """
    PUT endpoint to mark a specific task as complete
    Parameters:
        task_id: string - The ID of the task to update
    Returns:
        JSON: The updated task or an error message
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
    Parameters:
        task_id: string - The ID of the task to delete
    Returns:
        JSON: Success message or an error message
    """
    # Find the index of the task with the given ID
    for index, task in enumerate(todos):
        if task['id'] == task_id:
            # Remove the task at the found index
            deleted_task = todos.pop(index)
            return jsonify({'message': f"Task '{deleted_task['title']}' deleted successfully"}), 200
    
    # If task was not found, return an error
    return jsonify({'error': 'Task not found'}), 404

# Run the application in debug mode if this file is executed directly
if __name__ == "__main__":
    app.run(debug=True)



