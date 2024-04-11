import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/database/entity/UserModel.dart';

import 'package:test_project/repository/sign_up_repo.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String mobileNumber = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text('Sign Up'),
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
                            onChanged: (value) => {name = value},
                            validator: (value) => ref.read(signUpRepoProvider).nameValidator(value),
                            decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 10),
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
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => {mobileNumber = value},
                            validator: (value) => ref.read(signUpRepoProvider).mobileValidator(value),
                            decoration: const InputDecoration(
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            maxLength: 6,
                            onChanged: (value) => {password = value},
                            validator: (value) => ref.read(signUpRepoProvider).passwordValidator(value),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                                ref.read(signUpRepoProvider).signUpUser(UserModel(name, email, mobileNumber, password, ""), context);
                              }
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      );
                    })),
              ),
            ),
          ),
        )));
  }
}
