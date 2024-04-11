import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/database/db_helper.dart';
import 'package:test_project/database/entity/UserModel.dart';

final authControllerProvider = Provider((ref) {
  return GeneralController();
});
final generalControllerProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider);
  return await authController.getUserData();
});

class GeneralController {
  Future getUserData() async {
    var userModel = await DbHelper().fetchAllData();
    return userModel;
  }
}
