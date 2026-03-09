import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implements [AuthRepository] — bridges domain ↔ data.
/// Converts exceptions into typed [Failure]s so use cases stay clean.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageService storageService;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.storageService,
  });

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final model = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      await storageService.saveToken(model.accessToken);
      return right(model.toEntity());
    } on UnauthorizedException catch (e) {
      return left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final model = await remoteDataSource.signUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      await storageService.saveToken(model.accessToken);
      return right(model.toEntity());
    } on ServerException catch (e) {
      return left(ServerFailure(e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return left(NetworkFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await storageService.clearAll();
      return right(null);
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getSignedInUser() async {
    try {
      final token = await storageService.readToken();
      if (token == null) return right(null);
      // Token exists — return a minimal entity; full profile loaded separately
      return right(UserEntity(id: '', email: '', accessToken: token));
    } on CacheException catch (e) {
      return left(CacheFailure(e.message));
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
