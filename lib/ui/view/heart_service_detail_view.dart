import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/viewmodel/heart_service_detail_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HeartServiceDetailView extends StatelessWidget {
  const HeartServiceDetailView(this.heartService, {super.key});

  final HeartService heartService;

  @override
  Widget build(BuildContext context) {
    return BaseView<HeartServiceDetailModel>(
        onModelReady: (model) async => await model.init(heartService),
        builder: (context, model, child) => DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(heartService.title),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(115),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: mgbBlue),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Column(
                              children: [
                                Text(
                                  heartService.headerText,
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        TabBar(
                          onTap: (index) => model.handleTabBarTap(index),
                          tabs: <Widget>[
                            ...heartService.infoPageList!
                                .map((page) => Tab(text: page.title)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () =>
                      model.handleServiceCall(context, heartService),
                  label: Text(
                    "${heartService.title} Hotline",
                    style: const TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  backgroundColor: mgbRed,
                ),
                body: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: TabBarView(
                    children: <Widget>[
                      ...heartService.infoPageList!.map(
                        (page) => HeartServiceInfoPageView(page),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class HeartServiceInfoPageView extends StatelessWidget {
  const HeartServiceInfoPageView(
    this.page, {
    super.key,
  });

  final HeartServiceInfoPage page;

  @override
  Widget build(BuildContext context) {
    //return SingleChildScrollView(

    return Column(
      children: [
        // Container(
        //   decoration: BoxDecoration(color: mgbBlue),
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Text(
        //       page.headingText,
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
        Expanded(
          child: WebViewWidget(
            gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())
            },
            controller: WebViewController()
              ..setBackgroundColor(const Color(0x00000000))
              ..enableZoom(false)
              ..loadHtmlString(page.html),
          ),
        )
      ],
    );
  }
}
