import 'package:fintech_app/features/view/auth/create_account_screen_page_two/services/data/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'singup_state.dart';
import 'singup_event.dart';

class AuthBloc extends Bloc<SignupRequested, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<SignupRequested>((event, emit) async {
      emit(state.copyWith(status: SignupStatus.loading, error: null));
      try {
        final response = await AuthService.register(
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        if (response['token'] != null) {
          emit(
            state.copyWith(
              status: SignupStatus.success,
              token: response['token'],
              email: response['email'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: SignupStatus.error,
              error: response['error'] ?? 'حدث خطأ',
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: SignupStatus.error, error: e.toString()));
      }
    });
  }
}
