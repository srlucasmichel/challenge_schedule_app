import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/modules/contact/contact_module.dart';

void main() {
  runApp(ModularApp(module: ContactModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Agenda Eletrônica',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
