import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    if (!mounted) return;

    setState(() {
      _token = token;
    });
  }

  String _displayToken(String? token) {
    if (token == null) {
      return 'Token not available';
    }

    if (token.length <= 12) {
      return '$token...';
    }

    return '${token.substring(0, 12)}...';
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
          child: Text(
            _displayToken(_token),
          ),
        ),
      ),
    );
  }
}