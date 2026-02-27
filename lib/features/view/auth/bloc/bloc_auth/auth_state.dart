enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? token;
  final String? email;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.token,
    this.email,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    String? email,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      email: email ?? this.email,
      error: error,
    );
  }
}
