import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/delete_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/insert_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/update_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/infra/adapters/user_adapter.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user.dart';
import '../../domain/errors/errors.dart';
import '../states/contact_updates_state.dart';

class ContactDetailStore extends ValueNotifier<ContactUpdatesState> {
  final IInsertUser insertUser;
  final IUpdateUser updateUser;
  final IDeleteUser deleteUser;

  ContactDetailStore(this.insertUser, this.updateUser, this.deleteUser)
      : super(LoadingContactState());

  void emit(ContactUpdatesState newState) => value = newState;

  Future<void> insert(final User user) async {
    emit(LoadingContactState());

    final Either<IUserException, int> newUser = await insertUser.call(user);

    final newState = newUser.fold((l) {
      return ErrorContactInsertState(l.message);
    }, (r) {
      return SuccessContactInsertState(UserAdapter.createNewUser(user, r));
    });

    emit(newState);
  }

  Future<void> update(final User user) async {
    emit(LoadingContactState());

    final Either<IUserException, void> updatedUser =
        await updateUser.call(user);

    final newState = updatedUser.fold((l) {
      return ErrorContactUpdateState(l.message);
    }, (r) {
      return SuccessContactUpdateState(user);
    });

    emit(newState);
  }

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
