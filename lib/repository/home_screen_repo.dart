import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/database/database_services.dart';
import 'package:test_project/database/db_helper.dart';
import 'package:test_project/database/entity/UserModel.dart';
import 'package:test_project/utils/app_constant.dart';

final stateNotifier = StateNotifierProvider<HomeScreenRepo, UserModel>((ref) {
  return HomeScreenRepo()..getUserData();
});

class HomeScreenRepo extends StateNotifier<UserModel> {
  HomeScreenRepo() : super(UserModel('', '', '', '', ''));
  void updateUserProfile(UserModel data) async {
    var db = await DatabaseServices().database;
    await db.update(tableName, userData(data));
    getUserData();
  }

  getUserData() async {
    final data = await DbHelper().fetchAllData();
    var userModel = UserModel.fromJson(data.first);
    state = userModel;
  }

  Map<String, Object?> userData(UserModel data) {
    return {
      if (data.name.isNotEmpty) name: data.name,
      if (data.email.isNotEmpty) email: data.email,
      if (data.mobileNumber.isNotEmpty) mobileNumber: data.mobileNumber
    };
  }
}
