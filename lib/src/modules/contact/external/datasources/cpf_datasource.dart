import '../../domain/errors/errors.dart';
import '../../infra/datasources/cpf_datasource.dart';
import '../../presenter/utils/http_service.dart';

class CpfDatasource extends ICpfDatasource {
  final IHttpService service;

  CpfDatasource(this.service);

  @override
  Future<String> getCPF() async {
    try {
      final response = await service.post(
          'https://www.4devs.com.br/ferramentas_online.php',
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          data: {'acao': 'gerar_cpf'});

      return response;
    } catch (e, s) {
      throw DatasourceContactException(e.toString(), s);
    }
  }
}
