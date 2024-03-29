import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/apis/apis.dart';
import 'package:doctors_on_hand/reuseable_widgets/reuseable_widgets.dart';
import 'package:doctors_on_hand/screens/main_screen.dart';
import 'package:doctors_on_hand/screens/sign_up_screen.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'doctor_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isLoading = false;
  int userRole = 0;


  Future<int?> getRole() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = await FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = firestore.collection('all_users').doc(userId);

    try {
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        // Retrieve the desired field from the document data
        dynamic role = documentSnapshot.get('role');

        print('Field Value: $role');
        userRole = role;
        APIs.saveUserRole(role);
        print(userRole);
return userRole;
      } else {
        print('Document does not exist.');
        return 0;
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }



  void _signInWithEmailAndPassword() async {
    final email = _emailTextController.text.trim();
    final password = _passwordTextController.text;

    try {
      setState(() {
        _isLoading = true;
      });
      FocusScope.of(context).unfocus();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save the user token after successful authentication
      String token = await userCredential.user!.getIdToken();

      // String userId = await userCredential.user!.uid;
      // await FirebaseFirestore.instance.collection('all_users').doc(userId).get('role');

      await getRole();
       await APIs.saveUserToken(token);
print(userRole);
      // Authentication successful, navigate back to the chat screen
      Navigator.pushReplacement(

        context,
        MaterialPageRoute(builder: (context) => userRole == 0 ? MainScreen() : DoctorMainScreen()),
      );
    } catch (e) {
      print('Error signing in: $e');
      // Show a snackbar or an error dialog to inform the user about the login error
    } finally {
      setState(() {
        _isLoading = false;
      });
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
        body: Stack(children: [
          Container(
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
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                  ),
                ),
              ),
            )
        ]),
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
