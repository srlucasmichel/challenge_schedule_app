import 'package:flutter_modular/flutter_modular.dart';
import 'package:uno/uno.dart';

import 'domain/repositories/user_repository.dart';
import 'infra/data/sources/local/daos/user_dao.dart';
import 'presenter/pages/contact_detail_page.dart';
import 'presenter/pages/contact_form_page.dart';
import 'presenter/pages/contact_list_page.dart';

class ContactModule extends Module {
  @override
  List<Bind> get binds => [
        //utils
        Bind.factory((i) => Uno()),
        //datasource

        //repository
        Bind.factory<IUserRepository>((i) => UserRepository(i())),

        //usecase

        //store


      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => ContactListPage()),
        ChildRoute('/detail',
            child: (context, args) => ContactDetailPage(user: args.data)),
        ChildRoute('/form',
            child: (context, args) => ContactFormPage(user: args.data)),
      ];
}
