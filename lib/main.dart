import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/modules/contact/contact_module.dart';

void main() {
  runApp(
    ModularApp(
      module: ContactModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Agenda Eletrônica',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF94242D, {
          50: Color.fromRGBO(148, 36, 45, .1),
          100: Color.fromRGBO(148, 36, 45, .2),
          200: Color.fromRGBO(148, 36, 45, .3),
          300: Color.fromRGBO(148, 36, 45, .4),
          400: Color.fromRGBO(148, 36, 45, .5),
          500: Color.fromRGBO(148, 36, 45, .6),
          600: Color.fromRGBO(148, 36, 45, .7),
          700: Color.fromRGBO(148, 36, 45, .8),
          800: Color.fromRGBO(148, 36, 45, .9),
          900: Color.fromRGBO(148, 36, 45, 1),
        }),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
