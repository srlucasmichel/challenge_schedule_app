import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final MaskTextInputFormatter? maskFormatter;
  final String? Function(String? v)? validator;

  const AppTextField(
      {required this.label,
      required this.controller,
      required this.type,
      required this.maskFormatter,
      required this.validator,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            filled: true,
          ),
          onChanged: (v) {
            if (maskFormatter != null) {
              controller.text = maskFormatter!.maskText(v);
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
}
