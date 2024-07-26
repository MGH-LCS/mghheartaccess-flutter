import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';

class DeviceConfig {
  static late MediaQueryData data;

  static Orientation? orientation;
  static late bool isPortrait;
  static late bool isPhone;

  static double? screenWidth;
  static double? screenHeight;
  //static late double textScale;

  //** PROPERTIES FOR SYSTEM BRIGHNTESS MODE (LIGHT/DARK) */
  static Brightness? brightnessValue;

  //** IF THERE IS ONLY ONE COLOR/DECORATOR IN THE OBJECT IT WILL HANDLE IT */

  Orientation getScreenOrientation(context) =>
      MediaQuery.of(context).orientation;
  bool getIsPortrait(context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;
  double getScreenWidth(context) => MediaQuery.of(context).size.width;
  double getScreenHeight(context) => MediaQuery.of(context).size.height;
  //double getTextScale(context) => MediaQuery.of(context).textScaleFactor;

  Color? getColor(BuildContext context, UIColor color) =>
      isDark(context) ? color.dark ?? color.light : color.light ?? color.dark;
  TextStyle? getTextStyle(BuildContext context, UITextStyle textStyle) =>
      isDark(context)
          ? textStyle.dark ?? textStyle.light
          : textStyle.light ?? textStyle.dark;

  Decoration? getDecoration(BuildContext context, UIDecoration decoration) =>
      isDark(context)
          ? decoration.dark ?? decoration.light
          : decoration.light ?? decoration.dark;
  BoxDecoration? getBoxDecoration(
          BuildContext context, UIBoxDecoration decoration) =>
      isDark(context) ? decoration.dark : decoration.light;
  AssetImage? getAssetImage(BuildContext context, UIImage assetImage) =>
      isDark(context)
          ? assetImage.dark ?? assetImage.light
          : assetImage.light ?? assetImage.dark;
  LinearGradient? getLinearGradient(
          BuildContext context, UILinearGradient linearGradient) =>
      isDark(context)
          ? linearGradient.dark ?? linearGradient.light
          : linearGradient.light ?? linearGradient.dark;

  bool isDark(BuildContext context) =>
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  void init(BuildContext context) {
    data = MediaQuery.of(context);

    orientation = data.orientation;
    isPortrait = orientation == Orientation.portrait;

    screenWidth = data.size.width;
    isPhone = screenWidth! < 600;

    screenHeight = data.size.height;
    //textScale = data.textScaleFactor;

    //** PROPERTIES FOR SYSTEM BRIGHNTESS MODE (LIGHT/DARK) */
    brightnessValue = MediaQuery.of(context).platformBrightness;
  }
}

class Globals {
  static const double xOffsetSidebar = 0.0;
  static const double xOffsetBottomSheet = -20.0;
  static const Offset bottomSheetListOffset = (Offset(xOffsetSidebar, 0));
  static const double phoneScreen = 561;
}
