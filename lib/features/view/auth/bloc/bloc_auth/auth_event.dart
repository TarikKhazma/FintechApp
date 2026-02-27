abstract class AuthEvent {}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignupRequested({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SigninRequested extends AuthEvent {
  final String email;
  final String password;

  SigninRequested({required this.email, required this.password});
}
