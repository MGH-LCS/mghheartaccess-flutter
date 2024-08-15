//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/application/app.dart';
import 'package:mghheartaccess/application/config.dart';
import 'package:mghheartaccess/application/locator.dart';

void main() async {
  // set the flavor... this is different in each main.dart for for each flavor
  Config.appFlavor = Flavor.dev;

  // odd issue when trying to initialize firebase..
  // see this: https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      storageBucket: 'mgh-heart-access-dev.appspot.com',
      apiKey:
          'AIzaSyBeLaeJApnSZYMePUnF8uCe5JZVv932DSo', // paste your api key here
      appId:
          '1:595520306323:android:b0a49140bd4f03bdf12166', //paste your app id here
      messagingSenderId: '595520306323', //paste your messagingSenderId here
      projectId: 'mgh-heart-access-dev', //paste your project id here
    ),
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen;

  // configuring GetIt
  setupLocator();

  // call to main app widget
  runApp(MyApp());
}
