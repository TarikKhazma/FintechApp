import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';

class AuthApiService {
  /// localhost for Chrome Web, LAN IP for Android/iOS
  static String get _baseUrl =>
      kIsWeb ? 'http://localhost:8000/auth' : 'http://192.168.8.176:8000/auth';

  /// SIGN UP  →  POST /auth/signup
  static Future<AuthModel> signup({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/signup'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
            'confirmPassword': confirmPassword,
          }),
        )
        .timeout(
          const Duration(seconds: 8),
          onTimeout: () => throw Exception('No internet connection'),
        );

    final data = _parseBody(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // FastAPI signup returns {"success": true, "message": "..."}
      // No token here — return a minimal AuthModel
      return AuthModel(email: email);
    }
    // ignore: avoid_print
    print('Signup failed ${response.statusCode}: ${response.body}');
    throw Exception(_errorMessage(data, 'Signup failed'));
  }

  /// SIGN IN  →  POST /auth/login
  static Future<AuthModel> signin({
    required String email,
    required String password,
  }) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(
          const Duration(seconds: 8),
          onTimeout: () => throw Exception('No internet connection'),
        );

    final data = _parseBody(response.body);

    if (response.statusCode == 200) {
      // FastAPI login returns {"success": true, "access_token": "...", "token_type": "bearer"}
      return AuthModel.fromJson(data);
    }
    // ignore: avoid_print
    print('Signin failed ${response.statusCode}: ${response.body}');
    throw Exception(_errorMessage(data, 'Signin failed'));
  }

  static Map<String, dynamic> _parseBody(String body) {
    if (body.trim().isEmpty) return {};
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } catch (_) {
      return {};
    }
  }

  static String _errorMessage(Map<String, dynamic> data, String fallback) {
    final msg = data['message'];
    if (msg == null) return fallback;
    if (msg is String) return msg;
    if (msg is Map) return msg['message']?.toString() ?? fallback;
    return fallback;
  }
}
