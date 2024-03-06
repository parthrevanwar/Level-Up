import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/authentication/models/user.dart';
import 'package:mark_it/src/features/authentication/screens/otp_verification.dart';
import 'package:mark_it/src/features/authentication/screens/signin_screen.dart';
import 'package:mark_it/src/features/authentication/screens/social_login_buttons.dart';

import '../../common widgets/custom_eleveted_button.dart';
import '../../common widgets/custom_text_field.dart';
import '../../utils/theme/theme.dart';
import '../controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

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
              "Hello! Register to get\nstarted",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      textcontroller: controller.username,
                      hinttext: "Enter a username",
                      labeltext: "Username"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      textcontroller: controller.email,
                      hinttext: "Enter an email",
                      labeltext: "Email"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      textcontroller: controller.password,
                      hinttext: "Enter your password",
                      labeltext: "Password"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      textcontroller: controller.confirmpassword,
                      hinttext: "Confirm your password",
                      labeltext: "Confirm Password"),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            CustomElevetedButtonDark(
                press: () {
                  if (_formKey.currentState!.validate()) {
                    final user = UserModel(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        username: controller.username.text.trim());
                    SignUpController.instance.createUser(
                        user,
                        controller.email.text.trim(),
                        controller.password.text.trim(),
                      controller.confirmpassword.text.trim(),
                    );
                  }
                },
                name: "Sign up"),
            SizedBox(
              height: 20,
            ),
            Row(children: <Widget>[
              Expanded(child: Divider()),
              Text(
                "    Or Register with    ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.colors.lightgray,
                    ),
              ),
              Expanded(child: Divider()),
            ]),
            SizedBox(
              height: 20,
            ),
            SocialLogin(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppTheme.colors.black,
                      ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => SignInScreen()));
                  },
                  child: Text(
                    "Login Now",
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
