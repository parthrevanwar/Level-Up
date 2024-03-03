import 'package:flutter/material.dart';
import 'package:mark_it/src/features/authentication/get_started.dart';
import 'package:mark_it/src/features/authentication/signin_screen.dart';
import 'package:mark_it/src/features/authentication/signupscreen.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: GetStarted(),
    );
  }
}

