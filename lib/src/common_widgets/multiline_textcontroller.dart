import 'package:flutter/material.dart';
import '../features/utils/theme/theme.dart';

class MultilineCustomTextField extends StatelessWidget {
  const MultilineCustomTextField({super.key, required this.textcontroller,  required this.hinttext, required this.labeltext});
  final TextEditingController textcontroller;
  final String hinttext;
  final String labeltext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: textcontroller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.colors.verylightblue,
          hintText: hinttext,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppTheme.colors.darkgray,
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppTheme.colors.lightgray,
          ),
          labelText: labeltext,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.border, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
