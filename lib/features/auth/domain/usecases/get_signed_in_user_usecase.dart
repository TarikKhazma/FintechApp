import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetSignedInUserUseCase {
  final AuthRepository _repository;
  const GetSignedInUserUseCase(this._repository);

  Future<Either<Failure, UserEntity?>> call() => _repository.getSignedInUser();
}
