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
  Future<Either<IUserException, int>> insertUser(final User user) async {
    try {
      return right(
          await _db.insert(UserAdapter.tableName, UserAdapter().toJson(user)));
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, int>> insertUsers(
      final List<User> users) async {
    try {
      await _getDbInstance();
      int inserted = 0;

      await _db.transaction((txn) async {
        var batch = txn.batch();

        for (User user in users) {
          batch.insert(UserAdapter.tableName, UserAdapter().toJson(user));
        }

        inserted = (await batch.commit(noResult: true)).length;
      });

      return right(inserted);
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, List<User>>> getUsers() async {
    try {
      await _getDbInstance();
      List<User> list = [];

      List<Map> maps = await _db.query(UserAdapter.tableName,
          columns: [
            UserAdapter.columnId,
            UserAdapter.columnFirstName,
            UserAdapter.columnLastName,
            UserAdapter.columnDocumentNumber,
            UserAdapter.columnEmail,
            UserAdapter.columnPhoto,
            UserAdapter.columnCellPhoneNumber,
            UserAdapter.columnWorkPhoneNumber,
            UserAdapter.columnHomePhoneNumber
          ],
          orderBy: '${UserAdapter.columnFirstName} COLLATE NOCASE');

      if (maps.isNotEmpty) list = UserAdapter.fromJsonList(maps);

      return right(list);
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, int>> deleteUser(
      {required final int userId}) async {
    try {
      return right(await _db.delete(UserAdapter.tableName,
          where: '${UserAdapter.columnId} = ?', whereArgs: [userId]));
    } on IUserException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IUserException, int>> updateUser(final User user) async {
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
