import 'package:flutter/widgets.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseModel extends BaseModel {
  late final WebViewController webViewController;

  bool scrolledToEnd = false;

  Future init() async {
    setState(ViewState.busy);

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //userHasAccepted = prefs.getBool('userHasAcceptedTermsOfUse') ?? false;

    webViewController = WebViewController()
      ..enableZoom(false)
      ..addJavaScriptChannel('FLUTTER_CHANNEL', onMessageReceived: (message) {
        if (message.message.toString() == "end of scroll") {
          print('end of scroll');
          scrolledToEnd = true;
          notifyListeners();
        }
      })
      //..setOnScrollPositionChange(onScrollPositionChange)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(const Color(0x00000000))
      //..loadHtmlString(heartCenter.aboutPageHTML);
      ..loadFlutterAsset('assets/html/terms_of_use_ios.html');

    print('AboutHeartCenterModel: init ... done');
    setState(ViewState.idle);
  }

  handleExceptionRetry() {}

  handleContinue(BuildContext context) async {
    print('handle continue');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('userHasAcceptedTermsOfUse', true);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  /*
  void onScrollPositionChange(ScrollPositionChange change) {
    print(
        'AboutHeartCenterModel: onScrollPositionChange: change = ${change.y}');
  }
  */
}
