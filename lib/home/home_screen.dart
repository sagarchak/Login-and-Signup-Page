import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_project/database/entity/UserModel.dart';
import 'package:test_project/repository/home_screen_repo.dart';
import 'package:test_project/repository/sign_up_repo.dart';
import 'package:test_project/utils/app_constant.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(stateNotifier);
    final _formKey = GlobalKey<FormState>();
    String email = '';

    String mobileNumber = '';
    String name = '';
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            elevation: 5,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 20, 35, 10), // (left, top, right
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(profile.name,
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15, overflow: TextOverflow.ellipsis)),
                    const SizedBox(height: 10),
                    Text(profile.email,
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15, overflow: TextOverflow.ellipsis)),
                    const SizedBox(height: 10),
                    Text(profile.mobileNumber,
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15, overflow: TextOverflow.ellipsis)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (
                              context,
                            ) {
                              return AlertDialog(
                                content: Form(
                                  key: _formKey,
                                  child: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        TextFormField(
                                          initialValue: profile.name,
                                          onChanged: (value) => {name = value},
                                          validator: (value) => ref.read(signUpRepoProvider).nameValidator(value),
                                          decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          initialValue: profile.email,
                                          onChanged: (value) => {email = value},
                                          validator: (value) => ref.read(signUpRepoProvider).emailValidator(value),
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          initialValue: profile.mobileNumber,
                                          keyboardType: TextInputType.phone,
                                          onChanged: (value) => {mobileNumber = value},
                                          validator: (value) => ref.read(signUpRepoProvider).mobileValidator(value),
                                          decoration: const InputDecoration(
                                            labelText: 'Mobile Number',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                title: const Text("Edit Profile"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          UserModel data = UserModel(name, email, mobileNumber, '', '');

                                          ref.read(stateNotifier.notifier).updateUserProfile(data);

                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Update')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'))
                                ],
                              );
                            }),
                        child: const Text('Edit Profile')),
                  ],
                ),
              ),
            ),
          ),
          const Card(
            margin: EdgeInsets.zero,
            child: Text('   GraphQL API   '),
          ),
          Expanded(
              child: Card(
            margin: const EdgeInsets.all(10),
            child: Query(
                options: QueryOptions(document: gql(query)),
                builder: (QueryResult result, {refetch, fetchMore}) {
                  if (result.data == null) {
                    return result.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(child: Text("Something went wrong!")),
                              ElevatedButton(
                                  onPressed: () {
                                    refetch?.call();
                                  },
                                  child: const Text('Retry'))
                            ],
                          );
                  }
                  return result.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: result.data!['countries'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                tileColor: Colors.amberAccent,
                                title: Text(result.data!['countries'][index]['name']),
                              ),
                            );
                          });
                }),
          )),
        ],
      ),
    );
  }
}
