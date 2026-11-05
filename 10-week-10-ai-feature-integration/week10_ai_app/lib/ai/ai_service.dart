import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AiService {
  final _storage = const FlutterSecureStorage();

final _apiUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-lite-latest:generateContent';
  Future<String> ask(String question) async {
    final apiKey = await _storage.read(key: 'ai_api_key');

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API key not available. Please set it in settings.');
    }

    final response = await http.post(
      Uri.parse('$_apiUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': question},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Gemini error ${response.statusCode}: ${response.body}');
    }
  }

  Future<void> saveApiKey(String key) async {
    await _storage.write(key: 'ai_api_key', value: key);
  }
}
