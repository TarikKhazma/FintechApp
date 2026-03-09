/// Pure domain entity — no Dio, no JSON, no Flutter imports.
/// Represents an authenticated user inside the app.
class UserEntity {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String accessToken;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.email,
    required this.accessToken,
    this.fullName,
    this.phone,
    this.isVerified = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is UserEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
