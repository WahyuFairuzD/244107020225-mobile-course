
import 'task.dart';
import 'task_repository.dart';

class FakeTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];

  @override
  Future<List<Task>> getTasks() async {
    return List.from(_tasks);
  }

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }
}
