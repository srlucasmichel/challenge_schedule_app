import 'package:sqflite/sqflite.dart';

import '../../../adapters/user_adapter.dart';

class DbConfig {
  static Database? _db;

  static Future<Database> getInstance() async {
    if (_db == null) {
      _db = await openDatabase('my_db.db', version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(UserAdapter.createTableQuery());
      });
    }

    return _db!;
  }

  static close() async {
    await _db!.close();
  }
}
