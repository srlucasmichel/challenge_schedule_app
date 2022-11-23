abstract class IUserException {
  final String message;
  final StackTrace? stackTrace;

  const IUserException(this.message, [this.stackTrace]);

  @override
  String toString() {
    return 'IUserException{message: $message, stackTrace: $stackTrace';
  }
}

class ArgumentsException extends IUserException {
  const ArgumentsException(super.message, [super.stackTrace]);

  @override
  String toString() {
    return 'ArgumentsException{message: ${super.message}, stackTrace: ${super.stackTrace}';
  }
}

class DatasourceContactException extends IUserException {
  const DatasourceContactException(super.message, [super.stackTrace]);

  @override
  String toString() {
    return 'DatasourceContactException{message: ${super.message}, stackTrace: ${super.stackTrace}';
  }
}

class RepositoryContactException extends IUserException {
  const RepositoryContactException(super.message, [super.stackTrace]);

  @override
  String toString() {
    return 'RepositoryContactException{message: ${super.message}, stackTrace: ${super.stackTrace}';
  }
}
