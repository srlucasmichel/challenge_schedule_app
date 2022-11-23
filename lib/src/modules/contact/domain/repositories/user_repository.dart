import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';

abstract class IUserRepository {
  Future<Either<IUserException, List<User>>> getUsers();

  Future<Either<IUserException, int>> insertUser(User user);

  Future<Either<IUserException, void>> insertUsers(List<User> users);

  Future<Either<IUserException, void>> updateUser(User user);

  Future<Either<IUserException, void>> deleteUser({required int userId});
}
