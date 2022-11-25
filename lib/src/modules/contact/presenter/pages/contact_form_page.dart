import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/user.dart';
import '../states/contact_form_state.dart';
import '../stores/contact_form_store.dart';
import '../utils/app_formatters.dart';
import '../validator/cpf_validator.dart';
import 'components/app_buttons.dart';
import 'components/app_messengers.dart';
import 'components/app_text_field.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cellPhoneController = TextEditingController();
  final TextEditingController _workPhoneController = TextEditingController();
  final TextEditingController _homePhoneController = TextEditingController();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _documentFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  XFile? _profileImageFile;
  final List<bool> _phoneTextFieldVisibility = [false, false, false];

  @override
  void initState() {
    _userToFields();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _documentController.dispose();
    _emailController.dispose();
    _cellPhoneController.dispose();
    _workPhoneController.dispose();
    _homePhoneController.dispose();
    _lastNameFocusNode.dispose();
    _documentFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
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
                  child: _bodyForm,
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

  Form get _bodyForm {
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
                ImageAvatar(sizes: {70.0: 12.0}, path: _profileImageFile?.path),
                GestureDetector(
                  onTap: () async {
                    _profileImageFile = await ImagePicker()
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
          AppTextField(
              label: 'Nome',
              controller: _firstNameController,
              type: TextInputType.name,
              validator: (s) => _firstNameController.text.trim().isEmpty
                  ? 'Informe o nome'
                  : null,
              onFieldSubmitted: (s) => _lastNameFocusNode.requestFocus()),
          AppTextField(
              label: 'Sobrenome',
              controller: _lastNameController,
              focusNode: _lastNameFocusNode,
              type: TextInputType.name,
              onFieldSubmitted: (s) => _documentFocusNode.requestFocus()),
          AppTextField(
              label: 'CPF*',
              controller: _documentController,
              focusNode: _documentFocusNode,
              type: TextInputType.number,
              validator: (s) => CpfValidator.getError(s),
              onChange: (v) {
                _documentController.text = AppMaskFormatters.cpf.maskText(v);
                _documentController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _documentController.text.length));
              },
              onFieldSubmitted: (s) => _emailFocusNode.requestFocus()),
          AppTextField(
              label: 'E-mail',
              controller: _emailController,
              focusNode: _emailFocusNode,
              type: TextInputType.emailAddress),
          if (_phoneTextFieldVisibility[PhoneTextFieldType.cellPhone.index])
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                      label: 'Celular',
                      controller: _cellPhoneController,
                      type: TextInputType.number,
                      onChange: (v) {
                        _cellPhoneController.text =
                            AppMaskFormatters.phone.maskText(v);
                        _cellPhoneController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _cellPhoneController.text.length));
                      }),
                ),
                IconButton(
                    onPressed: () {
                      _phoneTextFieldVisibility[
                          PhoneTextFieldType.cellPhone.index] = false;
                      _cellPhoneController.text = '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove_rounded))
              ],
            )
          else
            const SizedBox(),
          if (_phoneTextFieldVisibility[PhoneTextFieldType.home.index])
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                      label: 'Casa',
                      controller: _homePhoneController,
                      type: TextInputType.number,
                      onChange: (v) {
                        _homePhoneController.text =
                            AppMaskFormatters.phone.maskText(v);
                        _homePhoneController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _homePhoneController.text.length));
                      }),
                ),
                IconButton(
                    onPressed: () {
                      _phoneTextFieldVisibility[PhoneTextFieldType.home.index] =
                          false;
                      _homePhoneController.text = '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove_rounded))
              ],
            )
          else
            const SizedBox(),
          if (_phoneTextFieldVisibility[PhoneTextFieldType.work.index])
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                      label: 'Trabalho',
                      controller: _workPhoneController,
                      type: TextInputType.number,
                      onChange: (v) {
                        _workPhoneController.text =
                            AppMaskFormatters.phone.maskText(v);
                        _workPhoneController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: _workPhoneController.text.length));
                      }),
                ),
                IconButton(
                    onPressed: () {
                      _phoneTextFieldVisibility[PhoneTextFieldType.work.index] =
                          false;
                      _workPhoneController.text = '';
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove_rounded))
              ],
            )
          else
            const SizedBox(),
          if (_phoneTextFieldVisibility.contains(false))
            _getPhonePopupMenuButton
          else
            const SizedBox(),
        ],
      ),
    );
  }

  Widget get _getPhonePopupMenuButton {
    return PopupMenuButton(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5)),
          child: const Text('Adicionar telefone')),
      onSelected: (v) {
        switch (v) {
          case PhoneTextFieldType.work:
            _phoneTextFieldVisibility[PhoneTextFieldType.work.index] = true;
            break;
          case PhoneTextFieldType.home:
            _phoneTextFieldVisibility[PhoneTextFieldType.home.index] = true;
            break;
          default:
            _phoneTextFieldVisibility[PhoneTextFieldType.cellPhone.index] =
                true;
        }
        setState(() {});
      },
      itemBuilder: (context) {
        List<PopupMenuItem> popupMenuItems = List.empty(growable: true);
        if (!_phoneTextFieldVisibility[PhoneTextFieldType.cellPhone.index]) {
          popupMenuItems.add(const PopupMenuItem(
            value: PhoneTextFieldType.cellPhone,
            child: Text("Celular"),
          ));
        }
        if (!_phoneTextFieldVisibility[PhoneTextFieldType.work.index]) {
          popupMenuItems.add(const PopupMenuItem(
            value: PhoneTextFieldType.work,
            child: Text("Trabalho"),
          ));
        }
        if (!_phoneTextFieldVisibility[PhoneTextFieldType.home.index]) {
          popupMenuItems.add(const PopupMenuItem(
            value: PhoneTextFieldType.home,
            child: Text("Casa"),
          ));
        }
        return popupMenuItems;
      },
    );
  }

  void _validateAndSave(final BuildContext ctx) {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      _saveData(ctx);
    }
  }

  void _saveData(final BuildContext context) async {
    final store = context.watch<ContactFormStore>();

    if (widget.user?.id != null) {
      await store.update(_getUser);
    } else {
      await store.insert(_getUser);
    }

    final state = store.value;

    if (state is SuccessContactInsertState) {
      AppMessengers(context, 'Usuário cadastrado')
          .showSnackBar(type: SnackBarType.success);
      Modular.to.pop();
    } else if (state is SuccessContactUpdateState) {
      AppMessengers(context, 'Usuário alterado')
          .showSnackBar(type: SnackBarType.success);
      Modular.to.pop(_getUser);
    } else if (state is ErrorContactInsertState) {
      AppMessengers(context, 'Erro ao cadastrar este usuário')
          .showSnackBar(type: SnackBarType.error);
    } else if (state is ErrorContactUpdateState) {
      AppMessengers(context, 'Erro ao alterar este usuário')
          .showSnackBar(type: SnackBarType.error);
    }
  }

  void _userToFields() {
    if (widget.user?.id != null) {
      _firstNameController.text = widget.user?.firstName ?? '';
      _lastNameController.text = widget.user?.lastName ?? '';
      _documentController.text =
          AppMaskFormatters.cpf.maskText(widget.user?.documentNumber ?? '');
      _emailController.text = widget.user?.email ?? '';
      _cellPhoneController.text =
          AppMaskFormatters.phone.maskText(widget.user?.cellPhoneNumber ?? '');
      _workPhoneController.text =
          AppMaskFormatters.phone.maskText(widget.user?.workPhoneNumber ?? '');
      _homePhoneController.text =
          AppMaskFormatters.phone.maskText(widget.user?.homePhoneNumber ?? '');
      if (widget.user?.photo != null) {
        _profileImageFile = XFile(widget.user!.photo!);
      }
    }
    _setInitialVisibility();
  }

  void _setInitialVisibility() {
    if (widget.user?.id != null) {
      if (_cellPhoneController.text.trim().isNotEmpty) {
        _phoneTextFieldVisibility[PhoneTextFieldType.cellPhone.index] = true;
      }
      if (_workPhoneController.text.trim().isNotEmpty) {
        _phoneTextFieldVisibility[PhoneTextFieldType.work.index] = true;
      }
      if (_homePhoneController.text.trim().isNotEmpty) {
        _phoneTextFieldVisibility[PhoneTextFieldType.home.index] = true;
      }
    }
    if (!_phoneTextFieldVisibility.contains(true)) {
      _phoneTextFieldVisibility[PhoneTextFieldType.cellPhone.index] = true;
    }
  }

  User get _getUser {
    return User(
      id: widget.user?.id,
      documentNumber: _documentController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      photo: _profileImageFile?.path,
      cellPhoneNumber: _cellPhoneController.text,
      workPhoneNumber: _workPhoneController.text,
      homePhoneNumber: _homePhoneController.text,
    );
  }
}

enum PhoneTextFieldType { cellPhone, work, home }
