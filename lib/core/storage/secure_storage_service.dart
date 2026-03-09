import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

/// Instance-based secure storage so it can be injected and mocked in tests.
/// The old static version in features/view/auth/data/storage/ is superseded by this.
class SecureStorageService {
  SecureStorageService() : _storage = const FlutterSecureStorage();

  // Allow injection of a custom storage in tests.
  SecureStorageService.withStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) =>
      _storage.write(key: AppConstants.accessTokenKey, value: token);

  Future<String?> readToken() =>
      _storage.read(key: AppConstants.accessTokenKey);

  Future<void> deleteToken() =>
      _storage.delete(key: AppConstants.accessTokenKey);

  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: AppConstants.refreshTokenKey, value: token);

  Future<String?> readRefreshToken() =>
      _storage.read(key: AppConstants.refreshTokenKey);

  Future<void> clearAll() => _storage.deleteAll();
}
