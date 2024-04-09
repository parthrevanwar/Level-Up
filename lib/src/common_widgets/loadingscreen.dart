import 'package:flutter/material.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator(
        color: AppTheme.colors.DARK_SKYBLUE,
      )),
    );
  }
}
