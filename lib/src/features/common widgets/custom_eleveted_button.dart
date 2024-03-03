import 'package:flutter/material.dart';

class CustomElevetedButton extends StatelessWidget {
  const CustomElevetedButton({super.key, required this.press, required this.name});
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
      ),
    );
  }
}
