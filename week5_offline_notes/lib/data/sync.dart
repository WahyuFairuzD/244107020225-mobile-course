import 'repositories/note_repository.dart';

class SyncService {
  final NoteRepository repository;

  SyncService(this.repository);

  Future<int> sync() async {
    // Ambil semua note yang belum tersinkronisasi.
    final dirtyNotes = await repository.getDirtyNotes();

    // Tidak ada data yang perlu disinkronisasi.
    if (dirtyNotes.isEmpty) {
      return 0;
    }

    // Simulasi proses sinkronisasi ke server.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // Anggap semua data berhasil dikirim ke server.
    await repository.markAllSynced();

    return dirtyNotes.length;
  }
}