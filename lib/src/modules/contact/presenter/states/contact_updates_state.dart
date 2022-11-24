import '../../domain/entities/user.dart';

abstract class ContactUpdatesState {}

class SuccessContactInsertState implements ContactUpdatesState {
  final User user;

  SuccessContactInsertState(this.user);
}

class SuccessContactUpdateState implements ContactUpdatesState {
  final User user;

  SuccessContactUpdateState(this.user);
}

class SuccessContactDeleteState implements ContactUpdatesState {}

class LoadingContactState extends ContactUpdatesState {}

class ErrorContactInsertState extends ContactUpdatesState {
  final String message;

  ErrorContactInsertState(this.message);
}

class ErrorContactUpdateState extends ContactUpdatesState {
  final String message;

  ErrorContactUpdateState(this.message);
}

class ErrorContactDeleteState extends ContactUpdatesState {
  final String message;

  ErrorContactDeleteState(this.message);
}
