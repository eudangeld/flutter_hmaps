import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

  final List<LatLng> locations = [
    LatLng(-23.533773, -46.625290),
    LatLng(-17.221666, -46.875000),
    LatLng(-1.765833, -55.865833),
  ];

  String buildQueryString(Map<String, String> params) =>
      params.map((key, value) => MapEntry(key, '$key=$value')).values.join('&');

  Map<PolylineId, Polyline> _mapPolylines = {};

  // ignore: missing_return
  Future<void> getDirections() async {
    final toLocation = {
      "origin": locations[0].latitude.toString() +
          ',' +
          locations[0].longitude.toString(),
      "destination": locations[1].latitude.toString() +
          ',' +
          locations[1].longitude.toString(),
      "key": DotEnv().env['MAPS_KEY']
    };
    final _dio = Dio();
    final result = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json?${buildQueryString(toLocation)}');

    final _lines = result.data['routes'][0]['legs'][0]['steps'] as List;

    int _count = 0;

    _lines.forEach((ee) {
      final _pol = Polyline(
        polylineId: PolylineId(_count.toString()),
        consumeTapEvents: true,
        color: Colors.red,
        width: 5,
        points: [
          LatLng(ee['start_location']['lat'], ee['start_location']['lng']),
          LatLng(ee['end_location']['lat'], ee['end_location']['lng']),
        ],
      );
      setState(() {
        _mapPolylines[PolylineId(_count.toString())] = _pol;
      });
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: getDirections),
      appBar: AppBar(),
      body: GoogleMap(
        polylines: Set<Polyline>.of(_mapPolylines.values),
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: locations[0], zoom: 12.0, tilt: 30),
        onMapCreated: (GoogleMapController controller) =>
            _controller.complete(controller),
        markers: _markers,
      ),
    );
  }
}
