import 'package:fintech_app/features/view/auth/data/repositories/auth_api_service.dart';

import '../models/auth_model.dart';

import '../storage/secure_storage_service.dart';

class AuthRepository {
  /// SIGN UP
  Future<AuthModel> signup({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final result = await AuthApiService.signup(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (result.token != null) await SecureStorageService.saveToken(result.token!);
    return result;
  }

  /// SIGN IN
  Future<AuthModel> signin({
    required String email,
    required String password,
  }) async {
    final result = await AuthApiService.signin(
      email: email,
      password: password,
    );

    if (result.token != null) await SecureStorageService.saveToken(result.token!);
    return result;
  }

  /// LOGOUT
  Future<void> logout() async {
    await SecureStorageService.deleteToken();
  }
}
