import 'package:flutter/material.dart';
import 'package:lifegram/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));
}
