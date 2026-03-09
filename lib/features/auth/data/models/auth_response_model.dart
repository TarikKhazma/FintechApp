import '../../domain/entities/user_entity.dart';

/// Data model — knows about JSON. Maps to/from [UserEntity].
class AuthResponseModel {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String accessToken;
  final bool isVerified;

  const AuthResponseModel({
    required this.id,
    required this.email,
    required this.accessToken,
    this.fullName,
    this.phone,
    this.isVerified = false,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      id: json['id'] as String,
      email: json['email'] as String,
      accessToken: json['token'] as String,
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'token': accessToken,
        'fullName': fullName,
        'phone': phone,
        'isVerified': isVerified,
      };

  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        accessToken: accessToken,
        fullName: fullName,
        phone: phone,
        isVerified: isVerified,
      );
}
