import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_project/database/database_services.dart';

import 'package:test_project/database/db_helper.dart';
import 'package:test_project/database/entity/UserModel.dart';

import 'package:test_project/home/home_screen.dart';

import 'package:test_project/utils/app_constant.dart';

final loginRepoProvider = Provider((ref) => LoginRepo());

class LoginRepo {
  void loginUser(String emailLocal, String passwordLocal, BuildContext context) async {
    var data = await DbHelper().fetchAllData();

    updateLoginId(data.first);
    data.forEach((element) {
      if (element[email] == emailLocal && element[password] == passwordLocal) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User logged in successfully')),
        );

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User login failed - Please check your credentials')),
        );
      }
    });
  }

  void updateLoginId(user) async {
    var db = await DatabaseServices().database;
    await db.update(tableName, {loginid: 1}, where: '$loginid = ?', whereArgs: [user[loginid]], conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  Future delete() async {
    var db = await DatabaseServices().database;
    return await db.delete(tableName);
  }
}
