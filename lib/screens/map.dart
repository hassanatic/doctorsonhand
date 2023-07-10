import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final LatLng _origin_position = LatLng(32.887530, 73.768614);
  CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(32.887530, 73.768614),zoom: 12);
  late GoogleMapController _googleMapController ;
   Marker _origin = Marker(
    markerId: MarkerId('origin'),
    position: LatLng(32.887530, 73.768614),
     infoWindow: InfoWindow(title: "your location"),
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

  );
  Marker _destination = Marker(
    markerId: MarkerId('destination'),
    position: LatLng(32.6407, 74.1667),
    infoWindow: InfoWindow(title: "your location"),
    icon: BitmapDescriptor.defaultMarker,

  );
@override
  void dispose() {
    // TODO: implement dispose
  _googleMapController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          _origin,
          _destination,
        },
      ),
    );
  }
}
