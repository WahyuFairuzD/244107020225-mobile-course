
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

    expect(find.text('My Tasks'), findsOneWidget);
  });

  testWidgets('TaskPage adds a new task', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskPage(repository: FakeTaskRepository()),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Learn Flutter');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Learn Flutter'), findsOneWidget);
  });
}
