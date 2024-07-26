import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';

class MGHHeartTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: mgbBlue, // MGB blue
        brightness: Brightness.light,
        primaryContainer: mgbBlue,
        secondaryContainer: Colors.grey[200],
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: mgbBlue,
        ),
        foregroundColor: mgbBlue,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: mgbBlue,
        brightness: Brightness.dark,
        primaryContainer: Colors.grey[900],
        secondaryContainer: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
