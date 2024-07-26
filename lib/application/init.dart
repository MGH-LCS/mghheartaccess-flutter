import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class Init {
  static Future initialize() async {
    await _registerFirebase();
  }

  static _registerFirebase() async {
    print("Init: registering firebase ...");

    await Firebase.initializeApp();

    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.logAppOpen;

    print("Init: registering firebase ... done");
  }
}
