import 'package:doctors_on_hand/apis/apis.dart';
import 'package:doctors_on_hand/reuseable_widgets/reuseable_widgets.dart';
import 'package:doctors_on_hand/screens/main_screen.dart';
import 'package:doctors_on_hand/screens/sign_up_screen.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _signInWithEmailAndPassword() async {
    final email = _emailTextController.text.trim();
    final password = _passwordTextController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save the user token after successful authentication
      String token = await userCredential.user!.getIdToken();
      await APIs.saveUserToken(token);

      // Authentication successful, navigate back to the chat screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      print('Error signing in: $e');
      // Show a snackbar or an error dialog to inform the user about the login error
    }
  }

  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                  Image.asset(
                    'assets/images/app_icon.png',
                    color: Colors.white,
                    width: 200,
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ),
                  verticalSpace(30),
                  reusableTextField("Enter Email", Icons.mail_outline, false,
                      _emailTextController),
                  verticalSpace(20),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  verticalSpace(20),
                  signInSignUpButton(context, true, () {
                    _signInWithEmailAndPassword();
                    //
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => HomeScreen()));
                  }),
                  signUpOption(),
                ],
              ),
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
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)), // Text
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
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
