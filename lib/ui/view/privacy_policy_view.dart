import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/viewmodel/privacy_policy_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PrivacyPolicyModel>(
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: AppBar(
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
              body: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: WebViewWidget(
                      controller: model.webViewController,
                    ),
                  )),
            ));
  }
}
