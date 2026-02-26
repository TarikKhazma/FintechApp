enum SignupStatus { initial, loading, success, error }

class AuthState {
  final SignupStatus status;
  final String? error;
  final String? token;
  final String? email;
  final String? success;

  const AuthState({
    this.status = SignupStatus.initial,
    this.error,
    this.token,
    this.email,
    this.success,
  });

  AuthState copyWith({
    SignupStatus? status,
    String? error,
    String? token,
    String? email,
    String? success,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      success: success,
      token: token ?? this.token,
      email: email ?? this.email,
    );
  }
}
