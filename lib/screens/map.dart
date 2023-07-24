import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../apis/apis.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _originPosition = LatLng(32.640700, 74.166700);
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(32.640700, 74.166700), zoom: 12);
  late GoogleMapController _googleMapController;
  Set<Marker> _markers = {};

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    _fetchNearbyHospitals();
    addCustomMarker();
  }

  bool _isLoading = true;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/marker4.png',
    ).then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  void _showDirectionsDialog(latitude, longitude) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Text("Get Directions"),
          content: Text("Do you want to open Google Maps for directions?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _openGoogleMapsDirections(latitude, longitude);
              },
              child: Text("Open Google Maps"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openGoogleMapsDirections(double lat, double lng) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      print('Could not open Google Maps directions.');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        // Update _originPosition and _initialCameraPosition with the current location
        _originPosition = LatLng(position.latitude, position.longitude);
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 12,
        );

        _isLoading = false;
      });
    } catch (e) {
      print("Error getting location: $e");
      // Handle any error that occurred while obtaining the location.
    }
  }

  Future<void> _fetchNearbyHospitals() async {
    final api = Api('AIzaSyDoFoXFgBBpQRyTcIOCjfkKvjEpGgTjacc');

    try {
      List<Map<String, dynamic>> nearbyHospitals =
          await api.fetchNearbyHospitals(
              _originPosition.latitude, _originPosition.longitude);

      setState(() {
        _markers.clear();
        for (var hospital in nearbyHospitals) {
          final LatLng latLng = LatLng(
            hospital['geometry']['location']['lat'],
            hospital['geometry']['location']['lng'],
          );
          final marker = Marker(
            markerId: MarkerId(hospital['place_id']),
            position: latLng,
            infoWindow: InfoWindow(title: hospital['name']),
            icon: markerIcon,
            onTap: () {
              _showDirectionsDialog(latLng.latitude, latLng.longitude);
            },
          );
          _markers.add(marker);
        }
      });
    } catch (e) {
      print('Error fetching nearby hospitals: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show a loading indicator while the custom marker icon is loading
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: _markers,
      ),
    );
  }
}
