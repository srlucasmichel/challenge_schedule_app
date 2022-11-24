import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/get_users.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/insert_users.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/get_users_api.dart';
import '../states/contact_list_state.dart';

class ContactListStore extends ValueNotifier<ContactListState> {
  final IGetUsersApi getUsersApi;
  final IGetUsers getUsers;
  final IInsertUsers insertUsers;

  ContactListStore(this.getUsersApi, this.getUsers, this.insertUsers)
      : super(EmptyContactState());

  void emit(ContactListState newState) => value = newState;

  Future<void> fetchUsers() async {
    emit(LoadingContactState());

    final prefs = await SharedPreferences.getInstance();

    final bool? welcome = prefs.getBool('welcome');

    if (welcome == null || !welcome) {
      await prefs.setBool('welcome', true);
      final Either<IUserException, List<User>> externalUsers =
          await getUsersApi.call();
      externalUsers.fold(
        (exception) {},
        (listUsers) async => await insertUsers.call(listUsers),
      );
    }

    final Either<IUserException, List<User>> users = await getUsers.call();

    final newState = users.fold((l) {
      return ErrorContactState(l.message);
    }, (r) {
      return SuccessContactState(r);
    });

    emit(newState);
  }
}
