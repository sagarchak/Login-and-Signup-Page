import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/controller/general_controller.dart';
import 'package:test_project/database/entity/UserModel.dart';
import 'package:test_project/home/home_screen.dart';
import 'package:test_project/login/login_screen.dart';
import 'package:test_project/sign_up/sign_up_screen.dart';
import 'package:test_project/utils/app_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Consumer(builder: (context, ref, child) {
      return ref.watch(generalControllerProvider).when(
            data: (data) {
              if (data.isNotEmpty && data != null) {
                if (data[0][loginid].isEmpty) {
                  return Login();
                } else {
                  return MainScreen();
                }
              }
              return SignUp();
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          );
    })));
  }
}
