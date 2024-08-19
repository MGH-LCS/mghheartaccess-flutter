import 'package:flutter/material.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/view/exception_view.dart';
import 'package:mghheartaccess/ui/viewmodel/terms_of_use_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView(this.userHasAcceptedTerms, {super.key});

  final bool userHasAcceptedTerms;

  @override
  Widget build(BuildContext context) {
    return BaseView<TermsOfUseModel>(
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) => Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                title: const Text(
                  'Terms Of Use',
                  style: TextStyle(fontSize: 19),
                ),
                leading: userHasAcceptedTerms == true
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          model.goBack();
                        },
                      )
                    : Container(),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: model.scrolledToEnd && !userHasAcceptedTerms
                ? FloatingActionButton.extended(
                    onPressed: () => model.handleContinue(context),
                    label: const Text(
                      "Accept Terms of Use and Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                    /*
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    */
                    backgroundColor: mgbBlue,
                  )
                : Container(),
            body: model.state == ViewState.busy
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 35.0),
                          Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ]))
                : model.exception != null
                    ? MGHHeartExceptionView(
                        exception: model.exception,
                        onRetry: model.handleExceptionRetry)
                    : SafeArea(
                        minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Column(
                          children: [
                            userHasAcceptedTerms
                                ? Container()
                                : const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                                    child: Text(
                                      'please scroll to the bottom to accept terms of use',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                            Expanded(
                              child: WebViewWidget(
                                controller: model.webViewController,
                              ),
                            ),
                          ],
                        ))));
  }
}
