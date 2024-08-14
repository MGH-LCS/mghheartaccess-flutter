import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/viewmodel/terms_of_use_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TermsOfUseModel>(
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: AppBar(
                  title: const Text(
                    'Terms Of Use / User Agreement',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
              body: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: WebViewWidget(
                    controller: model.webViewController,
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
