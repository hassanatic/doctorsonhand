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
  TextEditingController _licenceTextController = new TextEditingController();
  TextEditingController _idTextController = new TextEditingController();

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
                reusableTextField("Enter Name", Icons.person_outline, false,
                    _nameTextController),
                verticalSpace(20),
                reusableTextField("Enter Email", Icons.mail_outline, false,
                    _emailTextController),
                verticalSpace(20),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                verticalSpace(20),

                Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("Choose your role ",style: TextStyle(fontSize: 18),),
                      ),
                    ),
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.white
                        ),
                        child: CupertinoPicker(

                         // backgroundColor: Colors.white.withOpacity(0.3),
                          magnification: 1.22,
                          squeeze: 1.2,
                         // looping: true,
                          useMagnifier: true,
                          scrollController:
                              FixedExtentScrollController(initialItem: 0),
                          itemExtent: 30,
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              _selectedRole = selectedItem;
                              print(_selectedRole);
                            });
                          },
                          children: [

                            Text("patient"),
                            Text("doctor"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
              Visibility(
                  visible: _selectedRole!=0,
                  child: Column(
                    children: [
                      reusableTextField("Enter PMDC Registration Number",Icons.credit_card, false, _licenceTextController),
                      verticalSpace(20),
                      reusableTextField("Enter ID Card Number",Icons.credit_card, false, _idTextController),
                    ],
                  )),
                verticalSpace(20),
                signInSignUpButton(context, false, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
