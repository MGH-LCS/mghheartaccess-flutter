//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:flutter/material.dart';
import 'package:mghheartaccess/application/app.dart';
import 'package:mghheartaccess/application/config.dart';
import 'package:mghheartaccess/application/locator.dart';

void main() {
  // set the flavor... this is different in each main.dart for for each flavor
  Config.appFlavor = Flavor.dev;

  // odd issue when trying to initialize firebase..
  // see this: https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();

  // configuring GetIt
  setupLocator();

  // call to main app widget
  runApp(MyApp());
}
