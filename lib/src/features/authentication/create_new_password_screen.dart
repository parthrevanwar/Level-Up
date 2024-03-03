import 'package:flutter/material.dart';
import 'package:mark_it/src/features/authentication/signin_screen.dart';
import 'package:mark_it/src/features/authentication/successful_password_change_screen.dart';

import '../common widgets/custom_eleveted_button.dart';
import '../common widgets/custom_text_field.dart';
import '../utils/theme/theme.dart';
import 'otp_verification.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});

  final _newpasswordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0xFFE8ECF4),
                ),
              ),
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_arrow_left_sharp),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Create new password",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Your new password must be unique from those previously used.",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppTheme.colors.lightgray,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                textcontroller: _newpasswordcontroller,
                hinttext: "Enter new password",
                labeltext: "new password"),
            SizedBox(height: 10),
            CustomTextField(
                textcontroller: _confirmpasswordcontroller,
                hinttext: "Confirm new password",
                labeltext: "confirm pasword"),
            SizedBox(height: 30),
            CustomElevetedButtonDark(press: (){
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => PasswordSuccessfulScreen()));
            }, name: "Reset Password"),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
