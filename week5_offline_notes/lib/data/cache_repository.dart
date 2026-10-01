import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'local/db.dart';

class CacheRepository {
  Future<List<Map<String, dynamic>>> getCachedPosts() async {
    final db = await openNotesDb();

    final rows = await db.query(
      'cached_posts',
      orderBy: 'cached_at DESC',
    );

    return rows.map((row) {
      return jsonDecode(
        row['payload'] as String,
      ) as Map<String, dynamic>;
    }).toList();
  }

  Future<void> savePosts(
    List<Map<String, dynamic>> posts,
  ) async {
    final db = await openNotesDb();

    final batch = db.batch();

    for (final post in posts) {
      batch.insert(
        'cached_posts',
        {
          'id': post['id'],
          'payload': jsonEncode(post),
          'cached_at': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> clearCache() async {
    final db = await openNotesDb();

    await db.delete('cached_posts');
  }
}