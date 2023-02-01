import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:doctors_on_hand/utils/constants.dart';

class DirectionsRepository{
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;
  DirectionsRepository ({required Dio dio}) : _dio = dio ?? Dio();
  Future<Directions> getDirections ({
    @required LatLng origin,
    @required LatLng destination,
  }) async {

    final response = _dio.get(_baseUrl,
    queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
      'Key': googleAPIKey,
    }
    );
  }

}