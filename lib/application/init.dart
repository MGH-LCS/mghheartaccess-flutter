import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class Init {
  static Future initialize() async {
    await _registerFirebase();
    return;
  }

  static _registerFirebase() async {
    print("Init: registering firebase ...");

    await Firebase.initializeApp();

    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    analytics.logAppOpen;

    print("Init: registering firebase ... done");
  }
}


 /*

  old code for manually init local firebase app

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
  */
