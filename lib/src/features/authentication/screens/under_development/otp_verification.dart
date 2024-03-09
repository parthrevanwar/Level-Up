import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mark_it/src/features/authentication/screens/under_development/create_new_password_screen.dart';

import '../../../../common_widgets/custom_eleveted_button.dart';
import '../../../utils/theme/theme.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              "OTP Verification",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter the verification code we just sent on your email address.",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppTheme.colors.lightgray,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OtpTextField(
              showCursor: false,
              fieldWidth: 60,
              numberOfFields: 4,
              borderWidth: 1,
              borderRadius: BorderRadius.circular(10),
              disabledBorderColor: AppTheme.colors.black,
              enabledBorderColor: AppTheme.colors.lightgray,
              focusedBorderColor: AppTheme.colors.Primary,
              showFieldAsBox :true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppTheme.colors.verylightblue,
              ),
            ),
            SizedBox(height: 30),
            CustomElevetedButtonDark(press: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CreateNewPasswordScreen()));
            }, name: "Verify"),
            SizedBox(
              height: 20,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t received code? ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.colors.black,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                  },
                  child: Text(
                    "Resend",
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
