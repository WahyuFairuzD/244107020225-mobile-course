import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/note_repository.dart';
import '../data/sync.dart';
import '../providers/notes_provider.dart';
import 'settings_page.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync',
            onPressed: () async {
              await _syncNotes(context, ref);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: notesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  ref.read(notesProvider.notifier).reload();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(
              child: Text('No notes yet'),
            );
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];

              return ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.body.isEmpty ? 'No content' : note.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (note.dirty)
                      const Icon(
                        Icons.cloud_upload_outlined,
                        size: 20,
                      ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await ref
                            .read(notesProvider.notifier)
                            .deleteNote(note.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _syncNotes(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final syncService = SyncService(
      NoteRepository(),
    );

    try {
      final count = await syncService.sync();

      await ref.read(notesProvider.notifier).reload();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            count == 0
                ? 'No notes to sync'
                : '$count note(s) synced successfully',
          ),
        ),
      );
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sync failed: $error'),
        ),
      );
    }
  }

  Future<void> _showAddNoteDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  labelText: 'Body',
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final body = bodyController.text.trim();

                if (title.isEmpty) return;

                await ref
                    .read(notesProvider.notifier)
                    .addNote(
                      title: title,
                      body: body,
                    );

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    titleController.dispose();
    bodyController.dispose();
  }
}