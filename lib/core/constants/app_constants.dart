import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  AppConstants._();

  // --- API ---
  /// localhost for Chrome Web, LAN IP for Android/iOS
  static String get baseUrl =>
      kIsWeb ? 'http://localhost:3000' : 'http://192.168.8.176:3000';

  static const String apiVersion = '/api/v1';
  static String get apiBaseUrl => '$baseUrl$apiVersion';

  // --- Secure Storage Keys ---
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';

  // --- Timeouts ---
  static const int connectTimeoutSeconds = 30;
  static const int receiveTimeoutSeconds = 30;

  // --- Pagination ---
  static const int defaultPageSize = 20;
}
