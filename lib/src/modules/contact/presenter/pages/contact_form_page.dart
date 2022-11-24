import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../domain/entities/user.dart';
import '../states/contact_updates_state.dart';
import '../stores/contact_detail_store.dart';
import '../utils/app_formatters.dart';
import '../validator/cpf_validator.dart';
import 'components/app_buttons.dart';
import 'components/app_messengers.dart';
import 'components/image_avatar.dart';
import 'components/page_action_button.dart';

class ContactFormPage extends StatefulWidget {
  final User? user;

  const ContactFormPage({Key? key, this.user}) : super(key: key);

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _celController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _homeController = TextEditingController();
  XFile? _imageFile;
  List<bool> _showInputsPhone = [false, false, false];

  @override
  void initState() {
    _populate();
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
                      label: 'Cancelar',
                      icon: Icons.cancel_rounded,
                      onClick: () => Modular.to.pop()),
                  PageActionButton(
                      label: 'Salvar',
                      icon: Icons.save_rounded,
                      onClick: () => _validateAndSave(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _validateAndSave(BuildContext ctx) {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      _updateOrInsertContact(ctx);
    }
  }

  Form get _body {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImageAvatar(sizes: {70.0: 12.0}, path: _imageFile?.path),
                GestureDetector(
                  onTap: () async {
                    _imageFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    setState(() {});
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.photo_camera_rounded,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 17),
          _getLSection(
              label: 'Nome',
              controller: _fNameController,
              type: TextInputType.name,
              maskFormatter: null,
              validator: (s) => _fNameController.text.trim().isEmpty
                  ? 'Informe o nome'
                  : null),
          _getLSection(
              label: 'Sobrenome',
              controller: _lNameController,
              type: TextInputType.name,
              maskFormatter: null,
              validator: null),
          _getLSection(
              label: 'CPF*',
              controller: _cpfController,
              type: TextInputType.number,
              maskFormatter: AppMaskFormatters.cpf,
              validator: (s) => CpfValidator.isValid(s)),
          _getLSection(
              label: 'E-mail',
              controller: _emailController,
              type: TextInputType.emailAddress,
              maskFormatter: null,
              validator: null),
          if (_showInputsPhone[0])
            Row(
              children: [
                Expanded(
                  child: _getLSection(
                      label: 'Celular',
                      controller: _celController,
                      type: TextInputType.number,
                      maskFormatter: AppMaskFormatters.phone,
                      validator: null),
                ),
                IconButton(
                    onPressed: () {
                      _showInputsPhone[0] = false;
                      _celController.text = '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove_rounded))
              ],
            )
          else
            const SizedBox(),
          if (_showInputsPhone[2])
            Row(
              children: [
                Expanded(
                  child: _getLSection(
                      label: 'Casa',
                      controller: _homeController,
                      type: TextInputType.number,
                      maskFormatter: AppMaskFormatters.phone,
                      validator: null),
                ),
                IconButton(
                    onPressed: () {
                      _showInputsPhone[2] = false;
                      _homeController.text = '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove_rounded))
              ],
            )
          else
            const SizedBox(),
          if (_showInputsPhone[1])
            Row(
              children: [
                Expanded(
                  child: _getLSection(
                      label: 'Trabalho',
                      controller: _workController,
                      type: TextInputType.number,
                      maskFormatter: AppMaskFormatters.phone,
                      validator: null),
                ),
                IconButton(
                    onPressed: () {
                      _showInputsPhone[1] = false;
                      _workController.text = '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove_rounded))
              ],
            )
          else
            const SizedBox(),
          if (_showInputsPhone.contains(false))
            PopupMenuButton(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('Adicionar telefone')),
              onSelected: (v) {
                switch (v) {
                  case 'work':
                    _showInputsPhone[1] = true;
                    break;
                  case 'home':
                    _showInputsPhone[2] = true;
                    break;
                  default:
                    _showInputsPhone[0] = true;
                }
                setState(() {});
              },
              itemBuilder: (context) {
                List<PopupMenuItem> popupMenuItems = List.empty(growable: true);
                if (!_showInputsPhone[0]) {
                  popupMenuItems.add(const PopupMenuItem(
                    value: 'cel',
                    child: Text("Celular"),
                  ));
                }
                if (!_showInputsPhone[1]) {
                  popupMenuItems.add(const PopupMenuItem(
                    value: 'work',
                    child: Text("Trabalho"),
                  ));
                }
                if (!_showInputsPhone[2]) {
                  popupMenuItems.add(const PopupMenuItem(
                    value: 'home',
                    child: Text("Casa"),
                  ));
                }
                return popupMenuItems;
              },
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }

  Column _getLSection(
      {required String label,
      required TextEditingController controller,
      required TextInputType type,
      required MaskTextInputFormatter? maskFormatter,
      required String? Function(String? v)? validator}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87)),
        const SizedBox(height: 2),
        TextFormField(
          controller: controller,
          focusNode: null,
          keyboardType: type,
          validator: validator,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            filled: true,
          ),
          onChanged: (v) {
            if (maskFormatter != null) {
              controller.text = maskFormatter.maskText(v);
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
            }
          },
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _updateOrInsertContact(BuildContext context) async {
    final store = context.watch<ContactDetailStore>();

    if (widget.user?.id != null) {
      await store.update(_buildUser);
    } else {
      await store.insert(_buildUser);
    }

    final state = store.value;

    if (state is SuccessContactInsertState) {
      AppMessengers(context, 'Usuário cadastrado')
          .showSnackBar(type: SnackBarType.success);
      Modular.to.pop();
    } else if (state is SuccessContactUpdateState) {
      AppMessengers(context, 'Usuário alterado')
          .showSnackBar(type: SnackBarType.success);
      Modular.to.pop(_buildUser);
    } else if (state is ErrorContactInsertState) {
      AppMessengers(context, 'Erro ao cadastrar este usuário')
          .showSnackBar(type: SnackBarType.error);
    } else if (state is ErrorContactUpdateState) {
      AppMessengers(context, 'Erro ao alterar este usuário')
          .showSnackBar(type: SnackBarType.error);
    }
  }

  User get _buildUser {
    return User(
      id: widget.user?.id,
      documentNumber: _cpfController.text,
      firstName: _fNameController.text,
      lastName: _lNameController.text,
      email: _emailController.text,
      photo: _imageFile?.path,
      celPhoneNumber: _celController.text,
      workPhoneNumber: _workController.text,
      homePhoneNumber: _homeController.text,
    );
  }

  void _populate() {
    if (widget.user?.id != null) {
      _fNameController.text = widget.user?.firstName ?? '';
      _lNameController.text = widget.user?.lastName ?? '';
      _cpfController.text =
          AppMaskFormatters.cpf.maskText(widget.user?.documentNumber ?? '');
      _emailController.text = widget.user?.email ?? '';
      _celController.text =
          AppMaskFormatters.phone.maskText(widget.user?.celPhoneNumber ?? '');
      _workController.text =
          AppMaskFormatters.phone.maskText(widget.user?.workPhoneNumber ?? '');
      _homeController.text =
          AppMaskFormatters.phone.maskText(widget.user?.homePhoneNumber ?? '');
      if (widget.user?.photo != null) {
        _imageFile = XFile(widget.user!.photo!);
      }
      if (_celController.text.trim().isNotEmpty) {
        _showInputsPhone[0] = true;
      }
      if (_workController.text.trim().isNotEmpty) {
        _showInputsPhone[1] = true;
      }
      if (_homeController.text.trim().isNotEmpty) {
        _showInputsPhone[2] = true;
      }
      if (!_showInputsPhone.contains(true)) {
        _showInputsPhone[0] = true;
      }
    }
  }
}
