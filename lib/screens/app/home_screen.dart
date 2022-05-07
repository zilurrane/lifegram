import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifegram/widgets/bars/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String uid;
  int selectedTabIndex = 0; //New

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 239, 241, 255),
            appBar: const HomeAppBar(),
            bottomNavigationBar: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                  elevation: 0,
                  iconSize: 25,
                  type: BottomNavigationBarType.fixed, // This is all you need!
                  selectedIconTheme: const IconThemeData(size: 30),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Explorer',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: 'Notifications',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: selectedTabIndex, //New
                  onTap: onTabSelection),
            ),
            body: Center(child: Text(uid))));
  }

  void onTabSelection(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid ?? "";
  }
}
