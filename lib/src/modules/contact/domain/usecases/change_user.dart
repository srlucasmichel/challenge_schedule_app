import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IChangeUser {
  Future<Either<IUserException, int>> call(User user);
}

class ChangeUser implements IChangeUser {
  final IUserRepository repository;

  ChangeUser(this.repository);

  @override
  Future<Either<IUserException, int>> call(User user) async {
    return await repository.changeUser(user);
  }
}
