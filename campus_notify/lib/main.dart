
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'data/api_client.dart';
import 'data/token_store.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/refresh_token.dart';
import 'firebase_options.dart';
import 'messaging/push_service.dart';
import 'pages/announcement_page.dart';
import 'pages/debug_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await requestNotificationPermission();
  await initLocalNotifications();

  final tokenStore = TokenStore();
  final authRepository = AuthRepositoryImpl();
  final refreshToken = RefreshToken(authRepository);

  final dio = buildApiClient(tokenStore, refreshToken);

  await initFcmToken(
    onToken: (token) async {
      await dio.post(
        '/devices',
        data: {
          'fcm_token': token,
          'platform': 'android',
        },
      );
    },
  );

  runApp(
    const ProviderScope(
      child: CampusNotifyApp(),
    ),
  );
}

class CampusNotifyApp extends ConsumerWidget {
  const CampusNotifyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      refreshListenable: _AuthRouterRefresh(ref),
      redirect: (context, state) {
        final authState = ref.read(authStateProvider);
        final loggedIn = authState.value ?? false;
        final goingLogin = state.matchedLocation == '/login';

        if (!loggedIn && !goingLogin) {
          return '/login';
        }

        if (loggedIn && goingLogin) {
          return '/';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/pengumuman/:id',
          builder: (context, state) => AnnouncementPage(
            id: state.pathParameters['id'] ?? '',
          ),
        ),
        GoRoute(
          path: '/debug',
          builder: (context, state) => const DebugPage(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Campus Notify',
      routerConfig: router,
    );
  }
}

class _AuthRouterRefresh extends ChangeNotifier {
  _AuthRouterRefresh(this.ref) {
    ref.listen(
      authStateProvider,
      (_, _) {
        notifyListeners();
      },
    );
  }

  final WidgetRef ref;
}
