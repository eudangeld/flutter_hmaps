import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GoogleMap useGoogleMaps(LatLng position) {
  final LatLng _position = position;
  final _map = useMemoized<GoogleMap>(
      () => GoogleMap(initialCameraPosition: CameraPosition(target: _position)),
      [_position]);

  return _map;
}
