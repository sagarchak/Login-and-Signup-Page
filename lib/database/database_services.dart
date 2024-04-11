import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_project/database/db_helper.dart';
import 'package:test_project/utils/app_constant.dart';

class DatabaseServices {
  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  Future<String> get fullPath async {
    var path = await getDatabasesPath();
    return join(path, namePath);
  }

  Future<Database> _initDB() async {
    var path = await fullPath;
    var database = await openDatabase(path, version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database db, int version) async => await DbHelper().createTable(db);
}
