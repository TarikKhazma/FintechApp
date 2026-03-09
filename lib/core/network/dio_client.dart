import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';
import 'auth_interceptor.dart';

/// Singleton Dio instance shared across all data sources.
/// Configured with:
///  - Base URL from [AppConstants]
///  - 30s connect / receive timeout
///  - [AuthInterceptor] for JWT injection and 401 handling
///  - Error mapping from [DioException] to domain [Exception] types
class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio getInstance(AuthInterceptor authInterceptor) {
    _instance ??= _create(authInterceptor);
    return _instance!;
  }

  static Dio _create(AuthInterceptor authInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 8),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    ]);

    return dio;
  }

  /// Maps a [DioException] to a typed domain [Exception].
  static Exception handleDioError(DioException e) {
    if (e.error is UnauthorizedException) {
      return const UnauthorizedException();
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] as String? ??
            e.response?.statusMessage ??
            'Something went wrong';
        return ServerException(message: message, statusCode: statusCode);
      default:
        return ServerException(
          message: e.message ?? 'An unexpected error occurred',
        );
    }
  }
}
