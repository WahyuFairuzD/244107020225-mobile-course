import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.school, size: 72),
              SizedBox(height: 16),
              Text(
                'Wahyu Fairuz',
                style: TextStyle(fontSize: 24),
              ),
              Text('Pemrograman Mobile - Minggu 1'),
            ],
          ),
        ),
      ),
    );
  }
}