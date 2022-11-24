import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/user.dart';
import '../states/contact_updates_state.dart';
import '../stores/contact_detail_store.dart';
import '../utils/app_formatters.dart';
import 'components/app_buttons.dart';
import 'components/app_messengers.dart';
import 'components/image_avatar.dart';
import 'components/page_action_button.dart';

class ContactDetailPage extends StatefulWidget {
  final User user;

  const ContactDetailPage({required this.user, Key? key}) : super(key: key);

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  late User _user;

  @override
  void initState() {
    _user = widget.user;
    super.initState();
  }

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
                      onClick: () async {
                        var updatedUser = await Modular.to
                            .pushNamed('/form', arguments: _user);
                        if (updatedUser != null) {
                          setState(() => _user = updatedUser as User);
                        }
                      }),
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
                  '${_user.firstName} ${_user.lastName}',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              _getLSection(
                  type: TypeSection.text,
                  label: 'CPF',
                  value: AppMaskFormatters.cpf.maskText(_user.documentNumber),
                  icon: Icons.person_rounded),
              _getLSection(
                  type: TypeSection.text,
                  label: 'E-mail',
                  value: _user.email ?? '',
                  icon: Icons.email_rounded),
              _getLSection(
                  type: TypeSection.number,
                  label: 'Celular',
                  value: _user.celPhoneNumber ?? '',
                  icon: Icons.contact_phone_rounded),
              _getLSection(
                  type: TypeSection.number,
                  label: 'Casa',
                  value: _user.homePhoneNumber ?? '',
                  icon: Icons.contact_phone_rounded),
              _getLSection(
                  type: TypeSection.number,
                  label: 'Trabalho',
                  value: _user.workPhoneNumber ?? '',
                  icon: Icons.contact_phone_rounded),
            ],
          ),
        ),
        ImageAvatar(_user.photo, size: 72, firstName: _user.firstName),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(icon, size: 19.0, color: Colors.black54),
            const SizedBox(width: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (type == TypeSection.number)
                  InkWell(
                    onTap: () => _makePhoneCall(value),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      child: Text(AppMaskFormatters.phone.maskText(value),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400)),
                    ),
                  )
                else
                  Text(value,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400)),
                const SizedBox(width: 8),
                if (type == TypeSection.number)
                  InkWell(
                    onTap: () => _makePhoneCall(value),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(12, 8, 0, 0),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(Icons.phone_rounded,
                          color: Colors.white, size: 15.0),
                    ),
                  )
              ],
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
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Excluir este contato?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () => _deleteContact(context),
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(BuildContext context) async {
    final store = context.watch<ContactDetailStore>();
    await store.delete(_user.id);
    final state = store.value;

    if (state is SuccessContactDeleteState) {
      Navigator.of(context).pop();
      AppMessengers(context, 'Usuário excluído')
          .showSnackBar(type: SnackBarType.success);
      Modular.to.pop();
    } else if (state is ErrorContactDeleteState) {
      AppMessengers(context, 'Erro ao excluir este usuário')
          .showSnackBar(type: SnackBarType.error);
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: '+$phoneNumber');
    await launchUrl(launchUri);
  }
}

enum TypeSection { text, number }
