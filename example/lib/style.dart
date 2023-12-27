import 'package:flutter/material.dart';

class Themes {
  //Colors for theme
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color darkPrimary = Colors.grey[900]!;
  static Color lightGreen = const Color(0xffedf2ca);
  static Color accentGreen = const Color(0xff00c853);
  static Color lightAccent = Colors.blueGrey[900]!;
  static Color darkAccent = Colors.white;
  static Color lightBG = const Color(0xfffcfcff);
  static Color darkBG = Colors.grey[900]!;
  static Color badgeColor = Colors.red;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // backgroundColor: lightBG,
    colorScheme: const ColorScheme.light().copyWith(
      background: lightBG, // Your accent color
    ),
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black87)),
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
        color: darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),

      // iconTheme: IconThemeData(
      //   color: lightAccent,
      // ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // backgroundColor: darkBG,
    colorScheme: const ColorScheme.dark().copyWith(
      background: darkBG, // Your accent color
    ),
    canvasColor: darkPrimary,
  );
}
