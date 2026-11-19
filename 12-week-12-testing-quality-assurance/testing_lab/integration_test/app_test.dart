import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_lab/main.dart';
import 'package:testing_lab/fake_task_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete task creation flow', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskPage(repository: FakeTaskRepository()),
      ),
    );

    await tester.pumpAndSettle();

    // Check the initial page
    expect(find.text('My Tasks'), findsOneWidget);

    // Tap the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter task title
    await tester.enterText(
      find.byKey(const Key('task-title-field')),
      'Learn Flutter',
    );

    // Tap Add button
    await tester.tap(find.byKey(const Key('save-task-button')));
    await tester.pumpAndSettle();

    // Verify the task appears
    expect(find.text('Learn Flutter'), findsOneWidget);
  });
}