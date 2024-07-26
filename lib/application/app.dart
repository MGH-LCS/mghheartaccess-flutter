// Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:flutter/material.dart';
import 'package:mghheartaccess/application/config.dart';
import 'package:mghheartaccess/application/init.dart';
import 'package:mghheartaccess/application/locator.dart';
import 'package:mghheartaccess/application/router.dart';
import 'package:mghheartaccess/model/user.dart';
import 'package:mghheartaccess/service/authentication_service.dart';
import 'package:mghheartaccess/service/navigation_service.dart';
import 'package:mghheartaccess/ui/shared/theme.dart';
import 'package:mghheartaccess/ui/view/splash_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final Future _initFuture = Init.initialize();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
        initialData: User(),
        create: (context) =>
            locator<AuthenticationService>().userController.stream,
        lazy: false,
        child: FutureBuilder(
            future: _initFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const MyMaterialApp();
              } else {
                return const SplashScreen();
              }
            }));
  }
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appName,
      theme: MGHHeartTheme.lightTheme,
      darkTheme: MGHHeartTheme.darkTheme,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: 'RouteName.home',
      onGenerateRoute: MGHHeartRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
    );
  }
}
