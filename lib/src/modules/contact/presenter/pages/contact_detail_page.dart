import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/user.dart';
import '../utils/app_formatters.dart';
import 'components/app_buttons.dart';
import 'components/image_avatar.dart';
import 'components/page_action_button.dart';

class ContactDetailPage extends StatelessWidget {
  final User user;

  const ContactDetailPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 221, 232, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(onBack: () => Modular.to.pop()),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _body,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PageActionButton(
                      label: 'Excluir',
                      icon: Icons.delete_rounded,
                      onClick: () => _deleteContactConfirmation(context)),
                  PageActionButton(
                      label: 'Editar',
                      icon: Icons.edit_rounded,
                      onClick: () =>
                          Modular.to.pushNamed('/form', arguments: user)),
                  PageActionButton(
                      label: 'Compartilhar',
                      icon: Icons.share_rounded,
                      onClick: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack get _body {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 27.0),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 46),
              Center(
                child: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              _getLSection(
                  type: TypeSection.text,
                  label: 'CPF',
                  value: AppMaskFormatters.cpf.maskText(user.documentNumber),
                  icon: Icons.person_rounded),
              _getLSection(
                  type: TypeSection.text,
                  label: 'E-mail',
                  value: user.email ?? '',
                  icon: Icons.email_rounded),
              _getLSection(
                  type: TypeSection.number,
                  label: 'Celular',
                  value: user.celPhoneNumber ?? '',
                  icon: Icons.phone_rounded),
              _getLSection(
                  type: TypeSection.number,
                  label: 'Casa',
                  value: user.homePhoneNumber ?? '',
                  icon: Icons.phone_rounded),
              _getLSection(
                  type: TypeSection.number,
                  label: 'Trabalho',
                  value: user.workPhoneNumber ?? '',
                  icon: Icons.phone_rounded),
            ],
          ),
        ),
        ImageAvatar(user.photo, size: 72, firstName: user.firstName),
      ],
    );
  }

  Widget _getLSection(
      {required final TypeSection type,
      required final String label,
      required final String value,
      required final IconData icon}) {
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
        Row(
          children: [
            Icon(icon, size: 19.0, color: Colors.black54),
            const SizedBox(width: 6),
            InkWell(
              onTap: () =>
                  type == TypeSection.number ? _makePhoneCall(value) : null,
              child: Text(
                  type == TypeSection.number
                      ? AppMaskFormatters.phone.maskText(value)
                      : value,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _deleteContactConfirmation(final BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir este contato?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () => _deleteContact,
            ),
          ],
        );
      },
    );
  }

  void _deleteContact() {
    //todo
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: '+$phoneNumber');
    await launchUrl(launchUri);
  }
}

enum TypeSection { text, number }
