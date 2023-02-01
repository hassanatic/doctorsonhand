import 'package:doctors_on_hand/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        activeColor: Colors.white,
        tabs: [
          GButton(icon: Icons.home_outlined,onPressed: (){

          },),
          GButton(icon: Icons.map_outlined,onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapScreen()));
          },),
        ],
      ),
      appBar: AppBar(title: Text("Home"),

      ),
      body: Center(

        child: Text("Welcome to homepage"),
      ),
    );
  }
}
