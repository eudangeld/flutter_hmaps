import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hmaps/util/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatelessWidget {
  final Completer<GoogleMapController> mapController = Completer();
  final Map<PolylineId, Polyline> routeLines = {};
  final List<LatLng> directions;
  final LatLng initialLocation;

  MapsWidget(
    this.initialLocation, {
    Key key,
    this.directions = const [],
  }) : super(key: key);

  // ignore: missing_return
  Future<void> renderRouteDirection() async {
    final _steps =
        await useDirectionsSteps(directions, DotEnv().env['MAPS_KEY']);
    int _count = 0;

    _steps.forEach((ee) {
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
      routeLines[PolylineId(_count.toString())] = _pol;
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      polylines: Set<Polyline>.of(routeLines.values),
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: initialLocation, zoom: 12.0, tilt: 30),
      onMapCreated: (GoogleMapController controller) =>
          mapController.complete(controller),
    );
  }
}
