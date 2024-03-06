import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';


class AppTheme {
  static const colors = Appcolors();
  static ThemeData lightTheme=ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
      ),
    ),
  );
}