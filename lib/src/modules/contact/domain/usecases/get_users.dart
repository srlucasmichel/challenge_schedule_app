import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IGetUsers {
  Future<Either<IUserException, List<User>>> call();
}

class GetUsers implements IGetUsers {
  final IUserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<IUserException, List<User>>> call() async {
    return await repository.getUsers();
  }
}
