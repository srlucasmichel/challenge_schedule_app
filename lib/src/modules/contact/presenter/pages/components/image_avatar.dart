import 'dart:io';

import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  final String? path;
  final double? size;
  final String? firstName;

  const ImageAvatar(this.path, {Key? key, this.size, this.firstName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.trim().isEmpty) {
      return Container(
        width: size ?? 39.0,
        height: size ?? 39.0,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 200, 234, 1),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Text(_firstLetterName,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: 16.0))),
      );
    }
    return CircleAvatar(
      radius: 24.0,
      backgroundImage: FileImage(File(path!)),
      backgroundColor: Colors.grey.shade400,
    );
  }

  String get _firstLetterName {
    if (firstName != null && firstName!.trim().isNotEmpty) {
      return firstName!.toUpperCase().substring(0, 1);
    }
    return '-';
  }
}
