
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Search filters notes case-insensitively', () {
    final notes = [
      'Belajar Flutter',
      'Tugas Mobile',
      'Flutter Advanced',
    ];

    const query = 'flutter';

    final filteredNotes = notes.where(
      (title) => title.toLowerCase().contains(query),
    ).toList();

    expect(filteredNotes, [
      'Belajar Flutter',
      'Flutter Advanced',
    ]);
  });

  test('Search returns empty result when no notes match', () {
    final notes = [
      'Belajar Flutter',
      'Tugas Mobile',
    ];

    const query = 'xyz';

    final filteredNotes = notes.where(
      (title) => title.toLowerCase().contains(query),
    ).toList();

    expect(filteredNotes, isEmpty);
  });
}
