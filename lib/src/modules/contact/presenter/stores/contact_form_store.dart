import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/insert_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/update_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/infra/adapters/user_adapter.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user.dart';
import '../../domain/errors/errors.dart';
import '../states/contact_form_state.dart';

class ContactFormStore extends ValueNotifier<ContactFormState> {
  final IInsertUser insertUser;
  final IUpdateUser updateUser;

  ContactFormStore(this.insertUser, this.updateUser)
      : super(LoadingContactState());

  void emit(ContactFormState newState) => value = newState;

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
}
