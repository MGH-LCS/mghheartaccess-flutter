//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/model/user.dart';
import 'package:mghheartaccess/service/navigation_service.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';

class HomeModel extends BaseModel with WidgetsBindingObserver {
  GlobalKey get homeScaffoldKey => navSvc.homeScaffoldKey;

  late HeartCenter heartCenter;

  Future init(User user) async {
    print('HomeModel: init ...');

    setState(ViewState.busy);

    try {
      heartCenter = await repo.getHeartCenter();
    } catch (e) {
      setException(e);
      setState(ViewState.idle);
      return;
    }

    setState(ViewState.idle);
    print('HomeModel: init ... done');
  }

  void handleExceptionRetry() async {
    print('HomeModel: handleExceptionRetry: attempting reload init data');
    setException(null);
    setState(ViewState.busy);
    heartCenter = await repo.getHeartCenter();
    setState(ViewState.idle);
  }

  void openDrawer() {
    navSvc.homeScaffoldKey.currentState?.openDrawer();
  }

  void showServiceDetail(HeartService service) {
    print('HomeModel: showServiceDetail: title = ${service.title}');

    navSvc.navigateTo(RouteName.serviceDetail, arguments: service);
  }

  void navigateToAboutScreen(BuildContext context) {
    print('HomeModel: navigateToAboutScreen');
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutScreen()));
    navSvc.navigateTo(RouteName.about, arguments: heartCenter);
  }
}
