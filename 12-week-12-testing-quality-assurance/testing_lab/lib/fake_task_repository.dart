import 'task.dart';
import 'task_repository.dart';

class FakeTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  bool shouldFail = false;

  @override
  Future<List<Task>> getTasks() async {
    if (shouldFail) {
      throw Exception('Failed to load tasks');
    }

    return List.from(_tasks);
  }

  @override
  Future<void> addTask(Task task) async {
    if (shouldFail) {
      throw Exception('Failed to add task');
    }

    _tasks.add(task);
  }
}