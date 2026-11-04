import '../local/db.dart';
import '../local/note.dart';

class NoteRepository {
  Future<List<Note>> getAll() async {
    final db = await openNotesDb();

    final rows = await db.query(
      'notes',
      orderBy: 'updated_at DESC',
    );

    return rows.map(Note.fromMap).toList();
  }

  Future<Note> insert({
    required String title,
    String body = '',
  }) async {
    final db = await openNotesDb();

    final note = Note(
      title: title,
      body: body,
      updatedAt: DateTime.now(),
      dirty: true,
    );

    final id = await db.insert(
      'notes',
      note.toMap(),
    );

    return Note(
      id: id,
      title: note.title,
      body: note.body,
      updatedAt: note.updatedAt,
      dirty: note.dirty,
    );
  }

  Future<void> update(Note note) async {
    if (note.id == null) return;

    final db = await openNotesDb();

    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await openNotesDb();

    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Note>> getDirtyNotes() async {
    final db = await openNotesDb();

    final rows = await db.query(
      'notes',
      where: 'dirty = ?',
      whereArgs: [1],
      orderBy: 'updated_at DESC',
    );

    return rows.map(Note.fromMap).toList();
  }

  Future<int> countDirty() async {
    final db = await openNotesDb();

    final result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM notes WHERE dirty = 1',
    );

    return (result.first['count'] as num).toInt();
  }

  Future<void> markAllSynced() async {
    final db = await openNotesDb();

    await db.update(
      'notes',
      {'dirty': 0},
      where: 'dirty = ?',
      whereArgs: [1],
    );
  }
}