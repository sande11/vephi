import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeepSeekService {
  static String get _apiKey {
    final key = dotenv.env['DEEPSEEK_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('DeepSeek API key not found in .env file. Please add DEEPSEEK_API_KEY=your_api_key to your .env file');
    }
    return key;
  }
  
  static const String _apiUrl = 'https://api.deepseek.com/v1/chat/completions';

  static Future<String> generateCoverLetter(String prompt) async {
    try {
      print('Checking API key...');
      final apiKey = _apiKey;
      print('API Key found: ${apiKey.substring(0, 5)}...');

      print('Sending request to DeepSeek API...');
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a professional cover letter writer. Write a compelling and personalized cover letter based on the provided job details and candidate information.'
            },
            {
              'role': 'user',
              'content': prompt
            }
          ],
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'];
        } else {
          throw Exception('Invalid response format from DeepSeek API');
        }
      } else {
        throw Exception('Failed to generate cover letter: ${response.statusCode}\nResponse: ${response.body}');
      }
    } catch (e) {
      print('Error in generateCoverLetter: $e');
      throw Exception('Error generating cover letter: $e');
    }
  }
} 