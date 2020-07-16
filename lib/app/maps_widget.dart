import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends HookWidget {
  MapsWidget({this.position});

  GoogleMapController _mapController;
  // final Map<PolylineId, Polyline> routeLines = {};
  final LatLng position;
  // LatLng initialLocation;

  // Set<Marker> _markers = Set<Marker>();

  // ignore: missing_return
  // Future<void> createRoute(List<LatLng> directions) async {
  //   final _steps =
  // await useDirectionsSteps(directions, DotEnv().env['MAPS_KEY']);
  //   int _count = 0;

  //   _steps.forEach((ee) {
  //     final _pol = Polyline(
  //       polylineId: PolylineId(_count.toString()),
  //       consumeTapEvents: true,
  //       color: Colors.red,
  //       width: 5,
  //       points: [
  //         LatLng(ee['start_location']['lat'], ee['start_location']['lng']),
  //         LatLng(ee['end_location']['lat'], ee['end_location']['lng']),
  //       ],
  //     );
  //     routeLines[PolylineId(_count.toString())] = _pol;
  //     _count++;
  //   });
  // }

  updatePosition(LatLng newPosition) {
    if (_mapController != null) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(tilt: 30.0, zoom: 15.0, target: newPosition)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        // polylines: Set<Polyline>.of(routeLines.values),
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: position, zoom: 12.0, tilt: 30),
        onMapCreated: (GoogleMapController controller) =>
            _mapController = controller);
  }
}
