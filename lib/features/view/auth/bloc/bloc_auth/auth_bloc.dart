import 'package:fintech_app/features/view/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(const AuthState()) {
    on<SignupRequested>(_onSignup);
    on<SigninRequested>(_onSignin);
  }

  Future<void> _onSignup(SignupRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, error: null));
    try {
      final result = await repository.signup(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      emit(
        state.copyWith(
          status: AuthStatus.success,
          token: result.token,
          email: result.email,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }

  Future<void> _onSignin(SigninRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, error: null));
    try {
      final result = await repository.signin(
        email: event.email,
        password: event.password,
      );

      emit(
        state.copyWith(
          status: AuthStatus.success,
          token: result.token,
          email: result.email,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, error: e.toString()));
    }
  }
}
