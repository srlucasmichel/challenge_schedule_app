import 'package:fpdart/fpdart.dart';
import 'package:uno/uno.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/user_datasource.dart';

class UsersDatasource implements IUserDatasource {
  final Uno uno;

  UsersDatasource(this.uno);

  @override
  Future<List> getUsers() async {
    try {
      Either<DatasourceContactException, String> cpf;
      final response =
          await uno.get('https://jsonplaceholder.typicode.com/users');
      print("#####|[getUsers]status:${response.status}|#####");
      print("#####|[getUsers]data:${response.data}|#####");

      cpf = await _getCPF();
      if (cpf.isLeft()) {
        throw DatasourceContactException(cpf.getLeft().toString());
      }

      return response.data;
    } catch (e, s) {
      throw DatasourceContactException(e.toString(), s);
    }
  }

  Future<Either<DatasourceContactException, String>> _getCPF() async {
    try {
      Uno unoPost =
          Uno(headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      final response = await unoPost.post(
          'https://www.4devs.com.br/ferramentas_online.php',
          data: {'acao': 'gerar_cpf'});
      print("#####|[_getCPF]status:${response.status}|#####");
      print("#####|[_getCPF]data:${response.data}|#####");
      return right(response.data);
    } catch (e, s) {
      return left(DatasourceContactException(e.toString(), s));
    }
  }
}