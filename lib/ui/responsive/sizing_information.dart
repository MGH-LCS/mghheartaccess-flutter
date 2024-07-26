//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.
import 'package:flutter/material.dart';
import 'package:mghheartaccess/enums/device_screen_type.dart';

class SizingInformation {
  final DeviceScreenType? deviceScreenType;
  final Size? screenSize;
  final Size? localWidgetSize;

  SizingInformation({
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
