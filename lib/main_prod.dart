//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/application/app.dart';
import 'package:mghheartaccess/application/config.dart';
import 'package:mghheartaccess/application/locator.dart';

void main() async {
  // set the flavor... this is different in each main.dart for for each flavor
  Config.appFlavor = Flavor.prod;

  // odd issue when trying to initialize firebase..
  // see this: https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase stuff
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen;

  // configuring GetIt
  setupLocator();

  // call to main app widget
  runApp(MyApp());
}
