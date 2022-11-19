abstract class IUserException {
  final String message;
  final StackTrace? stackTrace;

  const IUserException(this.message, [this.stackTrace]);
}

class ArgumentsException extends IUserException {
  const ArgumentsException(super.message, [super.stackTrace]);
}

class DatasourceContactException extends IUserException {
  const DatasourceContactException(super.message, [super.stackTrace]);
}