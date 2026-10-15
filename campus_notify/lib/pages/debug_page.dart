
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  String _tokenMessage = 'Memeriksa FCM token...';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    if (kIsWeb) {
      setState(() {
        _tokenMessage =
            'FCM Web belum dikonfigurasi. Jalankan pengujian pada Android.';
      });
      return;
    }

    try {
      final token = await FirebaseMessaging.instance.getToken();

      if (!mounted) return;

      setState(() {
        _tokenMessage = token ?? 'Token not available';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _tokenMessage = 'Gagal mengambil token: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SelectableText(_tokenMessage),
        ),
      ),
    );
  }
}
