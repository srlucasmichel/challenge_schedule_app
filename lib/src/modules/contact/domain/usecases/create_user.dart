import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class ICreateUser {
  Future<Either<IUserException, int>> call(User user);
}

class CreateUser implements ICreateUser {
  final IUserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<IUserException, int>> call(User user) async {
    return await repository.createUser(user);
  }
}
