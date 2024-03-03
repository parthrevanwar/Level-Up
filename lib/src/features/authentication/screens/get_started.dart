import 'package:flutter/material.dart';
import 'package:mark_it/src/features/authentication/screens/signin_screen.dart';
import 'package:mark_it/src/features/authentication/screens/signupscreen.dart';
import 'package:mark_it/src/features/common%20widgets/custom_eleveted_button.dart';

import '../../utils/theme/theme.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              children: [
                Spacer(),
                CustomElevetedButtonDark(press: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => SignInScreen()));
                }, name: "Login"),
                SizedBox(height: 20,),
                CustomElevetedButtonLight(press: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => SignUpScreen()));
                }, name: "Register"),
                SizedBox(height: 20,),
                Text(
                  "Continue as a guest",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                    color: AppTheme.colors.Primary,
                  ),
                ),
              ],
            ),
          ), /* add child content here */
      ),
    );
  }
}

