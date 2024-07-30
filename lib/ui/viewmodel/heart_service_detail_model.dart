import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HeartServiceDetailModel extends BaseModel {
  late HeartService heartService;

  init(HeartService heartService) {
    heartService = heartService;
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
        print('HeartServiceDetailModel: logged call_service firebase event');
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
