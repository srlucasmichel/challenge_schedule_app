import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../errors/errors.dart';

abstract class IPopulateUsersRepository {
  Future<Either<IUserException, List<User>>> getUsers();
}