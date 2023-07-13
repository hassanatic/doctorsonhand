
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
    return  Scaffold(
        backgroundColor: hexToColor("#f8faff"),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2.4,
              width: double.infinity,
              decoration:  const BoxDecoration(
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
                    padding: const EdgeInsets.only(left: 28,bottom: 20),
                    child: Text(

                      'Hi, Abdul',
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

                    padding: EdgeInsets.only(bottom: 45,left: 28),
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
                    padding: const EdgeInsets.only(bottom: 25,left: 16),
                    child: Container(
                      child: const Center(
                         child: Padding(
                          padding: EdgeInsets.only(left: 24,right: 24),
                          child: TextField(

                            decoration: InputDecoration.collapsed(hintText: "Search",hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                            ))


                          ),
                        ),
                      ),

                      width: MediaQuery.of(context).size.width/1.1,
                      height: 56,
                      decoration: ShapeDecoration(gradient: LinearGradient(

                          colors: [Colors.white, Colors.white.withOpacity(0.8999999761581421)],
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
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons with even spacing
        children: [
          GestureDetector(
            onTap: () {
              // Action when the button is tapped
            },
            child: CircleAvatar(
              radius: 33, // Radius of the button
              // Image for the button
            ),
          ),
          GestureDetector(
            onTap: () {
              // Action when the button is tapped
            },
            child: CircleAvatar(
              radius: 33, // Radius of the button
              // Image for the button
            ),
          ),
          GestureDetector(
            onTap: () {
              // Action when the button is tapped
            },
            child: CircleAvatar(
              radius: 33, // Radius of the button
              // Image for the button
            ),
          ),
          GestureDetector(
            onTap: () {
              // Action when the button is tapped
            },
            child: CircleAvatar(
              radius: 33, // Radius of the button
              // Image for the button
            ),
          ),
        ],
      ),
    )





    ],



        ),

    );
  }
}
