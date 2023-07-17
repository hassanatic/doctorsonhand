


import 'package:doctors_on_hand/utils/color_utils.dart';
import 'package:doctors_on_hand/utils/size_utils.dart';
import 'package:flutter/material.dart';

import 'doctor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String username = "Abdul";
  List<Widget> doctors_list = [
    DoctorsCard(
      doctorName: "An",
      speciality: "gynocologist",
      profileImage: AssetImage("assets/images/person.jpeg"),
      onPressed: (context){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorDetailsScreen(doctorName: "doctorName", speciality: "spe", bio: "bio", ratings: 2.0,
            profileImage: "assets/images/person.jpeg", otherSpecialities: ["sdf","dfsdf"])));
      },
    ),
    DoctorsCardd(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
          (){},
    ),
    DoctorsCardd(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
          (){},
    ),
    DoctorsCardd(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
          (){},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#f8faff"),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
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
                    'Hi, $username',
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
           padding: const EdgeInsets.only(left: 30,top: 5),
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
                CategoryButton(AssetImage("assets/images/heart.png"), () { }),
                CategoryButton(AssetImage("assets/images/pills.png"), () { }),
                CategoryButton(AssetImage("assets/images/tooth.png"), () { }),
                CategoryButton(AssetImage("assets/images/maternity.png"), () { }),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30,top: 2,bottom: 2),
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
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Column(
                children: doctors_list,
              ),
            ),
          ))
        ],
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


      onTap: ()=> onPressed(context),
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
                  SizedBox(width: 5,),
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

Widget DoctorsCardd(String name, String spetiality, AssetImage image, VoidCallback onPress, ) {
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
                SizedBox(width: 5,),
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
          child: Image(image: image,)

      ),
    ),
  );
}
