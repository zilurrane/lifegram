import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(uid)),
    );
  }

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid ?? "";
  }
}
