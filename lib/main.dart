import 'package:flutter/material.dart';

// Main entry point to run the app
void main() {
  runApp(TaskManagerApp());
}

// Task class that holds the task data (name and completion status)
class Task {
  String name; // Task name
  bool isCompleted; // Task completion status

  Task({required this.name, this.isCompleted = false});
}

// Main screen for managing tasks
class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key}); // Constructor for TaskListScreen

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

// State class for TaskListScreen where the task list logic is handled
class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = []; // List to store tasks
  final TextEditingController _controller =
      TextEditingController(); // Controller for text input field

  // Method to add a task when the "Add" button is clicked
  void _addTask() {
    if (_controller.text.isNotEmpty) {
      // Ensure the input field is not empty
      setState(() {
        // Add new task to the list and clear the input field
        _tasks.add(Task(name: _controller.text));
        _controller.clear();
      });
    }
  }

  // Method to toggle a task's completion status (checked/unchecked)
  void _toggleTaskCompletion(int index) {
    setState(() {
      // Toggle the isCompleted flag for the task at the given index
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  // Method to delete a task from the list
  void _deleteTask(int index) {
    setState(() {
      // Remove the task at the specified index
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')), // App bar with the title
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Expanded widget to take available space for text input
                Expanded(
                  child: TextField(
                    controller:
                        _controller, // Link the controller to the text field
                    decoration: InputDecoration(
                        labelText: 'Enter task'), // Placeholder text for input
                  ),
                ),
                // Button to add the task to the list
                ElevatedButton(
                  onPressed:
                      _addTask, // Call _addTask() when the button is pressed
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          // Expanded widget to take available space for the task list
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length, // Number of items in the task list
              itemBuilder: (context, index) {
                // Create ListTile for each task
                return ListTile(
                  leading: Checkbox(
                    value:
                        _tasks[index].isCompleted, // Check if task is completed
                    onChanged: (bool? value) {
                      // Toggle task completion status when checkbox is clicked
                      _toggleTaskCompletion(index);
                    },
                  ),
                  title: Text(
                    _tasks[index].name,
                    style: TextStyle(
                      // Apply line-through style if the task is completed
                      decoration: _tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red), // Delete icon
                    onPressed: () {
                      // Call _deleteTask() to remove the task from the list
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Root widget that wraps the whole app and sets up theme and title
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager', // App title
      theme: ThemeData(primarySwatch: Colors.blue), // App theme color
      home: TaskListScreen(), // Home screen of the app
    );
  }
}
