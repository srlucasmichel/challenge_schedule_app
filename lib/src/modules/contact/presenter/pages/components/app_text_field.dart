import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType type;
  final String? Function(String? v)? validator;
  final void Function(String v)? onChange;
  final void Function(String v)? onFieldSubmitted;

  const AppTextField(
      {required this.label,
      required this.controller,
      this.focusNode,
      required this.type,
      this.validator,
      this.onChange,
      this.onFieldSubmitted,
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
          focusNode: focusNode,
          keyboardType: type,
          validator: validator,
          textInputAction: onFieldSubmitted == null
              ? TextInputAction.done
              : TextInputAction.next,
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
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
