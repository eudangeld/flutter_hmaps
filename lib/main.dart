import 'package:flutter/material.dart';
import 'package:flutter_hmaps/app/maps_widget.dart';
import 'package:flutter_hmaps/util/use_env_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future main() async {
  useRunWithEnv(MaterialApp(
    title: 'Maps Directions',
    home: HookMapsApp(),
  ));
}

class HookMapsApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MapsWidget();
  }
}
