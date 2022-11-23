import '../../domain/errors/errors.dart';
import '../../infra/datasources/populate_users_datasource.dart';
import '../../presenter/utils/http_service.dart';

class PopulateUsersDatasource implements IPopulateUsersDatasource {
  final IHttpService service;

  PopulateUsersDatasource(this.service);

  @override
  Future<List> getUsers() async {
    try {
      final response =
          await service.get('https://jsonplaceholder.typicode.com/users');

      return response;
    } catch (e, s) {
      throw DatasourceContactException(e.toString(), s);
    }
  }
}
