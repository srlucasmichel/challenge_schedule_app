import 'dart:io';

import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  final Map<double, double> sizes;
  final String? path;
  final String? firstName;

  const ImageAvatar({Key? key, required this.sizes, this.path, this.firstName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.trim().isEmpty) {
      return Container(
        width: sizes.keys.first,
        height: sizes.keys.first,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 200, 234, 1),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Text(_firstLetterName,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: sizes.values.first))),
      );
    }
    return SizedBox(
      width: sizes.keys.first,
      height: sizes.keys.first,
      child: CircleAvatar(
        radius: 24.0,
        backgroundImage: FileImage(File(path!)),
        backgroundColor: Colors.grey.shade400,
      ),
    );
  }

  String get _firstLetterName {
    if (firstName != null && firstName!.trim().isNotEmpty) {
      return firstName!.toUpperCase().substring(0, 1);
    }
    return '-';
  }
}
