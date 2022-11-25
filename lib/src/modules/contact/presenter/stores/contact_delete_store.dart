import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/delete_user.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/errors/errors.dart';
import '../states/contact_delete_state.dart';

class ContactDeleteStore extends ValueNotifier<ContactDeleteState> {
  final IDeleteUser deleteUser;

  ContactDeleteStore(this.deleteUser) : super(LoadingContactState());

  void emit(ContactDeleteState newState) => value = newState;

  Future<void> delete(final int userId) async {
    emit(LoadingContactState());

    final Either<IUserException, void> deletedUser =
        await deleteUser.call(userId: userId);

    final newState = deletedUser.fold((l) {
      return ErrorContactDeleteState(l.message);
    }, (r) {
      return SuccessContactDeleteState();
    });

    emit(newState);
  }
}
