import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/color_utils.dart';
import 'doctor_main_screen.dart';
import 'main_screen.dart';

Set<Marker> markers = Set<Marker>();
double current_location_lat = 0;
double current_location_long = 0;

class SplashScreen extends StatefulWidget {
  final String? userToken;
  final int? role;

  const SplashScreen({super.key, required this.userToken, required this.role});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late GoogleMapController mapController;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _markersRef;

  Future<int> getUserRole() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('all_users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      // The user document exists, so return the role
      return snapshot.get('role');
    } else {
      // Handle the case if the user document doesn't exist or the role field is not set
      // You can return a default role or an error, depending on your app's logic
      return 1;
    }
  }

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

  void _loadMarkersFromFirestore() async {
    await _markersRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        double latitude = documentSnapshot['latitude'];
        double longitude = documentSnapshot['longitude'];
        LatLng latLng = LatLng(latitude, longitude);

        setState(() {
          markers.add(
            Marker(
              markerId: MarkerId(latLng.toString()),
              position: latLng,
            ),
          );
        });
      });
    });
  }

  // void _fetchHospitals() async {
  //   // Make an HTTP request to the Google Places API
  //   final response = await http.get(Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=25.1564,20.456&radius=5000&type=hospital&key=AIzaSyD1EfwwENHXTYcGNyibN8PJEOSDrb3lRew'));
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //
  //     // Extract the hospital data from the API response
  //     final List<dynamic> results = data['results'];
  //
  //     setState(() {
  //       markers = results.map((result) {
  //         final location = result['geometry']['location'];
  //         final lat = location['lat'];
  //         final lng = location['lng'];
  //         final name = result['name'];
  //
  //         return Marker(
  //           markerId: MarkerId(name),
  //           position: LatLng(lat, lng),
  //           infoWindow: InfoWindow(title: name),
  //         );
  //       }).toSet();
  //
  //       print(markers);
  //     });
  //   }
  // }

  void getLocton() async {
    await Geolocator.requestPermission();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocton();
    _markersRef = _firestore.collection('markers');
    _loadMarkersFromFirestore();
    _getCurrentLocation().then((Position position) async {
      // Use the retrieved position as needed
      print('Latitude: ${position.latitude}');

      current_location_lat = position.latitude;
      current_location_long = position.longitude;
      print('Longitude: ${position.longitude}');

      _loadMarkersFromFirestore();

      // Navigate to the next screen or perform acny other actions
      // e.g., redirect to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => widget.userToken == null
                ? LoginScreen()
                : widget.role == 0
                    ? MainScreen()
                    : DoctorMainScreen()),
      );
    }).catchError((e) {
      // Handle any errors that occur during location retrieval
      print('Error getting location: $e');

      // Navigate to the next screen or perform error handling
      // e.g., redirect to an error screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => widget.userToken == null
                ? LoginScreen()
                : widget.role == 0
                    ? MainScreen()
                    : DoctorMainScreen()),
      );
    });

    // _fetchHospitals();
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
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
