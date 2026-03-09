import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Abstract contract between the domain and data layers.
/// Use cases depend ONLY on this interface — never on the impl directly.
abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, void>> signOut();

  /// Returns the locally cached user if a valid token exists.
  Future<Either<Failure, UserEntity?>> getSignedInUser();
}
