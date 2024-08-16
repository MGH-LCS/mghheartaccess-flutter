//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mghheartaccess/application/config.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/model/user.dart';
import 'package:mghheartaccess/service/navigation_service.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeModel extends BaseModel with WidgetsBindingObserver {
  GlobalKey get homeScaffoldKey => navSvc.homeScaffoldKey;

  late HeartCenter heartCenter;

  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  Future init(User user) async {
    print('HomeModel: init ...');

    setState(ViewState.busy);

    // has the user accepted the user agreement
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userHasAcceptedTermsOfUse =
        prefs.getBool('userHasAcceptedTermsOfUse') ?? false;

    if (!userHasAcceptedTermsOfUse) {
      print('user has not accepted terms yet');
      navSvc.navigateTo(RouteName.termsOfUse, arguments: false);
    } else {
      print('user has accepted user agreement');
    }

    // get package info for drawer
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

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
          name: "call_${svc.id}_service",
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
        onPressed: () {
          Navigator.pop(context);
        },
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
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      //throw 'Could not launch $url';
    }
  }

  void navigateToTermsOfUse(BuildContext context) {
    navSvc.navigateTo(RouteName.termsOfUse, arguments: true);
  }

  void navigateToPrivacyPolicy(BuildContext context) {
    navSvc.navigateTo(RouteName.privacyPolicy);
  }

  void navigateToFeedback(BuildContext context) {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'htlappsupport@partners.org',
        queryParameters: {'subject': 'Feedback'});
    launchUrl(emailLaunchUri);
  }

  void navigateToRateAppPage(BuildContext context) {
    final InAppReview inAppReview = InAppReview.instance;
    inAppReview.openStoreListing(appStoreId: Config.appStoreAppId);
  }

  handleLCSTap(BuildContext context) {
    Navigator.pop(context);
    launchUrl(Uri.parse('http://www.mghlcs.org/'));
  }

  handleHTLTap(BuildContext context) {
    Navigator.pop(context);
    launchUrl(Uri.parse('https://healthcaretransformation.org'));
  }
}

/*

  void navigateToAboutScreen(BuildContext context) {
    print('HomeModel: navigateToAboutScreen');
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutScreen()));
    navSvc.navigateTo(RouteName.about, arguments: heartCenter);
  }
  */