import 'dart:ui';

import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutHeartCenterModel extends BaseModel {
  late final WebViewController webViewController;

  Future init(HeartCenter heartCenter) async {
    print('AboutHeartCenterModel: init ...');

    webViewController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(heartCenter.aboutPageHTML);
  }
}
