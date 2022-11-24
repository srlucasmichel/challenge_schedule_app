import '../../domain/entities/user.dart';

abstract class ContactListState {}

class SuccessContactState implements ContactListState {
  final List<User> users;

  SuccessContactState(this.users);
}

class EmptyContactState extends SuccessContactState {
  EmptyContactState() : super([]);
}

class LoadingContactState extends ContactListState {}

class ErrorContactState extends ContactListState {
  final String message;

  ErrorContactState(this.message);
}
