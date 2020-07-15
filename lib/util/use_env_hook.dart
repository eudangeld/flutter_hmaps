import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> useRunWithEnv(MaterialApp materialApp) async =>
    DotEnv().load('.env').then((value) => runApp(materialApp));
