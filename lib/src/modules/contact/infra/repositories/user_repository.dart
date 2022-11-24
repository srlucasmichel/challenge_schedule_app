import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/user.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/user_repository.dart';
import '../adapters/user_adapter.dart';
import '../datasources/local/dbconfig.dart';

class UserRepository extends IUserRepository {
  late Database _db;

  UserRepository() {
    _getDbInstance();
  }

  Future<void> _getDbInstance() async => _db = await DbConfig.getInstance();

  @override
  Future<Either<IUserException, int>> insertUser(User user) async {
    try {
      return right(
          await _db.insert(UserAdapter.tableName, UserAdapter().toJson(user)));
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, void>> insertUsers(List<User> users) async {
    try {
      await _getDbInstance();

      await _db.transaction((txn) async {
        var batch = txn.batch();

        for (User user in users) {
          batch.insert(UserAdapter.tableName, UserAdapter().toJson(user));
        }

        await batch.commit(noResult: true);
      });
      return right(0);
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, List<User>>> getUsers() async {
    try {
      await _getDbInstance();
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
  Future<Either<IUserException, void>> deleteUser({required int userId}) async {
    try {
      await _db.delete(UserAdapter.tableName,
          where: '${UserAdapter.columnId} = ?', whereArgs: [userId]);
      return right(0);
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, int>> updateUser(User user) async {
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
