import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/database/db_helper.dart';
import 'package:test_project/database/entity/UserModel.dart';
import 'package:test_project/login/login_screen.dart';

final signUpRepoProvider = Provider((ref) => SignUpRepo());

class SignUpRepo {
  String? emailValidator(String? value) {
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final isValidEmail = emailRegExp.hasMatch(value ?? "");
    if (!isValidEmail) {
      return 'Please enter some valid email.';
    }
    return null;
  }

  void signUpUser(UserModel user, BuildContext context) async {
    int id = await DbHelper().insertData(user: user);
    if (id != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User signed up successfully')),
      );
      Future.delayed(const Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User sign up failed')),
      );
    }
  }

  String? passwordValidator(String? value) {
    if (value!.length < 6) {
      return 'Please enter some valid password.';
    }
    return null;
  }

  String? mobileValidator(String? value) {
    RegExp mobileRegExp = RegExp(r'^[0-9]{10}$');
    final isValidMobile = mobileRegExp.hasMatch(value ?? "");
    if (!isValidMobile) {
      return 'Please enter some valid mobile number.';
    }
  }

  String? nameValidator(String? value) {
    if (value!.length < 3) {
      return 'Please enter some valid name.';
    }
    return null;
  }
}
