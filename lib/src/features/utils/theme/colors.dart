import 'package:flutter/material.dart';

class Appcolors{
  final border= const Color(0xFFE8ECF4);
  final lightgray= const Color(0xFF8391A1);
  final darkgray= const Color(0xFF6A707C);
  final Primary= const Color(0xFF35C2C1);
  final white =const Color(0xFFFFFF);
  final black =const Color(0xFF1E232C);
  final verylightblue =const Color(0xFFF7F8F9);
  final SMOKE = const Color(0xffAFAFAF); // Tile separator color
  final MERCURY =const Color(0xffE5E5E5); // Screen BackGround Color
  final STEEL =const Color(0xff7A7A7A); // SubjectFull Name Color
  final SKYBLUE =const Color(0xff79DBE8); // gradient end color
  final DARK_SKYBLUE =const Color(0xff00BCD4); // theme color
  final BLACK =const Color(0xff000000); // subjectcode color
  final WHITE =const Color(0xffFFFFFF);
  const Appcolors();
}


class Constants {
  static const USER_LOGGED_IN = 'is_user_logged_in';
  static const USER_DETAIL_OBJECT = 'user_object';
  static const COLLECTION_NAME_USER = 'userDetails';

  /* Colors */
  static const Color SMOKE = Color(0xffAFAFAF); // Tile separator color
  static const Color MERCURY = Color(0xffE5E5E5); // Screen BackGround Color
  static const Color STEEL = Color(0xff7A7A7A); // SubjectFull Name Color
  static const Color SKYBLUE = Color(0xff79DBE8); // gradient end color
  static const Color DARK_SKYBLUE = Color(0xff00BCD4); // theme color
  static const Color BLACK = Color(0xff000000); // subjectcode color
  static const Color WHITE = Color(0xffFFFFFF);

  static const kTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD9A2EF), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffB600FF), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
