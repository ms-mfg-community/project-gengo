# Flask API To-Do List

- 🔍 View all tasks
- ➕ Add a new task
- ✅ Mark a task as complete
- ❌ Delete a task

---

### 📁 Folder Structure

```
todo_api/
├── app.py
└── requirements.txt
```

---

### 🧱 Step-by-Step: Flask To-Do API

#### 📌 Step 1: Install Flask

If you haven’t yet:

```bash
pip install Flask
```

---

#### 📌 Step 2: `app.py` — Your API Code

```python
from flask import Flask, jsonify, request

app = Flask(__name__)

# In-memory "database" (just a list)
tasks = [
    {"id": 1, "title": "Buy groceries", "done": False},
    {"id": 2, "title": "Walk the dog", "done": False}
]

# GET all tasks
@app.route('/tasks', methods=['GET'])
def get_tasks():
    return jsonify(tasks)

# POST a new task
@app.route('/tasks', methods=['POST'])
def add_task():
    data = request.get_json()
    new_task = {
        "id": len(tasks) + 1,
        "title": data.get("title", ""),
        "done": False
    }
    tasks.append(new_task)
    return jsonify(new_task), 201

# PUT to mark task as done
@app.route('/tasks/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    for task in tasks:
        if task["id"] == task_id:
            task["done"] = True
            return jsonify(task)
    return jsonify({"error": "Task not found"}), 404

# DELETE a task
@app.route('/tasks/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    global tasks
    tasks = [t for t in tasks if t["id"] != task_id]
    return jsonify({"message": "Deleted"}), 200

if __name__ == '__main__':
    app.run(debug=True)
```

---

### 🧪 Test Your API

You can test your API with **Postman**, **cURL**, or any frontend app. Examples:

- `GET /tasks` → View tasks
- `POST /tasks` with JSON:

  ```json
  { "title": "Finish Flask API" }
  ```

- `PUT /tasks/2` → Mark task 2 as done
- `DELETE /tasks/1` → Remove task 1

---
