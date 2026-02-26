abstract class AuthEvent {}

class SignupRequested {
  final String email;
  final String password;
  final String confirmPassword;

  SignupRequested({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
