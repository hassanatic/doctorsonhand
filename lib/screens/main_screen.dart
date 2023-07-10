import 'package:doctors_on_hand/screens/appointment.dart';
import 'package:doctors_on_hand/screens/chat_screen.dart';
import 'package:doctors_on_hand/screens/doctor_detail.dart';
import 'package:doctors_on_hand/screens/home_screen.dart';
import 'package:doctors_on_hand/screens/map.dart';
import 'package:doctors_on_hand/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final screens =[
    HomeScreen(),
    ProfileScreen(),
    MapPage(),
    ChatScreen(),
    SliverDoctorDetail(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: GNav(
        tabBackgroundColor: Colors.grey[850]!,
        backgroundColor: Colors.black,
        selectedIndex: index,
        onTabChange: (index) => setState(() =>
        this.index = index
        ),
tabBorderRadius: 30,
tabMargin: EdgeInsets.all(5.0),
        hoverColor: Colors.grey[100]!,
        rippleColor: Colors.grey[300]!,
        color: Colors.grey,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        activeColor: Colors.white,
        iconSize: 22,
        gap: 5,


       
        tabs: [
          GButton(icon: Icons.home,onPressed: (){

          },
iconActiveColor: Colors.white,


          ),
          GButton(icon: Icons.person,onPressed: (){

          },
            iconActiveColor: Colors.blue,


          ),
          GButton(icon: Icons.map,onPressed: (){

          },
            iconActiveColor: Colors.green,

          ),

          GButton(icon: Icons.chat,onPressed: (){

          },
            iconActiveColor: Colors.red,

          ),
        ],
      ),


    );
  }
}
