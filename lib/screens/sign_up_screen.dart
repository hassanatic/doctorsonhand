import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/apis/apis.dart';
import 'package:doctors_on_hand/reuseable_widgets/reuseable_widgets.dart';
import 'package:doctors_on_hand/screens/doctor_main_screen.dart';
import 'package:doctors_on_hand/screens/splash_screen.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/color_utils.dart';
import 'main_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _markersRef;
  BitmapDescriptor marker = BitmapDescriptor.defaultMarker;

  void addCustomMarker() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/doctormarker.png',
    ).then((icon) {
      setState(() {
        marker = icon;
      });
    });
  }

  void _addMarker(LatLng latLng) async {
    final name = await FirebaseAuth.instance.currentUser!.displayName;

    Marker newMarker = Marker(
      icon: marker,
      infoWindow: InfoWindow(
        title: name,
      ),
      markerId: MarkerId(latLng.toString()),
      position: latLng,
    );

    // Add the marker to Firestore
    _markersRef.add({
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
    });

    setState(() {
      markers.add(newMarker);
    });
  }

  // Function for user signup
  Future<void> signUp(String email, String password, String name) async {
    try {
      setState(() {
        _isLoading = true;
      });
      FocusScope.of(context).unfocus();

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Signup successful

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
      }
      String userId = userCredential.user!.uid; // Get the user's unique ID
      await FirebaseFirestore.instance
          .collection('all_users')
          .doc(userId)
          .set({'role': _selectedRole});
      await FirebaseFirestore.instance
          .collection('user_locations')
          .doc(userId)
          .set({
        'location': GeoPoint(current_location_lat, current_location_long)
      });

      String token = await userCredential.user!.getIdToken();
      await APIs.saveUserToken(token);
      await APIs.saveUserRole(_selectedRole);

      print(_nameTextController.text);

      if (await APIs.userExists()) {
        print("true");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        print("false");
        (await APIs.createUser(_nameTextController.text).then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }));
      }

      print('Signup successful: ${userCredential.user!.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> signUpDoc(
    String email,
    String password,
    String name,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      FocusScope.of(context).unfocus();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Signup successful

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
      }
      String userId = userCredential.user!.uid; // Get the user's unique ID
      await FirebaseFirestore.instance
          .collection('all_users')
          .doc(userId)
          .set({'role': _selectedRole});

      await FirebaseFirestore.instance
          .collection('doctor_locations')
          .doc(userId)
          .set({
        'location': GeoPoint(current_location_lat, current_location_long)
      });

      _addMarker(LatLng(current_location_lat, current_location_long));

      String token = await userCredential.user!.getIdToken();
      await APIs.saveUserToken(token);
      await APIs.saveUserRole(_selectedRole);

      print(_nameTextController.text);

      if (await APIs.doctorExists()) {
        print("true");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DoctorMainScreen()));
      } else {
        print("false");
        (await APIs.createDoctor(
          _nameTextController.text,
          _specialityTextController.text,
          double.parse(_idTextController.text),
          _licenceTextController.text,
          GeoPoint(current_location_lat, current_location_long),
        ).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DoctorMainScreen()));
        }));
      }

      print('Signup successful: ${userCredential.user!.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List _roles = ["doctor", "patient"];
  int _selectedRole = 0;
  TextEditingController _nameTextController = new TextEditingController();
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  TextEditingController _licenceTextController = new TextEditingController();
  TextEditingController _idTextController = new TextEditingController();
  TextEditingController _specialityTextController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _specialityTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _markersRef = _firestore.collection('markers');
    addCustomMarker();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ), // Text
        ), // AppBar
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
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
                    verticalSpace(20),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Choose your role ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(canvasColor: Colors.white),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: CupertinoPicker(
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
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    Visibility(
                        visible: _selectedRole != 0,
                        child: Column(
                          children: [
                            reusableTextField(
                                "Enter PMDC Registration Number",
                                Icons.credit_card,
                                false,
                                _licenceTextController),
                            verticalSpace(20),
                            reusableTextField("Enter ID Card Number",
                                Icons.credit_card, false, _idTextController),
                            verticalSpace(20),
                            reusableTextField(
                                "Your Speciality",
                                Icons.medical_services,
                                false,
                                _specialityTextController),
                          ],
                        )),
                    verticalSpace(20),
                    signInSignUpButton(context, false, () async {
                      if (_selectedRole == 0) {
                        signUp(
                            _emailTextController.text,
                            _passwordTextController.text,
                            _nameTextController.text);
                      } else {
                        signUpDoc(
                          _emailTextController.text,
                          _passwordTextController.text,
                          _nameTextController.text,
                        );
                      }
                    }),
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
}
