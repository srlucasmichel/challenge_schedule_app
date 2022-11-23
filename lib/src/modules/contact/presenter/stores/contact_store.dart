import 'package:flutter/material.dart';

import '../../domain/usecases/get_users_api.dart';
import '../states/contact_state.dart';

class ContactStore extends ValueNotifier<ContactState> {
  final IGetUsersApi getUsersApi;

  ContactStore(this.getUsersApi) : super(EmptyContactState());

  void emit(ContactState newState) => value = newState;

  Future<void> fetchUsers() async {
    emit(LoadingContactState());

    final result = await getUsersApi.call();

    final newState = result.fold((l) {
      return ErrorContactState(l.message);
    }, (r) {
      return SuccessContactState(r);
    });

    emit(newState);
  }
}
