import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';

abstract class IUserRepository {
  Future<Either<IUserException, List<User>>> getUsers();
  Future<Either<IUserException, int>> createUser(User user);
  Future<Either<IUserException, int>> changeUser(User user);
  Future<Either<IUserException, int>> deleteUser({required int userId});
}