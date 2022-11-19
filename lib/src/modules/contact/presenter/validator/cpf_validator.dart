import 'package:cpf_cnpj_validator/cpf_validator.dart';

class CpfValidator {
  static String? isValid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'O CPF deve ser informado';
    }
    if (!CPFValidator.isValid(value)) {
      return 'CPF inválido';
    }
    return null;
  }
}
