import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fintech_app/core/errors/failures.dart';
import 'package:fintech_app/features/auth/domain/entities/user_entity.dart';
import 'package:fintech_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fintech_app/features/auth/domain/usecases/sign_in_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInUseCase(mockRepository);
  });

  const tParams = SignInParams(
    email: 'test@example.com',
    password: 'password123',
  );

  const tUser = UserEntity(
    id: 'user-123',
    email: 'test@example.com',
    accessToken: 'token-abc',
  );

  group('SignInUseCase', () {
    test('returns UserEntity on success', () async {
      when(() => mockRepository.signIn(
            email: tParams.email,
            password: tParams.password,
          )).thenAnswer((_) async => right(tUser));

      final result = await useCase(tParams);

      expect(result, right(tUser));
      verify(() => mockRepository.signIn(
            email: tParams.email,
            password: tParams.password,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('returns ServerFailure on server error', () async {
      const tFailure = ServerFailure('Invalid credentials', statusCode: 401);

      when(() => mockRepository.signIn(
            email: tParams.email,
            password: tParams.password,
          )).thenAnswer((_) async => left(tFailure));

      final result = await useCase(tParams);

      expect(result, left(tFailure));
    });

    test('returns NetworkFailure when offline', () async {
      const tFailure = NetworkFailure('No internet connection');

      when(() => mockRepository.signIn(
            email: tParams.email,
            password: tParams.password,
          )).thenAnswer((_) async => left(tFailure));

      final result = await useCase(tParams);

      expect(result, left(tFailure));
    });
  });
}
