import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../domain/entities/user.dart';
import '../../../../../domain/errors/errors.dart';
import '../../../../../domain/repositories/user_repository.dart';
import '../../../../adapters/user_adapter.dart';
import '../../../../datasources/user_datasource.dart';
import '../dbconfig.dart';

class UserRepository extends IUserRepository {
  late Database _db;
  final IUserDatasource userDatasource;

  UserRepository(this.userDatasource) {
    _getDbInstance();
  }

  void _getDbInstance() async => _db = await DbConfig.getInstance();

  @override
  Future<Either<IUserException, int>> createUser(User user) async {
    try {
      return right(
          await _db.insert(UserAdapter.tableName, UserAdapter().toJson(user)));
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, List<User>>> getUsers() async {
    try {
      List<User> list = [];

      List<Map> maps = await _db.query(UserAdapter.tableName, columns: [
        UserAdapter.columnId,
        UserAdapter.columnFirstName,
        UserAdapter.columnLastName,
        UserAdapter.columnDocumentNumber,
        UserAdapter.columnEmail,
        UserAdapter.columnPhoto,
        UserAdapter.columnCelPhoneNumber,
        UserAdapter.columnWorkPhoneNumber,
        UserAdapter.columnHomePhoneNumber
      ]);

      if (maps.isNotEmpty) list = UserAdapter.fromJsonList(maps);

      return right(list);
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, int>> deleteUser({required int userId}) async {
    try {
      return right(await _db.delete(UserAdapter.tableName,
          where: '${UserAdapter.columnId} = ?', whereArgs: [id]));
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, int>> changeUser(User user) async {
    try {
      return right(await _db.update(
          UserAdapter.tableName, UserAdapter().toJson(user),
          where: '${UserAdapter.columnId} = ?', whereArgs: [user.id]));
    } on IUserException catch (e) {
      return left(e);
    }
  }

  Future close() async => _db.close();
}
