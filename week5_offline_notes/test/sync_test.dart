import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:week5_offline_notes/data/local/db.dart';
import 'package:week5_offline_notes/data/repositories/note_repository.dart';
import 'package:week5_offline_notes/data/sync.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late NoteRepository repository;
  late SyncService syncService;

  setUp(() async {
    final db = await openNotesDb();

    await db.delete('notes');

    repository = NoteRepository();
    syncService = SyncService(repository);
  });

  tearDown(() async {
    final db = await openNotesDb();

    await db.delete('notes');
    await db.close();
  });

  group('SyncService', () {
    test('sync returns zero when there are no dirty notes', () async {
      final result = await syncService.sync();

      expect(result, 0);

      final dirtyNotes = await repository.getDirtyNotes();

      expect(dirtyNotes, isEmpty);
    });

    test('sync marks dirty notes as synced', () async {
      final note = await repository.insert(
        title: 'Test Note',
        body: 'Offline note',
      );

      expect(note.id, isNotNull);
      expect(note.dirty, isTrue);

      final dirtyBeforeSync = await repository.getDirtyNotes();

      expect(dirtyBeforeSync.length, 1);
      expect(dirtyBeforeSync.first.id, note.id);
      expect(dirtyBeforeSync.first.dirty, isTrue);

      final result = await syncService.sync();

      expect(result, 1);

      final dirtyAfterSync = await repository.getDirtyNotes();

      expect(dirtyAfterSync, isEmpty);

      final allNotes = await repository.getAll();

      expect(allNotes.length, 1);
      expect(allNotes.first.id, note.id);
      expect(allNotes.first.dirty, isFalse);
    });
  });
}