import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/prefs.dart';

final prefsRepositoryProvider = Provider<PrefsRepository>(
  (ref) => PrefsRepository(),
);

final darkModeProvider =
    AsyncNotifierProvider<DarkModeNotifier, bool>(
  DarkModeNotifier.new,
);

class DarkModeNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return ref
        .read(prefsRepositoryProvider)
        .getDarkMode();
  }

  Future<void> toggle() async {
    final current = state.value ?? false;
    final next = !current;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(prefsRepositoryProvider)
          .setDarkMode(next);

      return next;
    });
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final darkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: darkMode.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        data: (enabled) {
          return SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text(
              'Save this setting locally',
            ),
            value: enabled,
            onChanged: (_) {
              ref
                  .read(darkModeProvider.notifier)
                  .toggle();
            },
          );
        },
      ),
    );
  }
}