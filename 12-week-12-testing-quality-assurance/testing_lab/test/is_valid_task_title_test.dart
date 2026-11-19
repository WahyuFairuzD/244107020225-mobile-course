import 'package:flutter_test/flutter_test.dart';
import 'package:testing_lab/is_valid_task_title.dart';

void main() {
  group('isValidTaskTitle', () {
    test('accepts a title with text', () {
      expect(isValidTaskTitle('Learn Flutter'), isTrue);
    });

    test('rejects empty or whitespace-only text', () {
      expect(isValidTaskTitle(''), isFalse);
      expect(isValidTaskTitle('   '), isFalse);
    });

    test('accepts text with spaces around it', () {
      expect(isValidTaskTitle('   Learn Flutter   '), isTrue);
    });

    test('rejects tab and newline only', () {
      expect(isValidTaskTitle('\t\n'), isFalse);
    });
  });
}