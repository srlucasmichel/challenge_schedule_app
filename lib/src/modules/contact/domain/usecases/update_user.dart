import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IUpdateUser {
  Future<Either<IUserException, void>> call(User user);
}

class UpdateUser implements IUpdateUser {
  final IUserRepository repository;

  UpdateUser(this.repository);

  @override
  Future<Either<IUserException, void>> call(User user) async {
    return await repository.updateUser(user);
  }
}
