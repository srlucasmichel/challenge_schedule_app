import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';

abstract class IUserRepository {
  Future<Either<IUserException, List<User>>> getUsers();

  Future<Either<IUserException, int>> insertUser(final User user);

  Future<Either<IUserException, int>> insertUsers(final List<User> users);

  Future<Either<IUserException, int>> updateUser(final User user);

  Future<Either<IUserException, int>> deleteUser({required final int userId});
}
