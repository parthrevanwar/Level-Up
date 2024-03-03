import 'package:flutter/material.dart';
import 'package:mark_it/src/features/authentication/screens/signin_screen.dart';
import 'package:mark_it/src/features/authentication/screens/social_login_buttons.dart';

import '../../common widgets/custom_eleveted_button.dart';
import '../../common widgets/custom_text_field.dart';
import '../../utils/theme/theme.dart';
import 'otp_verification.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _emailcontroller = TextEditingController();

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
              "Forgot Password?",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Don't worry! It occurs. Please enter the email address linked with your account.",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppTheme.colors.lightgray,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                textcontroller: _emailcontroller,
                hinttext: "Enter an email",
                labeltext: "Email"),
            SizedBox(height: 30),
            CustomElevetedButtonDark(press: (){
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => OtpScreen()));
            }, name: "Send Code"),
            SizedBox(
              height: 20,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember Password? ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => SignInScreen()));
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.colors.Primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
