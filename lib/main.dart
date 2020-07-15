import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_hmaps/app/maps_widget.dart';
import 'package:flutter_hmaps/util/use_env_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

main() {
  useRunWithEnv(MaterialApp(
    title: 'Hooks and Maps',
    home: HookMapsApp(),
  ));
}

class HookMapsApp extends HookWidget {
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    final _directions = useState<List<LatLng>>([]);
    final _map = MapsWidget(mockLocations[0], directions: _directions.value);

    useEffect(() {
      _map.renderRouteDirection();
      return;
    }, _directions.value);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _directions.value
          ..add(mockLocations[rng.nextInt(mockLocations.length - 1)])
          ..add(mockLocations[rng.nextInt(mockLocations.length - 1)]);
      }),
      body: Column(
        children: <Widget>[
          Expanded(child: _map),
        ],
      ),
    );
  }
}

final List<LatLng> mockLocations = [
  LatLng(-23.533773, -46.625290),
  LatLng(-17.221666, -46.875000),
  LatLng(-1.765833, -55.865833),
  LatLng(44.968046, -94.420307),
  LatLng(44.33328, -89.132008),
  LatLng(33.755787, -116.359998),
  LatLng(33.844843, -116.54911),
  LatLng(44.92057, -93.44786),
  LatLng(44.240309, -91.493619),
  LatLng(44.968041, -94.419696),
  LatLng(44.333304, -89.132027),
  LatLng(33.755783, -116.360066),
  LatLng(33.844847, -116.549069),
  LatLng(44.920474, -93.447851),
  LatLng(44.240304, -91.493768),
];
