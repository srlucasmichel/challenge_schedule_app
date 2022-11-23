import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/populate_users_repository.dart';
import 'domain/usecases/get_users_api.dart';
import 'external/datasources/cpf_datasource.dart';
import 'external/datasources/populate_users_datasource.dart';
import 'infra/datasources/cpf_datasource.dart';
import 'infra/datasources/populate_users_datasource.dart';
import 'infra/repositories/populate_users_repository.dart';
import 'presenter/pages/contact_detail_page.dart';
import 'presenter/pages/contact_form_page.dart';
import 'presenter/pages/contact_list_page.dart';
import 'presenter/stores/contact_store.dart';
import 'presenter/utils/http_service.dart';

class ContactModule extends Module {
  @override
  List<Bind> get binds => [
        //utils
        Bind.factory((i) => DioClient(Dio())),
        //datasource
        Bind.factory<IPopulateUsersDatasource>(
            (i) => PopulateUsersDatasource(i())),
        Bind.factory<ICpfDatasource>((i) => CpfDatasource(i())),
        //repository
        Bind.factory<IPopulateUsersRepository>(
            (i) => PopulateUsersRepository(i(), i())),
        //usecase
        Bind.factory((i) => GetUsersApi(i())),
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
