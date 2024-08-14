import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HeartServiceDetailModel extends BaseModel {
  late HeartService _heartService;

  List<String> viewedTabs = [];

  init(HeartService heartService) async {
    _heartService = heartService;

    // this is the initial view ... log an event
    HeartServiceInfoPage visiblePage = _heartService.infoPageList!.elementAt(0);

    _logPageViewEvent(visiblePage.title);
  }

  _logPageViewEvent(String pageTitle) async {
    if (viewedTabs.contains(pageTitle.toLowerCase())) {
      print(
          'HeartServiceDetailModel: _logTabViewEvent: already logged event for $pageTitle page');
    } else {
      String eventName = '${_heartService.id}_view_${pageTitle.toLowerCase()}';

      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "info_page_name": pageTitle,
          "service_name": _heartService.title,
          "phone": _heartService.phone,
        },
      );
      viewedTabs.add(pageTitle.toLowerCase());
      print(
          'HeartServiceDetailModel: _logTabViewEvent: successfully logged $eventName event');
    }
  }

  Future handleServiceCall(BuildContext context, HeartService svc) async {
    Uri uri = Uri.parse("tel://${svc.phone}");

    if (await canLaunchUrl(uri)) {
      var success = await launchUrl(uri);

      // log firebase event
      if (success) {
        String eventName = 'call_${svc.id}_service';

        await FirebaseAnalytics.instance.logEvent(
          name: eventName,
          parameters: {
            "service_name": svc.title,
            "phone": svc.phone,
          },
        );
        print('HeartServiceDetailModel: logged $eventName event');
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

  handleTabBarTap(int index) async {
    HeartServiceInfoPage page = _heartService.infoPageList!.elementAt(index);
    print('the tab with title = ${page.title} was tapped');
    _logPageViewEvent(page.title);
  }
}
