import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyModel extends BaseModel {
  late final WebViewController webViewController;

  Future init() async {
    print('AboutHeartCenterModel: init ...');

    String asseetPath;
    if (Platform.isIOS) {
      asseetPath = 'assets/html/privacy_policy_ios.html';
    } else if (Platform.isAndroid) {
      asseetPath = 'assets/html/privacy_policy_android.html';
    } else {
      asseetPath = 'assets/html/privacy_policy_ios.html';
    }

    webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            } else if (request.url.contains("tel:")) {
              launchUrl(Uri.parse(request.url));
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(const Color(0x00000000))
      //..loadHtmlString(heartCenter.aboutPageHTML);
      ..loadFlutterAsset(asseetPath);

    print('AboutHeartCenterModel: init ... done');
  }
}
