import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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



          child:  Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width:  120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: AssetImage('assets/images/doctor1.png'))),



                ),
                const SizedBox(height:10),

                Text(

                    'John Doe',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),

                Text(
                  'asd@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: 170,
                  child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide.none,
                      backgroundColor: Colors.greenAccent,
                    ),
                      child: Text(

                          'Edit Profile',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                  ),
                )




              ],



            ),
          ),




        ),

        const SizedBox(height: 20),


        Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            children: [

              Profile_Menu(title: 'Settings', icon: Icons.settings, onPress: (){} ),
              Profile_Menu(title: 'History', icon: Icons.history,onPress: (){},),
              Profile_Menu(title: 'Location', icon: Icons.location_city,onPress: (){},),

              const Divider(),
              Profile_Menu(title: 'Information', icon: Icons.medical_information,onPress: (){},),
              Profile_Menu(title: 'Logout', icon: Icons.logout,onPress: (){}, textcolor: Colors.red,endicon: false,),
            ],
          ),
        )




      ],
    );


  }
}

class Profile_Menu extends StatelessWidget {
  const Profile_Menu({


    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endicon = true,
    this.textcolor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endicon;
  final Color? textcolor;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.cyan.withOpacity(0.2),
        ),

        child:  Icon(icon,color: Color.fromRGBO(81, 168, 255, 60),),

      ),
      title: Text(
        title,

        style: const TextStyle(

            fontFamily: 'Poppins',
            color: Colors.black

        )?.apply(color: textcolor),


      ),

      trailing: endicon? Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.cyan.withOpacity(0.2),
        ),

        child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.blueGrey),):  null,

      );
  }
}
