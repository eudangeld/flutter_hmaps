import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hmaps/app/maps_widget.dart';
import 'package:flutter_hmaps/util/use_env_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future main() async {
  useAppWithEnv(() => runApp(MapsNavigator()));
}

class MapsNavigator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Directions',
      home: Scaffold(
        body: MapsWidget(),
      ),
    );
  }
}
