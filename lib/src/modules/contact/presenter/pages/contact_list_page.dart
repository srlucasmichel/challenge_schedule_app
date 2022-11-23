import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../states/contact_state.dart';
import '../stores/contact_store.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  //List<User> users = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    context.read<ContactStore>().fetchUsers();
    /*users.add(User(
        id: 1,
        documentNumber: '47964001841',
        firstName: 'Lucas',
        lastName: 'Michel',
        email: 'lucasmichel_tcx@hotmail.com',
        photo: "https://www.w3schools.com/howto/img_avatar.png",
        celPhoneNumber: '5511976688302',
        homePhoneNumber: '551130334044',
        workPhoneNumber: '551131771212'));
    users.add(User(
        id: 2,
        documentNumber: '47964001841',
        firstName: 'Estela',
        lastName: 'Souza',
        email: 'estelasz@hotmail.com',
        photo: "https://www.w3schools.com/howto/img_avatar.png",
        celPhoneNumber: '5511976688302',
        homePhoneNumber: '551130334044',
        workPhoneNumber: '551131771212'));
    users.add(User(
        id: 3,
        documentNumber: '47964001841',
        firstName: 'Paulo',
        lastName: 'Carvalho',
        email: 'paulo_c@hotmail.com',
        photo: "https://www.w3schools.com/howto/img_avatar.png",
        celPhoneNumber: '5511976688302',
        homePhoneNumber: '551130334044',
        workPhoneNumber: '551131771212'));*/
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ContactStore>();
    final state = store.value;

    Widget child = Container();

    if (state is LoadingContactState) {
      child = const Center(
        child: CircularProgressIndicator(color: Colors.purple),
      );
    }

    if (state is ErrorContactState) {
      child = Center(child: Text(state.message));
    }

    if (state is SuccessContactState) {
      child = ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Modular.to
                        .pushNamed('/detail', arguments: state.users[index]),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24.0,
                          backgroundImage:
                              NetworkImage(state.users[index].photo ?? ''),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(width: 16),
                        Text(state.users[index].firstName ?? '-',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Divider(),
                  )
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda Eletrônica'),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(30)),
        child: IconButton(
          onPressed: () => Modular.to.pushNamed('/form'),
          icon: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
