import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IInsertUsers {
  Future<Either<IUserException, void>> call(List<User> users);
}

class InsertUsers implements IInsertUsers {
  final IUserRepository repository;

  InsertUsers(this.repository);

  @override
  Future<Either<IUserException, void>> call(List<User> users) async {
    return await repository.insertUsers(users);
  }
}
