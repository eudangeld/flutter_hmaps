import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Example extends HookWidget {
  const Example({Key key, @required this.duration})
      : assert(duration != null),
        super(key: key);

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: duration);
    return Container();
  }
}
