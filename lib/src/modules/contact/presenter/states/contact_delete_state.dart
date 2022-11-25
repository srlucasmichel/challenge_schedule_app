abstract class ContactDeleteState {}

class SuccessContactDeleteState implements ContactDeleteState {}

class LoadingContactState extends ContactDeleteState {}

class ErrorContactDeleteState extends ContactDeleteState {
  final String message;

  ErrorContactDeleteState(this.message);
}
