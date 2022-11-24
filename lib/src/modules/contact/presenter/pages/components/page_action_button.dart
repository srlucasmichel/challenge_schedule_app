import 'package:flutter/material.dart';

class PageActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onClick;

  const PageActionButton(
      {required this.label,
      required this.icon,
      required this.onClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon), const SizedBox(height: 3), Text(label)],
        ),
      ),
    );
  }
}
