//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:flutter/material.dart';
import 'package:mghheartaccess/application/locator.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/service/navigation_service.dart';
import 'package:mghheartaccess/ui/view/about_view.dart';
import 'package:mghheartaccess/ui/view/heart_service_detail_view.dart';
import 'package:mghheartaccess/ui/view/home_view.dart';

const String initialRoute = "home";

class MGHHeartRouter {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    NavigationService navSvc = locator<NavigationService>();
    navSvc.onGenerateRoute(settings.name, settings.arguments);

    var routeName = settings.name;
    //print('Router: name param = $routeName');

    RouteName routeNameEnum = RouteName.values
        .firstWhere((element) => element.toString() == routeName);

    switch (routeNameEnum) {
      case RouteName.home:
        return FadeRoute(
            settings: RouteSettings(name: routeName), page: const HomeView());

      case RouteName.serviceDetail:
        final HeartService service = settings.arguments as HeartService;
        return MaterialPageRoute(
            settings: RouteSettings(name: routeName),
            builder: (_) => HeartServiceDetailView(service));

      case RouteName.about:
        final HeartCenter center = settings.arguments as HeartCenter;
        return MaterialPageRoute(
            settings: RouteSettings(name: routeName),
            builder: (_) => AboutHeartCenterView(center));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget? page;

  @override
  final RouteSettings settings;

  ScaleRoute({this.page, required this.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}

class FadeRoute extends PageRouteBuilder {
  final Widget? page;

  @override
  final RouteSettings settings;

  FadeRoute({this.page, required this.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class SlideInFromBottomRoute extends PageRouteBuilder {
  final Widget? page;
  @override
  final RouteSettings settings;
  SlideInFromBottomRoute({this.page, required this.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
