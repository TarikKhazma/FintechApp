class AuthModel {
  final String token;
  final String email;

  AuthModel({required this.token, required this.email});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(token: json['token'], email: json['email']);
  }
}
