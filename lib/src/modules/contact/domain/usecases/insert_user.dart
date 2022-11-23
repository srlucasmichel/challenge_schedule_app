import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IInsertUser {
  Future<Either<IUserException, int>> call(User user);
}

class InsertUser implements IInsertUser {
  final IUserRepository repository;

  InsertUser(this.repository);

  @override
  Future<Either<IUserException, int>> call(User user) async {
    return await repository.insertUser(user);
  }
}
