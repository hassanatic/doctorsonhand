import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/apis/apis.dart';
import 'package:doctors_on_hand/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'doctor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> dentist_list = [];
  List<Widget> gyno_list = [];
  List<Widget> cardiologist_list = [];

  List<Widget> default_doc_list = [];

  void getDoctorsBySpeciality(String speciality) async {
    String spc = speciality;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection('doctors');

    try {
      QuerySnapshot querySnapshot = await collectionReference.where('speciality', isEqualTo: speciality).get();

      if (querySnapshot.size > 0) {
        List<DocumentSnapshot> documents = querySnapshot.docs;
        // Process each document and access all fields
        for (var document in documents) {

          Map<String, dynamic> data = document.data() as Map<String, dynamic>;


          // Access all fields in the document
          String docName = data['name'];
          String bio = data['bio'];
          String  speciality = data['speciality'];
        //  List<String> other_spc = data['other_specialities'];
          List<dynamic> firestoreList = data['other_specialities'];
          List<String> other_spc = firestoreList.map((item) => item.toString()).toList();

          if(spc == "dentist"){

            dentist_list.add(
                DoctorsCard(

                doctorName: docName, speciality: speciality, profileImage: AssetImage("assets/images/doctor1.png",

                ),
                  onPressed: (context ) {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetailsScreen(
                                doctorName: docName,
                                speciality: speciality,
                                bio: bio,
                                ratings: 4.0,
                                profileImage: "assets/images/doctor1.png",
                                otherSpecialities: other_spc)));
                  },
            )
            );
          }
          else if(spc == "gynocologist"){

            gyno_list.add(
                DoctorsCard(

                  doctorName: docName, speciality: speciality, profileImage: AssetImage("assets/images/doctor1.png",

                ),
                  onPressed: (context ) {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetailsScreen(
                                doctorName: docName,
                                speciality: speciality,
                                bio: bio,
                                ratings: 4.0,
                                profileImage: "assets/images/doctor1.png",
                                otherSpecialities: other_spc)));
                  },
                )
            );
          }

          if(spc == "cardiologist"){

            cardiologist_list.add(
                DoctorsCard(

                  doctorName: docName, speciality: speciality, profileImage: AssetImage("assets/images/doctor1.png",

                ),
                  onPressed: (context ) {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDetailsScreen(
                                doctorName: docName,
                                speciality: speciality,
                                bio: bio,
                                ratings: 2.0,
                                profileImage: "assets/images/doctor1.png",
                                otherSpecialities: other_spc)));
                  },
                )
            );
          }

          // ... and so on
          print('Document ID: ${document.id}, Field Nane: $docName, Specilaity Field: $speciality');
        }
if(speciality == 'dentist'){
  setState(() {
    default_doc_list = dentist_list;
  });
}
        else if(speciality == 'cardiologist'){
  setState(() {
    default_doc_list = cardiologist_list;
  });
}
        if(speciality == 'gynocologist'){
          setState(() {
            default_doc_list = gyno_list;
          });

        }

      } else {
        print('No documents found with the specified criteria.');
      }
    } catch (e) {
      print('Error retrieving documents: $e');
    }
  }


  String? username = APIs.auth.currentUser?.displayName;

  List<Widget> doctors_list = [
    DoctorsCard(
      doctorName: "An",
      speciality: "gynocologist",
      profileImage: AssetImage("assets/images/person.jpeg"),
      onPressed: (context) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetailsScreen(
                    doctorName: "doctorName",
                    speciality: "spe",
                    bio: "bio",
                    ratings: 2.0,
                    profileImage: "assets/images/person.jpeg",
                    otherSpecialities: ["sdf", "dfsdf"])));
      },
    ),
    DoctorsCardd(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
      () {},
    ),
    DoctorsCardd(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
      () {},
    ),
    DoctorsCardd(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
      () {},
    ),
  ];

  @override

  void initState() {
    // TODO: implement initState
    super.initState();

    getDoctorsBySpeciality('cardiologist');
  }
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: hexToColor("#f8faff"),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(81, 168, 255, 60),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(34),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28, bottom: 20),
                    child: Text(
                      'Hi, ${username?.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.32,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 45, left: 28),
                    child: Text(
                      'Let’s find\na nearby Doctor!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25, left: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 56,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.8999999761581421)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                  ))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,

                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    //  letterSpacing: 0.40,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 12, 15, 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Align buttons with even spacing
                children: [
                  CategoryButton(AssetImage("assets/images/heart.png"), () {
                    default_doc_list.clear();

                    getDoctorsBySpeciality('cardiologist');

                  }),
                  CategoryButton(AssetImage("assets/images/pills.png"), () {

                  }),
                  CategoryButton(AssetImage("assets/images/tooth.png"), () {

                    default_doc_list.clear();

                    getDoctorsBySpeciality('dentist');


                  }),
                  CategoryButton(
                      AssetImage("assets/images/maternity.png"), () {
setState(() {
  default_doc_list.clear();

});

                    getDoctorsBySpeciality('gynocologist');
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 2, bottom: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nearby Doctors',
                  style: TextStyle(
                    color: Colors.black,

                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    //  letterSpacing: 0.40,
                  ),
                ),
              ),
            ),
            Expanded(
                child: default_doc_list != [] ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Column(
                  children: default_doc_list,
                )
              ),
            ): Text('No doctors found', style: TextStyle(color: Colors.black54, fontSize: 24),),),
          ],
        ),
      ),
    );
  }
}

class DoctorsCard extends StatelessWidget {
  final String doctorName;
  final String speciality;
  final ImageProvider profileImage;
  final Function(BuildContext) onPressed;

  const DoctorsCard({
    required this.doctorName,
    required this.speciality,
    required this.profileImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => onPressed(context),
      splashColor: Colors.blue[300],
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        color: Color.fromRGBO(81, 168, 255, 90),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                //child: ClipOval(child: image),
//backgroundColor: Colors.transparent,
                backgroundImage: profileImage,
                radius: 33,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.16,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    speciality,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.32,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget DoctorsCardd(
  String name,
  String spetiality,
  AssetImage image,
  VoidCallback onPress,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(15),
    onTap: onPress,
    splashColor: Colors.blue[300],
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      color: Color.fromRGBO(81, 168, 255, 90),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              //child: ClipOval(child: image),
//backgroundColor: Colors.transparent,
              backgroundImage: image,
              radius: 33,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.16,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  spetiality,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.32,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget CategoryButton(AssetImage image, VoidCallback onPress) {
  return InkWell(
    borderRadius: BorderRadius.circular(100),
    splashColor: Colors.blueAccent,
    onTap: onPress,
    child: Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.35),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        shape: BoxShape.circle,
        color: Color.fromRGBO(81, 168, 255, 60),
      ),
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Image(
            image: image,
          )),
    ),
  );
}
