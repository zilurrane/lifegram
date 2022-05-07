import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifegram/screens/app/stories_screen.dart';
import 'package:lifegram/widgets/bars/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String uid;
  int _selectedTabIndex = 0; //New

  PageController pageController = PageController();

  void onTabSelection(int index) {
    pageController.jumpToPage(index);
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedTabIndex = page;
    });
  }

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

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
                currentIndex: _selectedTabIndex, //New
                onTap: onTabSelection),
          ),
          body: PageView(
            children: const [
              StoriesScreen(),
              Center(
                child: Text("Explorer"),
              ),
              Center(
                child: Text("Notifications"),
              ),
              Center(
                child: Text("Profile"),
              ),
            ],
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
          ),
        ));
  }
}
