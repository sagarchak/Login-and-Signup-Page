import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/repository/login_repo.dart';

import 'package:test_project/repository/sign_up_repo.dart';
import 'package:test_project/sign_up/sign_up_screen.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Center(
              child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Consumer(builder: (context, ref, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              onChanged: (value) => {email = value},
                              validator: (value) => ref.read(signUpRepoProvider).emailValidator(value),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              obscureText: true,
                              maxLength: 6,
                              onChanged: (value) => {password = value},
                              validator: (value) => ref.read(signUpRepoProvider).passwordValidator(value),
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Processing Data')),
                                      );
                                      ref.read(loginRepoProvider).loginUser(email, password, context);
                                    }
                                  },
                                  child: const Text('Login'),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    ref.read(loginRepoProvider).delete();
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                                  },
                                  child: const Text('SignUp'),
                                ),
                              ],
                            ),
                          ],
                        );
                      })),
                ),
              ),
            ),
          ))),
    );
  }
}
