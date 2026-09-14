import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulate a 30% chance of failure.
    if (Random().nextDouble() < 0.3) {
      throw Exception('Gagal memuat statistik');
    }

    return ['Total ToDo: 10', 'Selesai: 6', 'Belum selesai: 4'];
  }

  Future<void> retry() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a 30% chance of failure.
      if (Random().nextDouble() < 0.3) {
        throw Exception('Gagal memuat statistik');
      }

      return ['Total ToDo: 10', 'Selesai: 6', 'Belum selesai: 4'];
    });
  }
}

final statsProvider =
    AsyncNotifierProvider<StatsNotifier, List<String>>(StatsNotifier.new);