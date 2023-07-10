import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:http/http.dart' as http;

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  //final Dio _dio;
  // DirectionsRepository ({required Dio dio}) : _dio = dio ?? Dio();
  // Future<Directions> getDirections ({
  //   required LatLng origin,
  //   required LatLng destination,
  // }) async {
  //
  //   final response = _dio.get(_baseUrl,
  //   queryParameters: {
  //     'origin': '${origin.latitude}, ${origin.longitude}',
  //       'destination': '${destination.latitude}, ${destination.longitude}',
  //     'Key': googleAPIKey,
  //   }
  //   );
  // }

 Future<String> fetchDirections(
     String apiKey,
     double startLat, double startLng,
     double endLat, double endLng,
     ) async {
   final url = Uri.parse('https://maps.googleapis.com/maps/api/directions/json?'
       'origin=$startLat,$startLng&'
       'destination=$endLat,$endLng&'
       'key=$googleAPIKey'
   );
   final response=await http.get(url);
   if(response.statusCode == 200){
     final decoded = jsonDecode(response.body);
     final polyline = decoded['routes'][0]['overview_polyline']['points'];

     return polyline;

   }else {
     throw Exception('Failed to fetch directions');
   }
 }

 //
Future polyline()async{
   String polylineString;
   return  polylineString =  await fetchDirections(googleAPIKey, 32.887530, 73.768614, 32.6407, 74.1667);
}

}