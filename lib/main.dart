import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

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

HookBuilder useDirectionsInput() {
  final origin = TextEditingController();
  final destiny = TextEditingController();

  return HookBuilder(builder: (context) {
    return Column(
      children: <Widget>[
        TextFormField(controller: origin),
        TextFormField(controller: destiny),
        ArgonButton(
            height: 50,
            roundLoadingShape: true,
            width: MediaQuery.of(context).size.width * 0.45,
            onTap: (startLoading, stopLoading, btnState) {
              if (btnState == ButtonState.Idle) {
                startLoading();
              } else {
                stopLoading();
              }
            },
            child: Text(
              "Search",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            loader: Container(
              padding: EdgeInsets.all(10),
              child: SpinKitRotatingCircle(
                color: Colors.white,
                // size: loaderWidth ,
              ),
            ))
      ],
    );
  });
}

class HookMapsApp extends HookWidget {
  final rng = new Random();
  final initialPosition = mockLocations[0];
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    final showSearchBar = useState<bool>(false);

    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Expanded(child: InkWell(child: Icon(Icons.access_time))),
              Expanded(child: InkWell(child: Icon(Icons.access_time))),
              Expanded(child: InkWell(child: Icon(Icons.access_time))),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                      // polylines: Set<Polyline>.of(routeLines.values),
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: initialPosition, zoom: 12.0, tilt: 30),
                      onMapCreated: (GoogleMapController controller) =>
                          _mapController.complete(controller)),
                ),
              ],
            ),
            showSearchBar.value ? useDirectionsInput() : Container(),
          ],
        ));
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
