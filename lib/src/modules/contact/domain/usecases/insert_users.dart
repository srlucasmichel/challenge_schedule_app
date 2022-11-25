import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IInsertUsers {
  Future<Either<IUserException, int>> call(final List<User> users);
}

class InsertUsers implements IInsertUsers {
  final IUserRepository repository;

  InsertUsers(this.repository);

  @override
  Future<Either<IUserException, int>> call(final List<User> users) async {
    if (users.isEmpty) {
      return left(const ArgumentsException('users is empty'));
    }

    return await repository.insertUsers(users);
  }
}
