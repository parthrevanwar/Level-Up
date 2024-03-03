import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mark_it/src/features/authentication/signin_screen.dart';

import '../common widgets/custom_eleveted_button.dart';
import '../utils/theme/theme.dart';
import 'create_new_password_screen.dart';

class PasswordSuccessfulScreen extends StatelessWidget {
  const PasswordSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(height: 30),
            SvgPicture.asset("assets/images/greentick.svg"),
            SizedBox(height: 30),
            Text(
              "Password Changed!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Your password has been changed\nsuccessfully.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.colors.lightgray,
                  ),
            ),
            SizedBox(height: 30),
            CustomElevetedButtonDark(
                press: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignInScreen()));
                },
                name: "Back to Login"),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
