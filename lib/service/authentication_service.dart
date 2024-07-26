//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'package:mghheartaccess/model/user.dart';

class AuthenticationService {
  late StreamController<User?> userController;
  User? authenticatedUser;

  // secure storage for username/pass
  //final _secureStorage = FlutterSecureStorage();

  AuthenticationService() {
    init();
  }

  Future init() async {
    print('AuthenticationService: init ...');
    userController = StreamController<User?>.broadcast();
    print('AuthenticationService: init ... done');
  }
}
