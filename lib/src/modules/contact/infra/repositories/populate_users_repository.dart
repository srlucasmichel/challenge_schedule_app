import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/populate_users_repository.dart';
import '../adapters/user_adapter.dart';
import '../datasources/cpf_datasource.dart';
import '../datasources/populate_users_datasource.dart';

class PopulateUsersRepository extends IPopulateUsersRepository {
  final IPopulateUsersDatasource populateUsersDatasource;
  final ICpfDatasource cpfDatasource;

  PopulateUsersRepository(this.populateUsersDatasource, this.cpfDatasource);

  @override
  Future<Either<RepositoryContactException, List<User>>> getUsers() async {
    try {
      final String cpf = await cpfDatasource.getCPF();
      final listUsers = await populateUsersDatasource.getUsers();

      final users =
          listUsers.map((e) => UserAdapter.fromExternalJson(e, cpf)).toList();

      return right(users);
    } catch (e) {
      return left(RepositoryContactException(e.toString()));
    }
  }
}
