//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:get_it/get_it.dart';
import 'package:mghheartaccess/application/api.dart';
import 'package:mghheartaccess/application/repository.dart';
import 'package:mghheartaccess/service/authentication_service.dart';
import 'package:mghheartaccess/service/navigation_service.dart';
import 'package:mghheartaccess/ui/viewmodel/about_model.dart';
import 'package:mghheartaccess/ui/viewmodel/heart_service_detail_model.dart';
import 'package:mghheartaccess/ui/viewmodel/home_model.dart';
import 'package:mghheartaccess/ui/viewmodel/privacy_policy_model.dart';
import 'package:mghheartaccess/ui/viewmodel/terms_of_use_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => HeartServiceDetailModel());
  locator.registerFactory(() => AboutHeartCenterModel());

  locator.registerFactory(() => TermsOfUseModel());
  locator.registerFactory(() => PrivacyPolicyModel());
}
