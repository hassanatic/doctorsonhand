import 'package:doctors_on_hand/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng point = LatLng(32.887530, 73.768614);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            plugins: [
              MarkerClusterPlugin(),
            ],
            // onTap: (tapPosition, p) {
            //   setState(() {
            //     point = p;
            //     print(p.latitude);
            //     print(p.longitude);
            //   });
            // },
            center: LatLng(32.887530, 73.768614),
            zoom: 16.0, /**/
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),
            MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              size: Size(40, 40),
              fitBoundsOptions: FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point:  LatLng(32.894855842466065, 73.75784262591635),
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 45.0,
                    ),
                  ),
                ),
                Marker(
                  width: 70.0,
                  height: 70.0,
                  point: point,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 45.0,
                    ),
                  ),
                ),
              ],
              polygonOptions: PolygonOptions(
                  borderColor: Colors.blueAccent,
                  color: Colors.black12,
                  borderStrokeWidth: 3),
              builder: (context, markers) {
                return FloatingActionButton(
                  child: Text(markers.length.toString()),
                  onPressed: null,
                );
              },
            ),
            // MarkerLayerOptions(
            //   markers: [
            //     Marker(
            //       width: 80.0,
            //       height: 80.0,
            //       point: point,
            //       builder: (ctx) => Container(
            //         child: Icon(
            //           Icons.location_on,
            //           color: Colors.red,
            //           size: 45.0,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35, left: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black.withOpacity(0.4),
                child: Center(
                    child: Icon(
                  Icons.arrow_back,
                  size: 50,
                  color: Colors.white,
                ))),
          ),
        ),
      ],
    );
  }
}
