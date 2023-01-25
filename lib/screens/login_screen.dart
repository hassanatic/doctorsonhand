import 'package:doctors_on_hand/reuseable_widgets/reuseable_widgets.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:doctors_on_hand/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexToColor("439BFF"),

          hexToColor("7E5BED"),
             // hexToColor("52CCB6"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        // LinearGradient // BoxDecoration
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                Image.asset('assets/images/app_icon.png',color: Colors.white, width: 200,height: 200,fit: BoxFit.fitWidth,),
                verticalHeight(30),
                reusableTextField("Enter Email", Icons.mail_outline, false, _emailTextController),
                verticalHeight(20),
                reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                verticalHeight(20),
                signInSignUpButton(context, true, (){}),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );

  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text ("Don't have account?",
            style: TextStyle(color: Colors.white70)), // Text
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute (builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ), // Text
        ) // GestureDetector
      ],
    ); // Row
  }
}

