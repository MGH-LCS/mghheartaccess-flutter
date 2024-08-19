import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyModel extends BaseModel {
  late final WebViewController webViewController;

  Future init() async {
    print('AboutHeartCenterModel: init ...');

    webViewController = WebViewController()
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(const Color(0x00000000))
      //..loadHtmlString(heartCenter.aboutPageHTML);
      ..loadFlutterAsset('assets/html/privacy_policy_ios.html');

    print('AboutHeartCenterModel: init ... done');
  }
}
