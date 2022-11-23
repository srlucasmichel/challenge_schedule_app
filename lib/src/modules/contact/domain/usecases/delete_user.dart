import 'package:fpdart/fpdart.dart';

import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IDeleteUser {
  Future<Either<IUserException, void>> call({required int userId});
}

class DeleteUser implements IDeleteUser {
  final IUserRepository repository;

  DeleteUser(this.repository);

  @override
  Future<Either<IUserException, void>> call({required int userId}) async {
    return await repository.deleteUser(userId: userId);
  }
}
