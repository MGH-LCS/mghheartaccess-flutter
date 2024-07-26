//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:mghheartaccess/application/locator.dart';
import 'package:mghheartaccess/application/repository.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/model/exception.dart';
import 'package:mghheartaccess/service/navigation_service.dart';

class BaseModel extends ChangeNotifier {
  Exception? _exception;

  NavigationService navSvc = locator<NavigationService>();
  Repository repo = locator<Repository>();

  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  Exception? get exception => _exception;

  void setState(ViewState viewState) {
    _state = viewState;

    try {
      notifyListeners();
    } catch (e) {
      print('BaseModel: setState: error: $e');
    }
  }

  void setException(dynamic exception) {
    if (exception == null) {
      _exception = null;
      return;
    }
    if (exception is Exception) {
      _exception = exception;
    } else {
      _exception = MGHHeartDeviceExcepton(exception.toString());
    }
  }

  void goBack({dynamic navResult}) {
    navSvc.goBack(navResult: navResult);
  }

  void goHome() {
    navSvc.goHome();
  }
}
