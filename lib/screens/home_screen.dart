
import 'package:doctors_on_hand/utils/color_utils.dart';
import 'package:doctors_on_hand/utils/size_utils.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: hexToColor("#f8faff"),
        body: Column(
          children: [
Container(
padding: getPadding(
  top: 20,
  bottom: 20,
),
  decoration: BoxDecoration(
      color: hexToColor("#50a7ff"),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0)
      ),
  ),
)
          ],
        ),
      ),
    );
  }
}
