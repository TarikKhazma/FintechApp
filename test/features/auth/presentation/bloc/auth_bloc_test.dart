import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fintech_app/core/errors/failures.dart';
import 'package:fintech_app/features/auth/domain/entities/user_entity.dart';
import 'package:fintech_app/features/auth/domain/usecases/get_signed_in_user_usecase.dart';
import 'package:fintech_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:fintech_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:fintech_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';

class MockGetSignedInUserUseCase extends Mock implements GetSignedInUserUseCase {}
class MockSignInUseCase extends Mock implements SignInUseCase {}
class MockSignUpUseCase extends Mock implements SignUpUseCase {}
class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class FakeSignInParams extends Fake implements SignInParams {}
class FakeSignUpParams extends Fake implements SignUpParams {}

void main() {
  late AuthBloc bloc;
  late MockGetSignedInUserUseCase mockGetSignedInUser;
  late MockSignInUseCase mockSignIn;
  late MockSignUpUseCase mockSignUp;
  late MockSignOutUseCase mockSignOut;

  setUpAll(() {
    registerFallbackValue(FakeSignInParams());
    registerFallbackValue(FakeSignUpParams());
  });

  setUp(() {
    mockGetSignedInUser = MockGetSignedInUserUseCase();
    mockSignIn = MockSignInUseCase();
    mockSignUp = MockSignUpUseCase();
    mockSignOut = MockSignOutUseCase();
    bloc = AuthBloc(
      getSignedInUser: mockGetSignedInUser,
      signIn: mockSignIn,
      signUp: mockSignUp,
      signOut: mockSignOut,
    );
  });

  tearDown(() => bloc.close());

  const tUser = UserEntity(
    id: 'user-123',
    email: 'test@example.com',
    accessToken: 'token-abc',
  );

  group('AuthCheckRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [authenticated] when token exists',
      build: () {
        when(() => mockGetSignedInUser()).thenAnswer((_) async => right(tUser));
        return bloc;
      },
      act: (b) => b.add(const AuthCheckRequested()),
      expect: () => [AuthState.authenticated(tUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [unauthenticated] when no token',
      build: () {
        when(() => mockGetSignedInUser()).thenAnswer((_) async => right(null));
        return bloc;
      },
      act: (b) => b.add(const AuthCheckRequested()),
      expect: () => [const AuthState.unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [unauthenticated] on cache failure',
      build: () {
        when(() => mockGetSignedInUser())
            .thenAnswer((_) async => left(const CacheFailure('read error')));
        return bloc;
      },
      act: (b) => b.add(const AuthCheckRequested()),
      expect: () => [const AuthState.unauthenticated()],
    );
  });

  group('AuthSignInRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] on success',
      build: () {
        when(() => mockSignIn(any())).thenAnswer((_) async => right(tUser));
        return bloc;
      },
      act: (b) => b.add(const AuthSignInRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] on ServerFailure',
      build: () {
        when(() => mockSignIn(any()))
            .thenAnswer((_) async => left(const ServerFailure('Invalid credentials')));
        return bloc;
      },
      act: (b) => b.add(const AuthSignInRequested(
        email: 'test@example.com',
        password: 'wrong',
      )),
      expect: () => [
        const AuthState.loading(),
        const AuthState.failure('Invalid credentials'),
      ],
    );
  });

  group('AuthSignOutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] on success',
      build: () {
        when(() => mockSignOut()).thenAnswer((_) async => right(null));
        return bloc;
      },
      act: (b) => b.add(const AuthSignOutRequested()),
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
      ],
    );
  });
}
