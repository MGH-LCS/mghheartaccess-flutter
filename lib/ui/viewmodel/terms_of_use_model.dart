import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseModel extends BaseModel {
  late final WebViewController webViewController;

  Future init() async {
    print('AboutHeartCenterModel: init ...');

    webViewController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(const Color(0x00000000))
      //..loadHtmlString(heartCenter.aboutPageHTML);
      ..loadFlutterAsset('assets/html/terms_of_use_ios.html');

    print('AboutHeartCenterModel: init ... done');
  }
}
