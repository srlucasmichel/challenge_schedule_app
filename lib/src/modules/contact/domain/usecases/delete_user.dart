import 'package:fpdart/fpdart.dart';

import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IDeleteUser {
  Future<Either<IUserException, int>> call({required final int userId});
}

class DeleteUser implements IDeleteUser {
  final IUserRepository repository;

  DeleteUser(this.repository);

  @override
  Future<Either<IUserException, int>> call({required final int userId}) async {
    if (userId < 1) {
      return left(const ArgumentsException('userId is invalid'));
    }

    return await repository.deleteUser(userId: userId);
  }
}
