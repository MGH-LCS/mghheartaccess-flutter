import 'package:flutter/material.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/viewmodel/about_model.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

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
                title: const Text(
                  'About Us',
                  //heartCenter.aboutPageTitle,
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
            body: SafeArea(
              minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: PdfViewer.openAsset(
                    'assets/pdf/about_us.pdf',
                    // show the page-2
                  )),
            )));
  }
}
