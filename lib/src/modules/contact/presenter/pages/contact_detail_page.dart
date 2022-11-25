import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/user.dart';
import '../states/contact_delete_state.dart';
import '../stores/contact_delete_store.dart';
import '../utils/app_formatters.dart';
import 'components/app_buttons.dart';
import 'components/app_messengers.dart';
import 'components/image_avatar.dart';
import 'components/page_action_button.dart';
import 'components/row_detail.dart';

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
                  child: _detailBody,
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
                      onClick: () => _confirmDeleteDialog(context)),
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

  Stack get _detailBody {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 30.0),
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
              RowDetail(
                  type: TypeSection.text,
                  label: 'CPF',
                  value: AppMaskFormatters.cpf.maskText(_user.documentNumber),
                  icon: Icons.person_rounded),
              RowDetail(
                  type: TypeSection.text,
                  label: 'E-mail',
                  value: _user.email ?? '',
                  icon: Icons.email_rounded),
              RowDetail(
                  type: TypeSection.number,
                  label: 'Celular',
                  value: _user.cellPhoneNumber ?? '',
                  icon: Icons.phone_rounded),
              RowDetail(
                  type: TypeSection.number,
                  label: 'Casa',
                  value: _user.homePhoneNumber ?? '',
                  icon: Icons.phone_rounded),
              RowDetail(
                  type: TypeSection.number,
                  label: 'Trabalho',
                  value: _user.workPhoneNumber ?? '',
                  icon: Icons.phone_rounded),
            ],
          ),
        ),
        ImageAvatar(
            sizes: {72.0: 28.0}, path: _user.photo, firstName: _user.firstName),
      ],
    );
  }

  Future<void> _confirmDeleteDialog(final BuildContext context) async {
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
              onPressed: () => _deleteData(context),
            ),
          ],
        );
      },
    );
  }

  void _deleteData(final BuildContext context) async {
    final store = context.watch<ContactDeleteStore>();
    await store.delete(_user.id ?? 0);
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
}
