import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:test_project/database/database_services.dart';
import 'package:test_project/utils/app_constant.dart';
import 'package:test_project/splash_screen/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseServices().database;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(link),
        cache: GraphQLCache(),
      ),
    );
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen()));
  }
}
