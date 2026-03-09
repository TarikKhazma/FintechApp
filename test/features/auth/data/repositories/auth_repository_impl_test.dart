import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fintech_app/core/errors/exceptions.dart';
import 'package:fintech_app/core/errors/failures.dart';
import 'package:fintech_app/core/storage/secure_storage_service.dart';
import 'package:fintech_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fintech_app/features/auth/data/models/auth_response_model.dart';
import 'package:fintech_app/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;
  late MockSecureStorageService mockStorage;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    mockStorage = MockSecureStorageService();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockDataSource,
      storageService: mockStorage,
    );
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';

  final tAuthModel = AuthResponseModel(
    id: 'user-123',
    email: tEmail,
    accessToken: 'token-abc',
  );

  group('signIn', () {
    test('returns UserEntity and saves token on success', () async {
      when(() => mockDataSource.signIn(email: tEmail, password: tPassword))
          .thenAnswer((_) async => tAuthModel);
      when(() => mockStorage.saveToken(any())).thenAnswer((_) async {});

      final result = await repository.signIn(email: tEmail, password: tPassword);

      expect(result.isRight(), true);
      result.fold(
        (f) => fail('Expected Right but got Left: $f'),
        (user) {
          expect(user.email, tEmail);
          expect(user.accessToken, 'token-abc');
        },
      );
      verify(() => mockStorage.saveToken('token-abc')).called(1);
    });

    test('returns ServerFailure on ServerException', () async {
      when(() => mockDataSource.signIn(email: tEmail, password: tPassword))
          .thenThrow(const ServerException(message: 'Unauthorized', statusCode: 401));

      final result = await repository.signIn(email: tEmail, password: tPassword);

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<ServerFailure>()),
        (_) => fail('Expected Left'),
      );
      verifyNever(() => mockStorage.saveToken(any()));
    });

    test('returns NetworkFailure on NetworkException', () async {
      when(() => mockDataSource.signIn(email: tEmail, password: tPassword))
          .thenThrow(const NetworkException());

      final result = await repository.signIn(email: tEmail, password: tPassword);

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('Expected Left'),
      );
    });
  });

  group('signOut', () {
    test('clears storage and returns Right(null)', () async {
      when(() => mockStorage.clearAll()).thenAnswer((_) async {});

      final result = await repository.signOut();

      expect(result.isRight(), true);
      verify(() => mockStorage.clearAll()).called(1);
    });
  });
}
