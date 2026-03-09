import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;
  const SignUpUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(SignUpParams params) =>
      _repository.signUp(
        email: params.email,
        password: params.password,
        confirmPassword: params.confirmPassword,
      );
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}
