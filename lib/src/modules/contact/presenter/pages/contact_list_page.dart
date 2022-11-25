import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../states/contact_list_state.dart';
import '../stores/contact_list_store.dart';
import 'components/image_avatar.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ContactListStore>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<ContactListStore>();
    final state = store.value;

    Widget child = Container();

    if (state is EmptyContactState) {
      child = _getEmptyListInterface;
    }

    if (state is LoadingContactState) {
      child = Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor));
    }

    if (state is ErrorContactState) {
      child = Center(
          child:
              Text(state.message, style: const TextStyle(color: Colors.red)));
    }

    if (state is SuccessContactState) {
      child = Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await Modular.to.pushNamed('/detail',
                            arguments: state.users[index]);
                        context.read<ContactListStore>().fetchUsers();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageAvatar(
                              sizes: {38.0: 16.0},
                              path: state.users[index].photo,
                              firstName: state.users[index].firstName),
                          const SizedBox(width: 16),
                          Text(state.users[index].firstName ?? '-',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Divider(),
                    )
                  ],
                ),
              );
            }),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Contatos (${state is SuccessContactState ? state.users.length : 0})'),
          leading: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
              onPressed: () {},
              tooltip: 'Menu')),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: IconButton(
          onPressed: () async {
            await Modular.to.pushNamed('/form');
            context.read<ContactListStore>().fetchUsers();
          },
          icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromRGBO(221, 221, 232, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: child,
      ),
    );
  }

  Column get _getEmptyListInterface {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('images/undraw_empty_re_opql.png', width: 200),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Nenhum contato por aqui ;)',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54)),
          ],
        )
      ],
    );
  }
}
