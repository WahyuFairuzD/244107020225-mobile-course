import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:week5_offline_notes/main.dart';

void main() {
  testWidgets('Offline Notes app loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: OfflineNotesApp(),
      ),
    );

    await tester.pump();

    expect(find.text('My Notes'), findsOneWidget);
  });
}