import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';

class AuthApiService {
  static const String _proxy = 'https://corsproxy.io/?';
  static const String _baseUrl = 'http://localhost:5000/api/auth';

  /// SIGN UP
  static Future<AuthModel> signup({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse('$_proxy$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthModel.fromJson(data);
    }

    throw Exception(data['message'] ?? 'Signup failed');
  }

  /// SIGN IN
  static Future<AuthModel> signin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_proxy$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return AuthModel.fromJson(data);
    }

    throw Exception(data['message'] ?? 'Signin failed');
  }
}
