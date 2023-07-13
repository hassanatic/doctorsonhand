import 'package:doctors_on_hand/utils/color_utils.dart';
import 'package:doctors_on_hand/utils/size_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "Abdul";
  List<Widget> doctors_list = [
    DoctorsCard(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/person.jpeg"),
        (){
        print("happy");
        },
    ),
    DoctorsCard(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/doctor.png"),
          (){},
    ),
    DoctorsCard(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/doctor.png"),
          (){},
    ),
    DoctorsCard(
      "Abdul Rehman",
      "Gynocologyst",
      AssetImage("assets/images/doctor.png"),
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
            height: MediaQuery.of(context).size.height / 2.9,
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
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Align buttons with even spacing
              children: [
                CategoryButton(AssetImage("assets/images/app_icon.png"), () { }),
                CategoryButton(AssetImage("assets/images/app_icon.png"), () { }),
                CategoryButton(AssetImage("assets/images/app_icon.png"), () { }),
                CategoryButton(AssetImage("assets/images/app_icon.png"), () { }),
              ],
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

Widget DoctorsCard(String name, String spetiality, AssetImage image, VoidCallback onPress) {
  return InkWell(
    onTap: onPress,
splashColor: Colors.blueAccent,
    child: Card(
      elevation: 3,
      color: Color.fromRGBO(81, 168, 255, 60),
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
                  'doctor name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.16,
                  ),
                ),
                Text(
                  'speciality',
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
    splashColor: Colors.blueAccent,
    onTap: onPress,
    child: Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(81, 168, 255, 60),
      ),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Image(image: image,)

      ),
    ),
  );
}
