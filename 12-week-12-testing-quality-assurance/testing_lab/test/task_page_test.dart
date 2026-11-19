
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_lab/main.dart';
import 'package:testing_lab/fake_task_repository.dart';

void main() {
  testWidgets('TaskPage displays My Tasks title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskPage(repository: FakeTaskRepository()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('My Tasks'), findsOneWidget);
  });

  testWidgets('TaskPage displays empty task list initially', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskPage(repository: FakeTaskRepository()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('TaskPage adds a new task', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskPage(repository: FakeTaskRepository()),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('task-title-field')),
      'Learn Flutter',
    );

    await tester.tap(find.byKey(const Key('save-task-button')));
    await tester.pumpAndSettle();

    expect(find.text('Learn Flutter'), findsOneWidget);
  });

  testWidgets('TaskPage rejects empty task title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskPage(repository: FakeTaskRepository()),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('task-title-field')),
      '   ',
    );

    await tester.tap(find.byKey(const Key('save-task-button')));
    await tester.pumpAndSettle();

expect(find.text('Task title cannot be empty'), findsOneWidget);
expect(find.text('Add Task'), findsOneWidget);
expect(find.byType(ListTile), findsNothing);
  });
}
