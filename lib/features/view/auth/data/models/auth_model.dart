class AuthModel {
  final String? token;
  final String email;

  AuthModel({this.token, required this.email});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      // FastAPI returns access_token; fall back to legacy token field
      token: json['access_token'] as String? ?? json['token'] as String?,
      email: json['email'] as String? ?? '',
    );
  }
}
