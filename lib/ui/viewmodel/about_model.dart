import 'dart:async';
//import 'dart:io';
//import 'dart:ui';

//import 'package:flutter/services.dart';
//import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class AboutHeartCenterModel extends BaseModel {
  //late final WebViewController webViewController;

  String? pdfPath;

  Future init(HeartCenter heartCenter) async {
    print('AboutHeartCenterModel: init ...');

    /*
    webViewController = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(heartCenter.aboutPageHTML);
    */

    /*
    setState(ViewState.busy);

    await fromAsset('assets/pdf/about_us.pdf', 'about_us.pdf').then((f) {
      pdfPath = f.path;
      print('xxx path = $pdfPath');
    });

    setState(ViewState.idle);
    */
  }

  /*
  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
  */

  handleExceptionRetry() {}
}
