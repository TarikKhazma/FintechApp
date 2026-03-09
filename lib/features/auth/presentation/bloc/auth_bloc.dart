import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_signed_in_user_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

export 'auth_event.dart';
export 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetSignedInUserUseCase getSignedInUser;
  final SignInUseCase signIn;
  final SignUpUseCase signUp;
  final SignOutUseCase signOut;

  AuthBloc({
    required this.getSignedInUser,
    required this.signIn,
    required this.signUp,
    required this.signOut,
  }) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onCheckAuth);
    on<AuthSignInRequested>(_onSignIn);
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthSignOutRequested>(_onSignOut);
  }

  Future<void> _onCheckAuth(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await getSignedInUser();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (user)    => user != null
          ? emit(AuthState.authenticated(user))
          : emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onSignIn(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await signIn(
      SignInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthState.failure(failure.message)),
      (user)    => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignUp(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ),
    );
    result.fold(
      (failure) => emit(AuthState.failure(failure.message)),
      (user)    => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await signOut();
    result.fold(
      (failure) => emit(AuthState.failure(failure.message)),
      (_)       => emit(const AuthState.unauthenticated()),
    );
  }
}
