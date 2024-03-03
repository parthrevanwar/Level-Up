import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';


class AppTheme {
  static const colors = Appcolors();
  static ThemeData lightTheme=ThemeData(
    brightness: Brightness.light,
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    )
  );
}