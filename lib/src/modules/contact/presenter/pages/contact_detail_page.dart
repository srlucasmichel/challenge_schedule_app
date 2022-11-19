import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/user.dart';
import '../utils/app_formatters.dart';

class ContactDetailPage extends StatelessWidget {
  final User user;

  ContactDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
              onPressed: () => Modular.to.pushNamed('/form', arguments: user),
              tooltip: 'Editar',
              icon: const Icon(Icons.edit_rounded)),
          IconButton(
              onPressed: () => _deleteContactConfirmation(context),
              tooltip: 'Excluir',
              icon: const Icon(Icons.delete_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _body,
      ),
    );
  }

  Column get _body {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 42.0,
            backgroundImage: NetworkImage(user.photo ?? ''),
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(height: 17),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Center(
            child: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _getLSection(
            type: TypeSection.TEXT,
            label: 'CPF',
            value: AppMaskFormatters.cpf.maskText(user.documentNumber)),
        _getLSection(
            type: TypeSection.TEXT, label: 'E-mail', value: user.email ?? ''),
        _getLSection(
            type: TypeSection.NUMBER,
            label: 'Celular',
            value: user.celPhoneNumber ?? ''),
        _getLSection(
            type: TypeSection.NUMBER,
            label: 'Casa',
            value: user.homePhoneNumber ?? ''),
        _getLSection(
            type: TypeSection.NUMBER,
            label: 'Trabalho',
            value: user.workPhoneNumber ?? ''),
      ],
    );
  }

  Widget _getLSection(
      {required final TypeSection type,
      required final String label,
      required final String value}) {
    if (value.isEmpty) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black45)),
        const SizedBox(height: 2),
        InkWell(
          onTap: () =>
              type == TypeSection.NUMBER ? _makePhoneCall(value) : null,
          child: Text(
              type == TypeSection.NUMBER
                  ? AppMaskFormatters.phone.maskText(value)
                  : value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _deleteContactConfirmation(final BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir este contato?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '+$phoneNumber',
    );
    await launchUrl(launchUri);
  }
}

enum TypeSection { TEXT, NUMBER }
