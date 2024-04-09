
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';


class AppTheme {
  static const colors = Appcolors();
  static ThemeData lightTheme=ThemeData(
    splashColor: Constants.SKYBLUE,
    fontFamily: 'Montserrat',
    primaryColor: Constants.DARK_SKYBLUE,
    primaryIconTheme: IconThemeData(
      color: Colors.white,
    ),
    indicatorColor: Constants.WHITE,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      },
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.colors.DARK_SKYBLUE,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold),
    )
  );
}