import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifegram/firebase_options.dart';
import 'package:lifegram/screens/auth/login.dart';
// import 'package:lifegram/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
