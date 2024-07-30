import 'package:flutter/material.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/viewmodel/about_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutHeartCenterView extends StatelessWidget {
  const AboutHeartCenterView(this.heartCenter, {super.key});

  final HeartCenter heartCenter;

  @override
  Widget build(BuildContext context) {
    return BaseView<AboutHeartCenterModel>(
        onModelReady: (model) async => await model.init(heartCenter),
        builder: (context, model, child) => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: AppBar(
                  title: Text(
                    heartCenter.aboutPageTitle,
                    style: const TextStyle(fontSize: 19),
                  ),
                ),
              ),
              body: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 16),
                    child: WebViewWidget(
                      controller: model.webViewController,
                    ),
                  )
                  /*
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 100),
                    child: Column(children: [
                      WebViewWidget(
                        controller: model.webViewController,
                      )
                      //HtmlWidget(heartCenter.aboutPageHTML),
                    ]),
                  ),
                ),
                */

                  ),
            ));
  }
}
