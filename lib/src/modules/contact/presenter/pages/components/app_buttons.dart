import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onBack;

  const AppBackButton({required this.onBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Voltar',
      child: InkWell(
        onTap: onBack,
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 8, 0, 0),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ]),
          child: const Icon(Icons.chevron_left_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
