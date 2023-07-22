import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../apis/apis.dart';
import '../models/laboratory.dart';

class NearbyLabs extends StatefulWidget {
  const NearbyLabs({super.key});

  @override
  State<NearbyLabs> createState() => _NearbyLabsState();
}

class _NearbyLabsState extends State<NearbyLabs> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      print("Error while fetching location: $e");
      // Handle any errors while getting the location
    }
  }

  @override
  Widget build(BuildContext context) {
    if (latitude == null || longitude == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return LabsList(latitude: latitude!, longitude: longitude!);
    }
  }
}

class LabsList extends StatefulWidget {
  final double latitude;
  final double longitude;

  LabsList({required this.latitude, required this.longitude});

  @override
  _LabsListState createState() => _LabsListState();
}

class _LabsListState extends State<LabsList> {
  late List<Laboratory> labs = [];
  // Variable to hold longitude

  @override
  void initState() {
    super.initState();
    _fetchLabs();
  }

  Future<void> _fetchLabs() async {
    final api = Api('AIzaSyDoFoXFgBBpQRyTcIOCjfkKvjEpGgTjacc');
    final labsData =
        await api.fetchNearbyLaboratories(widget.latitude, widget.longitude);
    setState(() {
      labs = labsData
          .map((lab) => Laboratory(
                lab['name'],
                lab['vicinity'],
                lab['geometry']['location']['lat'],
                lab['geometry']['location']['lng'],
              ))
          .toList();
    });
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLongitude - startLongitude);

    double a = pow(sin(dLat / 2), 2) +
        cos(_degreesToRadians(startLatitude)) *
            cos(_degreesToRadians(endLatitude)) *
            pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Nearby Laboratories'),
      ),
      body: labs != null
          ? ListView.builder(
              itemCount: labs.length,
              itemBuilder: (context, index) {
                final lab = labs[index];
                final distance = calculateDistance(widget.latitude,
                    widget.longitude, lab.latitude, lab.longitude);
                return SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.cyan,
                      child: Center(
                        child: ListTile(
                          leading: const Icon(CupertinoIcons.lab_flask_solid),
                          title: Text(lab.name),
                          subtitle: Text(
                              '${lab.vicinity} \n\n ${distance.toStringAsFixed(2)} km away'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.directions),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
