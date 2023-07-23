import 'package:doctors_on_hand/screens/doctor_home_screen.dart';
import 'package:doctors_on_hand/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'chat_screen.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));
    super.initState();
  }

  int index = 0;
  final screens = [
    DoctorsHomeScreen(),
    ProfileScreen(),
    ChatScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        extendBody: true,
        bottomNavigationBar: GNav(
            tabBackgroundColor: Colors.grey[850]!,
            backgroundColor: Colors.black,
            selectedIndex: index,
            onTabChange: (index) => setState(() => this.index = index),
            tabBorderRadius: 50,
            tabMargin: EdgeInsets.all(5.0),
            //hoverColor: Colors.grey[100]!,
            // rippleColor: Colors.grey[300]!,
            color: Colors.grey,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            activeColor: Colors.white,
            iconSize: 22,
            gap: 5,
            tabs: [
              GButton(
                icon: Icons.home,
                onPressed: () {},
                iconActiveColor: Colors.white,
              ),
              GButton(
                icon: Icons.person,
                onPressed: () {},
                iconActiveColor: Colors.blue,
              ),
              GButton(
                icon: Icons.chat,
                onPressed: () {},
                iconActiveColor: Colors.blue,
              ),
            ]));
  }
}
