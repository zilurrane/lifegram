import 'package:flutter/material.dart';
import 'package:lifegram/screens/auth/login_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
