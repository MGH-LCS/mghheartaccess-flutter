//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'package:flutter/material.dart';

enum RouteName { home, serviceDetail, about }

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  RouteName? _currentRoute;
  dynamic _currentArguments;

  RouteName? get currentRoute {
    return _currentRoute;
  }

  dynamic get currentArguments {
    return _currentArguments;
  }

  NavigationService() {
    init();
  }

  Future init() async {
    print('NavigationService: init ...');
    //_onSelectNotificationSubscription = SelectNotificationStream.instance.payloadStream.listen(handleOnSelectNotification);
    //GetIt.instance.signalReady(this);
  }

  Future<dynamic> replaceNavigationTo(RouteName routeName,
      {dynamic arguments}) async {
    _currentRoute = routeName;
    _currentArguments = arguments;
    return await navigatorKey.currentState!
        .pushReplacementNamed(routeName.toString(), arguments: arguments);
  }

  Future<dynamic> replaceAllNavigationTo(RouteName routeName,
      {dynamic arguments}) {
    _currentRoute = routeName;
    _currentArguments = arguments;
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName.toString(), (route) => false,
        arguments: arguments);
  }

  Future<dynamic> navigateTo(RouteName routeName, {dynamic arguments}) async {
    _currentRoute = routeName;
    _currentArguments = arguments;
    return await navigatorKey.currentState!
        .pushNamed(routeName.toString(), arguments: arguments);
  }

  void goBack({dynamic navResult}) {
    // need to implement a stack to maintain multiple levels of going back...
    _currentRoute = null;
    _currentArguments = null;
    if (navigatorKey.currentState!.canPop()) {
      return navigatorKey.currentState!.pop(navResult);
    } else {
      print('NavigationService: goBack: Cannot pop');
    }
  }

  void goHome() {
    bool homeRouteExists = false;
    navigatorKey.currentState!.popUntil((route) {
      if (route.settings.name == 'RouteName.Home') {
        //print('NavigationService: goHome: found home page');
        homeRouteExists = true;
        return true;
      } else if (route.settings.name == 'RouteName.Login') {
        //print('NavigationService: goHome: found login page');
        return true;
      }
      return false;
    });

    if (!homeRouteExists) {
      //print('NavigationService: goHome: home route does not exist');
      navigatorKey.currentState!
          .pushReplacementNamed(RouteName.home.toString());
    }
    _currentRoute = RouteName.home;
  }

  void navigateFromHomeTo(RouteName routeName, {dynamic arguments}) {
    goHome();
    navigateTo(routeName, arguments: arguments);
  }

  void goBackWithResultFromSearch<T extends Object>(T result) {
    // We might not need these just for popping the search component with the result
    // _currentRoute = null;
    // _currentArguments = null;
    return navigatorKey.currentState!.pop(result);
  }

  void onGenerateRoute(String? routeName, dynamic arguments) {
    print(
        'NavigationService: onGenerateRoute: route name = $routeName: args = $arguments');
  }

  void dispose() {
    print('NavigationService: ... disposed');
  }
}
