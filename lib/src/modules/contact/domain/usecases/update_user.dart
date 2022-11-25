import 'package:fpdart/fpdart.dart';

import '../../presenter/validator/user_validator.dart';
import '../entities/user.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class IUpdateUser {
  Future<Either<IUserException, int>> call(final User user);
}

class UpdateUser implements IUpdateUser {
  final IUserRepository repository;

  UpdateUser(this.repository);

  @override
  Future<Either<IUserException, int>> call(final User user) async {
    final String? validation =
        UserValidator.validRequiredFields(user, validId: true);

    if (validation != null) {
      return left(ArgumentsException(validation));
    }

    return await repository.updateUser(user);
  }
}
