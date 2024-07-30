//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/model/user.dart';
import 'package:mghheartaccess/service/navigation_service.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeModel extends BaseModel with WidgetsBindingObserver {
  GlobalKey get homeScaffoldKey => navSvc.homeScaffoldKey;

  late HeartCenter heartCenter;

  Future init(User user) async {
    print('HomeModel: init ...');

    setState(ViewState.busy);

    try {
      heartCenter = await repo.getHeartCenter();
    } catch (e) {
      setException(e);
      setState(ViewState.idle);
      return;
    }

    setState(ViewState.idle);
    print('HomeModel: init ... done');
  }

  void handleExceptionRetry() async {
    print('HomeModel: handleExceptionRetry: attempting reload init data');
    setException(null);
    setState(ViewState.busy);
    heartCenter = await repo.getHeartCenter();
    setState(ViewState.idle);
  }

  void openDrawer() {
    navSvc.homeScaffoldKey.currentState?.openDrawer();
  }

  void showServiceDetail(HeartService service) async {
    print('HomeModel: showServiceDetail: title = ${service.title}');

    navSvc.navigateTo(RouteName.serviceDetail, arguments: service);

    await FirebaseAnalytics.instance.logEvent(
      name: "show_service_detail",
      parameters: {
        "service_name": service.title,
      },
    );
    print('HomeModel: logged show_service_detail firebase event');
  }

  void navigateToAboutScreen(BuildContext context) {
    print('HomeModel: navigateToAboutScreen');
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutScreen()));
    navSvc.navigateTo(RouteName.about, arguments: heartCenter);
  }

  Future handleServiceCall(BuildContext context, HeartService svc) async {
    Uri uri = Uri.parse("tel://${svc.phone}");

    if (await canLaunchUrl(uri)) {
      var success = await launchUrl(uri);

      // log firebase event
      if (success) {
        await FirebaseAnalytics.instance.logEvent(
          name: "call_service",
          parameters: {
            "service_name": svc.title,
            "phone": svc.phone,
          },
        );

        print('HomeModel: logged call_service firebase event');
      }
    } else {
      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Dialing error"),
        content: Text('there was a problem dialing the number ${svc.phone}'),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      //throw 'Could not launch $url';
    }
  }
}
