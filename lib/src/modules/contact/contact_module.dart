import 'package:challenge_schedule_app/src/modules/contact/presenter/stores/contact_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uno/uno.dart';

import 'domain/repositories/user_repository.dart';
import 'domain/usecases/change_user.dart';
import 'domain/usecases/create_user.dart';
import 'domain/usecases/delete_user.dart';
import 'domain/usecases/get_users.dart';
import 'external/datasources/users_datasource.dart';
import 'infra/data/sources/local/daos/user_dao.dart';
import 'infra/datasources/user_datasource.dart';
import 'presenter/pages/contact_detail_page.dart';
import 'presenter/pages/contact_form_page.dart';
import 'presenter/pages/contact_list_page.dart';

class ContactModule extends Module {
  @override
  List<Bind> get binds => [
        //utils
        Bind.factory((i) => Uno()),
        //datasource
        Bind.factory<IUserDatasource>((i) => UsersDatasource(i())),
        //repository
        Bind.factory<IUserRepository>((i) => UserRepository(i())),
        //usecase
        Bind.factory((i) => ChangeUser(i())),
        Bind.factory((i) => CreateUser(i())),
        Bind.factory((i) => DeleteUser(i())),
        Bind.factory((i) => GetUsers(i())),
        //store
        Bind.singleton((i) => ContactStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ContactListPage()),
        ChildRoute('/detail',
            child: (context, args) => ContactDetailPage(user: args.data)),
        ChildRoute('/form',
            child: (context, args) => ContactFormPage(user: args.data)),
      ];
}
