import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/populate_users_repository.dart';

abstract class IGetUsersApi {
  Future<Either<IUserException, List<User>>> call();
}

class GetUsersApi implements IGetUsersApi {
  final IPopulateUsersRepository repository;

  GetUsersApi(this.repository);

  @override
  Future<Either<IUserException, List<User>>> call() async {
    return await repository.getUsers();
  }
}
