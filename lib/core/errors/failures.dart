/// Base failure class — every error that reaches the UI is a [Failure].
/// Use [Either<Failure, T>] (from fpdart) as return type in use cases.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

/// API / HTTP errors (4xx, 5xx).
final class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

/// No internet / timeout.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// Local cache or secure storage errors.
final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Expired or missing JWT token.
final class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Session expired. Please sign in again.']);
}

/// Input that failed business-rule validation (not form validation).
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
