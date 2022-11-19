import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../domain/entities/user.dart';
import '../utils/app_formatters.dart';
import '../validator/cpf_validator.dart';

class ContactFormPage extends StatefulWidget {
  final User? user;

  const ContactFormPage({Key? key, this.user}) : super(key: key);

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _celController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _homeController = TextEditingController();
  XFile? _imageFile;

  @override
  void initState() {
    _populate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white70)),
              child: const Text('Salvar',
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12)
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              _imageFile == null
                  ? CircleAvatar(
                      radius: 42.0,
                      backgroundImage: NetworkImage(widget.user?.photo ?? ''),
                      backgroundColor: Colors.grey.shade400,
                    )
                  : CircleAvatar(
                      radius: 42.0,
                      backgroundImage: FileImage(File(_imageFile?.path ?? '')),
                      backgroundColor: Colors.grey.shade400,
                    ),
              GestureDetector(
                onTap: () async {
                  _imageFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
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
                          size: 22,
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
            validator: (s) =>
                _fNameController.text.trim().isEmpty ? 'Informe o nome' : null),
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
        _getLSection(
            label: 'Celular',
            controller: _celController,
            type: TextInputType.number,
            maskFormatter: AppMaskFormatters.phone,
            validator: null),
        _getLSection(
            label: 'Casa',
            controller: _homeController,
            type: TextInputType.number,
            maskFormatter: AppMaskFormatters.phone,
            validator: null),
        _getLSection(
            label: 'Trabalho',
            controller: _workController,
            type: TextInputType.number,
            maskFormatter: AppMaskFormatters.phone,
            validator: null),
      ],
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
                color: Colors.black45)),
        const SizedBox(height: 2),
        TextFormField(
          controller: controller,
          focusNode: null,
          keyboardType: type,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
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

  void _populate() {
    if (widget.user?.id != null) {
      _fNameController.text = widget.user?.firstName ?? '';
      _lNameController.text = widget.user?.lastName ?? '';
      _cpfController.text =
          AppMaskFormatters.cpf.maskText(widget.user?.documentNumber ?? '');
      _emailController.text = widget.user?.email ?? '';
      _celController.text =
          AppMaskFormatters.cpf.maskText(widget.user?.celPhoneNumber ?? '');
      _workController.text =
          AppMaskFormatters.cpf.maskText(widget.user?.workPhoneNumber ?? '');
      _homeController.text =
          AppMaskFormatters.cpf.maskText(widget.user?.homePhoneNumber ?? '');
    }
  }
}
