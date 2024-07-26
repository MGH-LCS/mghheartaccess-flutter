import 'package:flutter/material.dart';

Color mgbNavy = const Color(0xff002F7A);
Color mgbBlue = const Color(0xff003A96);
Color mgbCyan = const Color(0xff0077C8);
Color mgbTeal = const Color(0xff009CA6);
Color mgbTealLight = const Color(0xffB1E4E3);
Color mgbGrayLight = const Color(0xffCFCFCF);
Color mgbGray = const Color(0xff707070);
Color mgbBlack = const Color(0xff353535);
Color mgbRed = const Color(0xffCE0037);

Color mghBlue = const Color(0xff213245);
Color mghTeal = const Color(0xff86daf3);

//  Login, App Update, and Splash Screens  //
// Splash Background Image
UIImage splashBackgroundImage = UIImage(
    light: const AssetImage("assets/images/login-background.png"),
    dark: const AssetImage("assets/images/login-dark-background.png"));

//Splash background gradients
UILinearGradient splashBackgroundGradient = UILinearGradient(
  light: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
    stops: const [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.blue[800]!,
      Colors.blue[700]!,
      Colors.blue[600]!,
      Colors.blue[700]!,
      Colors.blue[800]!,
    ],
  ),
  dark: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
    stops: const [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.grey[900]!,
      Colors.grey[800]!,
      Colors.grey[700]!,
      Colors.grey[800]!,
      Colors.grey[900]!,
    ],
  ),
);

//  Class Definitions  //
class UIColor {
  final Color? light;
  final Color? dark;
  UIColor({this.light, this.dark});
}

class UITextStyle {
  final TextStyle? light;
  final TextStyle? dark;
  UITextStyle({this.light, this.dark});
}

class UIDecoration {
  final Decoration? light;
  final Decoration? dark;
  UIDecoration({this.light, this.dark});
}

class UIBoxDecoration {
  final BoxDecoration? light;
  final BoxDecoration? dark;
  UIBoxDecoration({this.light, this.dark});
}

class UIImage {
  final AssetImage? light;
  final AssetImage? dark;
  UIImage({this.light, this.dark});
}

class UILinearGradient {
  final LinearGradient? light;
  final LinearGradient? dark;
  UILinearGradient({this.light, this.dark});
}

UIBoxDecoration sortDropdownButtonDecoration = UIBoxDecoration(
  light: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
    border: Border.all(color: Colors.grey[300]!),
    color: Colors.grey[300],
  ),
  dark: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
    border: Border.all(color: Colors.black38),
    color: Colors.black,
  ),
);
