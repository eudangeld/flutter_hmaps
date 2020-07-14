import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hmaps/util/utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends HookWidget {
  final mapController = useState<Completer<GoogleMapController>>(Completer());
  final routeLines = useState<Map<PolylineId, Polyline>>({});

  final List<LatLng> mockLocations = [
    LatLng(-23.533773, -46.625290),
    LatLng(-17.221666, -46.875000),
    LatLng(-1.765833, -55.865833),
  ];

  // ignore: missing_return
  Future<void> getDirections() async {
    final result = await useDirections(
        mockLocations[0], mockLocations[1], DotEnv().env['MAPS_KEY']);
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
      routeLines.value[PolylineId(_count.toString())] = _pol;
      _count++;
    });

    print(routeLines.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polylines: Set<Polyline>.of(routeLines.value.values),
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: mockLocations[0], zoom: 12.0, tilt: 30),
        onMapCreated: (GoogleMapController controller) =>
            mapController.value.complete(controller),
      ),
    );
  }
}
