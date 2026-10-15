
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'route_message.dart';

final _local = FlutterLocalNotificationsPlugin();

final ValueNotifier<String?> fcmTokenNotifier =
    ValueNotifier<String?>(null);

String? pendingDeepLink;
void Function(String route)? _navigate;

StreamSubscription<String>? _tokenSub;

const _topic = 'pengumuman-kampus';

/// Meminta izin notifikasi.
/// Untuk Web, proses ini dilewati sementara.
Future<bool> requestNotificationPermission() async {
  if (kIsWeb) return false;

  final settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    announcement: false,
    carPlay: false,
    criticalAlert: false,
  );

  return settings.authorizationStatus ==
          AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional;
}

/// Inisialisasi notifikasi lokal untuk Android dan iOS.
Future<void> initLocalNotifications() async {
  if (kIsWeb) return;

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const ios = DarwinInitializationSettings();

  await _local.initialize(
    settings: const InitializationSettings(
      android: android,
      iOS: ios,
    ),
    onDidReceiveNotificationResponse: (response) {
      final payload = response.payload;

      if (payload == null || payload.isEmpty) return;

      final route = routeFromMessage({'route': payload});

      if (_navigate != null) {
        _navigate!(route);
      } else {
        pendingDeepLink = route;
      }
    },
  );
}

/// Mengambil FCM token dan berlangganan topic.
/// Sementara ini hanya berjalan di Android/iOS.
Future<void> initFcmToken({
  required Future<void> Function(String token) onToken,
}) async {
  if (kIsWeb) return;

  final token = await FirebaseMessaging.instance.getToken();

  if (token != null) {
    fcmTokenNotifier.value = token;
    await onToken(token);
  }

  await _tokenSub?.cancel();

  _tokenSub = FirebaseMessaging.instance.onTokenRefresh.listen(
    (token) async {
      fcmTokenNotifier.value = token;
      await onToken(token);
    },
  );

  await FirebaseMessaging.instance.subscribeToTopic(_topic);
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  debugPrint('BG message: ${message.messageId}');
}

/// Mendaftarkan handler untuk pesan saat aplikasi berada di background.
void registerBackgroundHandler() {
  if (kIsWeb) return;

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
}

/// Mendengarkan pesan saat aplikasi sedang terbuka.
void listenForeground(void Function(String route) go) {
  _navigate = go;

  if (kIsWeb) return;

  FirebaseMessaging.onMessage.listen((message) async {
    final route = routeFromMessage(message.data);

    const androidDetails = AndroidNotificationDetails(
      'pengumuman',
      'Pengumuman Kampus',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _local.show(
      id: message.hashCode,
      title: message.notification?.title ?? 'Pengumuman',
      body: message.notification?.body ?? '',
      notificationDetails: const NotificationDetails(
        android: androidDetails,
      ),
      payload: route,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    go(routeFromMessage(message.data));
  });
}

/// Menangani pesan yang membuka kembali aplikasi.
Future<void> handleTerminated(
  void Function(String route) go,
) async {
  if (!kIsWeb) {
    final initial =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initial != null) {
      go(routeFromMessage(initial.data));
    }
  }

  if (pendingDeepLink != null) {
    go(pendingDeepLink!);
    pendingDeepLink = null;
  }
}

/// Berlangganan topic pengumuman kampus.
Future<void> subscribeCampusTopic() async {
  if (kIsWeb) return;

  await FirebaseMessaging.instance.subscribeToTopic(_topic);
}

/// Berhenti berlangganan topic pengumuman kampus.
Future<void> unsubscribeCampusTopic() async {
  if (kIsWeb) return;

  await FirebaseMessaging.instance.unsubscribeFromTopic(_topic);
}