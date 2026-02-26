import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static String proxy = 'https://corsproxy.io/?';
  static String baseUrl = 'http://localhost:5000/api/auth/register';

  // REGISTER
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$proxy$baseUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return data; // يحتوي على token و email
      } else {
        // إذا كان السيرفر رجع error
        return {'error': data['message'] ?? 'حدث خطأ'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
