import 'package:doctors_on_hand/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/color_utils.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  final String? userToken;

  const SplashScreen({super.key, required this.userToken});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      return Future.error('Location services are disabled');
    }

    // Request permission to access the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission to access location is denied
        return Future.error('Location permissions are denied');
      }
    }

    // Get the current position
    return await Geolocator.getCurrentPosition();
  }

  late Position _currentPosition;

  void _getLocation() {
    _getCurrentLocation().then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      // Use the retrieved position as needed
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');
    }).catchError((e) {
      // Handle any errors that occur during location retrieval
      print('Error getting location: $e');
    });
  }

  void getLocton() async {
    await Geolocator.requestPermission();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocton();

    _getCurrentLocation().then((Position position) {
      // Use the retrieved position as needed
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');

      // Navigate to the next screen or perform acny other actions
      // e.g., redirect to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                widget.userToken == null ? LoginScreen() : MainScreen()),
      );
    }).catchError((e) {
      // Handle any errors that occur during location retrieval
      print('Error getting location: $e');

      // Navigate to the next screen or perform error handling
      // e.g., redirect to an error screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                widget.userToken == null ? LoginScreen() : MainScreen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexToColor("439BFF"),

          hexToColor("7E5BED"),
          // hexToColor("52CCB6"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_icon.png",
              color: Colors.white,
              width: 250,
              height: 250,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Doctors On Hands",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
