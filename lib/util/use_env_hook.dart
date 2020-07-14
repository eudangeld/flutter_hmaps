import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> useAppWithEnv(Function materialApp) async =>
    DotEnv().load('.env').then((value) => materialApp);
