import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week3_todo/providers/stats_provider.dart';

class FakeStatsNotifier extends StatsNotifier {
  @override
  Future<List<String>> build() async {
    return [
      'Total ToDo: 10',
      'Selesai: 6',
      'Belum selesai: 4',
    ];
  }
}

void main() {
  test('stats provider loads three statistics', () async {
    final container = ProviderContainer(
      overrides: [
        statsProvider.overrideWith(FakeStatsNotifier.new),
      ],
    );

    addTearDown(container.dispose);

    final stats = await container.read(statsProvider.future);

    expect(stats.length, 3);
    expect(stats, contains('Total ToDo: 10'));
    expect(stats, contains('Selesai: 6'));
    expect(stats, contains('Belum selesai: 4'));
  });
}