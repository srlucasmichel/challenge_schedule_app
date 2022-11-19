import 'package:flutter/material.dart';

import '../../domain/usecases/get_users.dart';
import '../states/contact_state.dart';

class ContactStore extends ValueNotifier<ContactState> {
  final IGetUsers getUsers;

  ContactStore(this.getUsers) : super(EmptyContactState());

  void emit(ContactState newState) => value = newState;

  Future<void> fetchPosts() async {
    emit(LoadingContactState());

    final result = await getUsers.call();

    final newState = result.fold((l) {
      return ErrorContactState(l.message);
    }, (r) {
      return SuccessContactState(r);
    });

    emit(newState);
  }
}
