import 'package:fpdart/fpdart.dart';

import '../../presenter/validator/user_validator.dart';
import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IInsertUser {
  Future<Either<IUserException, int>> call(final User user);
}

class InsertUser implements IInsertUser {
  final IUserRepository repository;

  InsertUser(this.repository);

  @override
  Future<Either<IUserException, int>> call(final User user) async {
    final String? validation =
        UserValidator.validRequiredFields(user, validId: false);

    if (validation != null) {
      return left(ArgumentsException(validation));
    }

    return await repository.insertUser(user);
  }
}
