//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.
import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/responsive/sizing_information.dart';
import 'package:mghheartaccess/ui/utils/ui_utils.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget? Function(
    BuildContext context,
    SizingInformation sizingInformation,
  )? builder;
  const ResponsiveBuilder({super.key, this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      var mediaQuery = MediaQuery.of(context);
      var sizingInformation = SizingInformation(
        deviceScreenType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize:
            Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return builder!(context, sizingInformation)!;
    });
  }
}
