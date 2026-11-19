import 'package:flutter_test/flutter_test.dart';
import 'package:testing_lab/task.dart';
import 'package:testing_lab/fake_task_repository.dart';

void main() {
  late FakeTaskRepository repository;

  setUp(() {
    repository = FakeTaskRepository();
  });

  group('FakeTaskRepository', () {
    test('returns empty list initially', () async {
      final tasks = await repository.getTasks();

      expect(tasks, isEmpty);
    });

    test('adds task successfully', () async {
      final task = Task(title: 'Learn Flutter');

      await repository.addTask(task);

      final tasks = await repository.getTasks();

      expect(tasks.length, 1);
      expect(tasks.first.title, 'Learn Flutter');
    });

    test('returns multiple tasks', () async {
      await repository.addTask(Task(title: 'Learn Dart'));
      await repository.addTask(Task(title: 'Learn Flutter'));

      final tasks = await repository.getTasks();

      expect(tasks.length, 2);
    });

    test('throws an error when loading tasks fails', () async {
      repository.shouldFail = true;

      await expectLater(
        repository.getTasks(),
        throwsA(isA<Exception>()),
      );
    });

    test('throws an error when adding task fails', () async {
      repository.shouldFail = true;

      await expectLater(
        repository.addTask(Task(title: 'Learn Flutter')),
        throwsA(isA<Exception>()),
      );

      repository.shouldFail = false;

      final tasks = await repository.getTasks();

      expect(tasks, isEmpty);
    });
  });
}