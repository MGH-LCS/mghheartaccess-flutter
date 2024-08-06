import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyModel extends BaseModel {
  late final WebViewController webViewController;

  Future init() async {
    print('AboutHeartCenterModel: init ...');

    /*
    not sure if we want an HTML version of this page??
    for now, lets just use flutter widgets 

    webViewController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(heartCenter.aboutPageHTML);
    */

    print('AboutHeartCenterModel: init ... done');
  }
}
