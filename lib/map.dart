import 'package:parking/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import "dart:math";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Raw coordinates got from  OpenRouteService
  List listOfPoints = [];
  double distanceInMeters = 0.0;
  double distanceInKm = 0.0;
  double lat = 0.001;
  double long = 0.001;
  List<double> coordinates = [38.80161279512159, 9.019749504833579];

  // Conversion of listOfPoints into LatLng(Latitude, Longitude) list of points
  List<LatLng> points = [];

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  // Method to consume the OpenRouteService API
  Future getCoordinates() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    // Requesting for openrouteservice api
    // var response = await http.get(getRouteUrl(
    //   '${position.latitude},${position.longitude}',
    // '38.80161279512159,9.019749504833579'));

    const String baseUrl =
        'https://api.openrouteservice.org/v2/directions/driving-car';
    const String apiKey =
        '5b3ce3597851110001cf6248f55d7a31499e40848c6848d7de8fa624';
    String url =
        '$baseUrl?api_key=$apiKey&start=${position.longitude},${position.latitude}&end=${38.8356},${9.00222}';
    http.Response response = await http.get(Uri.parse(url));

    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      } else {
        print(response.body);
      }
    });

    distanceInMeters = await Geolocator.distanceBetween(
      9.005401, // latitude of point 2
      38.763611, // longitude of point 2
      position.latitude, // latitude of point 1
      position.longitude, // longitude of point 1
    );

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((position.latitude - 9.005401) * p) / 2 +
        c(9.005401 * p) *
            c(position.latitude * p) *
            (1 - c((position.longitude - 38.763611) * p)) /
            2;
    distanceInKm = 12742 * asin(sqrt(a));
    coordinates[0] = position.latitude;
    coordinates[1] = position.longitude;
    return coordinates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          IconButton(
            alignment: Alignment.topLeft,
            onPressed: () => {Navigator.pushNamed(context, "/")},
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            color: primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: getCoordinates(),
              builder: (context, data) {
                var coordinate = data.data;
                // if (coordinates[0]==null){
                //   coordinates[0]=0.0;
                // }
                //  if (coordinates[1]==null){
                //   coordinates[1]=0.0;
                // }
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: FlutterMap(
                        options: MapOptions(
                            zoom: 6,
                            center: LatLng(coordinates[1], coordinates[0])),
                        children: [
                          // Layer that adds the map
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          PolylineLayer(
                            polylineCulling: false,
                            polylines: [
                              Polyline(
                                  points: points,
                                  color: Colors.black,
                                  strokeWidth: 5),
                            ],
                          ),
                          // Layer that adds points the map
                          MarkerLayer(
                            markers: [
                              // First Marker
                              Marker(
                                point: LatLng(
                                    9.00222, 38.8356),
                                width: 80,
                                height: 80,
                                builder: (context) => IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.location_on),
                                  color: Colors.red,
                                  iconSize: 45,
                                ),
                              ),

                              // Seconde Marker
                              Marker(
                                point: LatLng(coordinates[0], coordinates[1]),
                                width: 80,
                                height: 80,
                                builder: (context) => IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.location_on),
                                  color: Colors.green,
                                  iconSize: 45,
                                ),
                              ),
                            ],
                          ),

                          // Polylines layer
                        ],
                      ),
                    ),
                    Text(
                      "${distanceInKm.toString()} KM",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                );
              }),
        ],
      ),
      //  Text(distanceInKm.toString(),style: TextStyle(color: Colors.red,fontSize: 20),),
    );
  }
}
