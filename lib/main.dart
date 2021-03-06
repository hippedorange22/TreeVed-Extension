import 'dart:async';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:treeved/providers/user_provider.dart';
import 'package:treeved/routes/routes.dart';
import 'package:treeved/src/screens/add_resource_screen.dart';
import 'package:treeved/src/screens/homepage.dart';
import 'package:treeved/src/screens/login_screen.dart';
import 'package:treeved/src/screens/privacy_policy_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'providers/list_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ListNotifier()),
    ], child: Phoenix(child: const MyApp())));
  }, (Object errorMain, StackTrace stack) async {
    String errorToSend = "The Error found is $errorMain and the StackTrace is $stack";
    print(errorToSend);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        home: MyHomePage(),
        initialRoute: "/",
        routes: {
          Routes.login: (context) => LoginScreen(),
          Routes.add_respurce_screen: (context) => AddResourceScreen(),
          Routes.privacy_policy: (context) => PrivacyPolicyScreen(isMainScreen: true),
        },
        debugShowCheckedModeBanner: false,
        title: "TreeVed",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
