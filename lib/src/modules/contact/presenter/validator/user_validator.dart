import '../../domain/entities/user.dart';
import 'cpf_validator.dart';

class UserValidator{
  static String? validRequiredFields(final User user,
      {required final bool validId}) {
    if (user.firstName == null) {
      return 'user first name is null';
    } else if (user.firstName!.trim().isEmpty) {
      return 'user first name is empty';
    } else if (user.documentNumber.trim().isEmpty) {
      return 'user cpf is empty';
    } else if (CpfValidator.getError(user.documentNumber) != null) {
      return 'user cpf is invalid';
    }
    if (validId) {
      if (user.id == null || user.id! < 1) {
        return 'user Id is invalid';
      }
    }
    return null;
  }
}