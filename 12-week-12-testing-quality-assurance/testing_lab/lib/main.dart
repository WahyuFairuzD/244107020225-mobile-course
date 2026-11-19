
import 'package:flutter/material.dart';
import 'task.dart';
import 'fake_task_repository.dart';
import 'is_valid_task_title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing Lab',
      home: TaskPage(repository: FakeTaskRepository()),
    );
  }
}

class TaskPage extends StatefulWidget {
  final FakeTaskRepository repository;

  const TaskPage({super.key, required this.repository});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final result = await widget.repository.getTasks();
    setState(() {
      tasks = result;
    });
  }

  Future<void> addTask(String title) async {
    await widget.repository.addTask(Task(title: title));
    await loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: ListView(
        children: tasks
            .map((task) => ListTile(title: Text(task.title)))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = TextEditingController();

          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Task'),
              content: TextField(
  key: const Key('task-title-field'),
  controller: controller,
  decoration: const InputDecoration(
    hintText: 'Task title',
  ),
),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
TextButton(
  key: const Key('save-task-button'),
onPressed: () {
  if (isValidTaskTitle(controller.text)) {
    addTask(controller.text);
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task title cannot be empty'),
      ),
    );
  }
},
  child: const Text('Add'),
),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
