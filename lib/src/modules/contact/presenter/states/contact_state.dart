import '../../domain/entities/user.dart';

abstract class ContactState {}

class SuccessContactState implements ContactState {
  final List<User> posts;

  SuccessContactState(this.posts);
}

class EmptyContactState extends SuccessContactState {
  EmptyContactState() : super([]);
}

class LoadingContactState extends ContactState {}

class ErrorContactState extends ContactState {
  final String message;

  ErrorContactState(this.message);
}
