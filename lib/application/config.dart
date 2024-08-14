//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

enum Flavor { dev, staging, prod }

class Config {
  static const String appStoreAppId = '1451245966';

  static const String appGroupId = 'group.edu.harvard.mgh.heart';

  static Flavor? appFlavor;

  static bool get isProduction => appFlavor == Flavor.prod;

  static bool get isDev => appFlavor == Flavor.dev;

  static bool get isBeta => appFlavor == Flavor.staging;

  static String get homeTitle {
    switch (appFlavor) {
      case Flavor.prod:
        return 'MGH Heart';
      case Flavor.staging:
        return 'MGH Heart (Beta)';
      case Flavor.dev:
      default:
        return 'MGH Heart (Dev)';
    }
  }

  static String get appName {
    switch (appFlavor) {
      case Flavor.prod:
      case Flavor.staging:
      case Flavor.dev:
      default:
        return 'MGH Heart';
    }
  }
}
