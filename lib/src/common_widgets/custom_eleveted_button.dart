import 'package:flutter/material.dart';

import '../features/utils/theme/theme.dart';

class CustomElevetedButtonDark extends StatelessWidget {
  const CustomElevetedButtonDark({super.key, required this.press, required this.name});
  final VoidCallback press;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: press,
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.colors.DARK_SKYBLUE,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}


class CustomElevetedButtonLight extends StatelessWidget {
  const CustomElevetedButtonLight({super.key, required this.press, required this.name});
  final VoidCallback press;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: press,
        child: Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color:AppTheme.colors.black,),
          ),
        ),
      ),
    );
  }
}
