import '../../domain/entities/user.dart';

abstract class ContactFormState {}

class SuccessContactInsertState implements ContactFormState {
  final User user;

  SuccessContactInsertState(this.user);
}

class SuccessContactUpdateState implements ContactFormState {
  final User user;

  SuccessContactUpdateState(this.user);
}

class LoadingContactState extends ContactFormState {}

class ErrorContactInsertState extends ContactFormState {
  final String message;

  ErrorContactInsertState(this.message);
}

class ErrorContactUpdateState extends ContactFormState {
  final String message;

  ErrorContactUpdateState(this.message);
}
