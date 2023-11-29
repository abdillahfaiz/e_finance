import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/presentation/acc_screen.dart';
import 'package:wallet_app/presentation/home_screen.dart';
import 'package:wallet_app/theme/app_color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<IconData> iconList = [
    Icons.home,
    Icons.settings,
    Icons.history,
    Icons.person,
  ];

  int _bottomNavIndex = 0;

  final List<Widget> _widgetOptions = const [
    HomeScreen(),
    Center(child: Text('Setting')),
    Center(child: Text('History')),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        backgroundColor: Color(0xff351B6F),
        onPressed: () {},
      ),
      body: _widgetOptions.elementAt(_bottomNavIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: AppColor.primaryColor1,
        backgroundColor: AppColor.primaryColor2,
        inactiveColor: Colors.white,
        icons: iconList,
        height: 80,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}
