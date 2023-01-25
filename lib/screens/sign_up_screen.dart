import 'package:doctors_on_hand/reuseable_widgets/reuseable_widgets.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List _roles = ["doctor", "patient"];
  int _selectedRole = 0;
  TextEditingController _nameTextController = new TextEditingController();
   TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ), // Text
      ), // AppBar
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexToColor("439BFF"),

          hexToColor("7E5BED"),
          // hexToColor("52CCB6"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(

              children: [
                verticalSpace(20),
                reusableTextField("Enter Name", Icons.person_outline, false, _nameTextController),
                verticalSpace(20),
                reusableTextField("Enter Email", Icons.mail_outline, false, _emailTextController),
                verticalSpace(20),
                reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                verticalSpace(20),
Row(

  children: [
    Text("You are signing as? "),
        CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      scrollController: FixedExtentScrollController(initialItem: 1),
      itemExtent: 30,
      onSelectedItemChanged: (int selectedItem){
      setState(() {
        _selectedRole = selectedItem;
      });
    },
      children: [
        Text("doctor"),
        Text("patient"),
      ],
    ),
  ],
),

                verticalSpace(20),
                signInSignUpButton(context, false, (){}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
