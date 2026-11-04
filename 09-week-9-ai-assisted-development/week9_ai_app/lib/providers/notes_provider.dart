import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/note.dart';
import '../data/repositories/note_repository.dart';

final noteRepositoryProvider = Provider<NoteRepository>(
  (ref) => NoteRepository(),
);

final notesProvider =
    AsyncNotifierProvider<NotesNotifier, List<Note>>(
  NotesNotifier.new,
);

class NotesNotifier extends AsyncNotifier<List<Note>> {
  NoteRepository get repository =>
      ref.read(noteRepositoryProvider);

  @override
  Future<List<Note>> build() async {
    return repository.getAll();
  }

  Future<void> addNote({
    required String title,
    String body = '',
  }) async {
    await repository.insert(
      title: title,
      body: body,
    );

    state = AsyncData(
      await repository.getAll(),
    );
  }

  Future<void> updateNote(Note note) async {
    await repository.update(note);

    state = AsyncData(
      await repository.getAll(),
    );
  }

  Future<void> deleteNote(int id) async {
    await repository.delete(id);

    state = AsyncData(
      await repository.getAll(),
    );
  }

  Future<void> reload() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      repository.getAll,
    );
  }
}