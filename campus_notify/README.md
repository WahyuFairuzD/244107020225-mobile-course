# Campus Notify

Campus Notify merupakan aplikasi Flutter yang dibuat untuk **Mobile Programming Week 6** dengan materi **Authentication, Security & Firebase Cloud Messaging (FCM)**.

Praktikum ini berfokus pada penerapan authentication, penyimpanan token secara aman, token refresh, integrasi Firebase, Firebase Cloud Messaging, serta pengujian push notification pada perangkat Android.

---

## 1. Tujuan Praktikum

Tujuan dari praktikum ini adalah mempelajari dan menerapkan:

- Authentication pada aplikasi Flutter.
- Penyimpanan access token dan refresh token secara aman.
- Penggunaan `flutter_secure_storage`.
- Penggunaan Dio sebagai HTTP client.
- Implementasi token refresh menggunakan Dio interceptor.
- Integrasi Firebase pada aplikasi Flutter.
- Firebase Cloud Messaging (FCM).
- Notification permission.
- Pengambilan dan pengelolaan FCM token.
- `onTokenRefresh` untuk menangani perubahan token.
- Subscription FCM topic.
- Local notification.
- Pengujian push notification menggunakan Firebase Console.

---

## 2. Teknologi yang Digunakan

| Teknologi | Penggunaan |
|---|---|
| Flutter | Framework aplikasi |
| Dart | Bahasa pemrograman |
| Riverpod | State management |
| GoRouter | Routing aplikasi |
| Dio | HTTP client |
| Flutter Secure Storage | Penyimpanan token |
| Firebase Core | Inisialisasi Firebase |
| Firebase Messaging | Push notification |
| Flutter Local Notifications | Local notification |

---

## 3. Struktur Project

Struktur utama project:

```text
campus_notify/
├── android/
│   └── app/
│       └── google-services.json
├── lib/
│   ├── main.dart
│   ├── data/
│   │   ├── api_client.dart
│   │   ├── auth_repository.dart
│   │   └── token_store.dart
│   ├── messaging/
│   │   └── push_service.dart
│   ├── pages/
│   │   ├── announcement_page.dart
│   │   ├── debug_page.dart
│   │   ├── home_page.dart
│   │   └── login_page.dart
│   └── providers/
│       └── auth_provider.dart
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── README.md