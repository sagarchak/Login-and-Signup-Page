import 'package:sqflite/sqflite.dart';
import 'package:test_project/database/database_services.dart';
import 'package:test_project/database/entity/UserModel.dart';
import 'package:test_project/utils/app_constant.dart';

class DbHelper {
  Future<void> createTable(
    Database db,
  ) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tableName ( $name TEXT NOT NULL, $email TEXT NOT NULL, $mobileNumber TEXT NOT NULL, $password TEXT NOT NUll,$loginid TEXT NOT NULL)');
  }

  Future<int> insertData({required UserModel user}) async {
    var db = await DatabaseServices().database;
    return await db
        .rawInsert('''INSERT INTO $tableName( $name, $email, $mobileNumber, $password, $loginid) VALUES(?,?,?,?,?)''', user.toJson().values.toList());
  }

  Future<List<Map<String, Object?>>> fetchAllData() async {
    var db = await DatabaseServices().database;
    final data = await db.query(tableName);

    return data;
  }
}
