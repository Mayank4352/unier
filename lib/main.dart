import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injector.dart';
import 'core/utils/app_logger.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.configure();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(UnierApp(providers: await Injector.resolve()));
}
