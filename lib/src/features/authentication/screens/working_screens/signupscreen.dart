import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/authentication/models/user.dart';
import 'package:mark_it/src/features/authentication/screens/under_development/otp_verification.dart';
import 'package:mark_it/src/features/authentication/screens/working_screens/signin_screen.dart';
import 'package:mark_it/src/features/authentication/screens/working_screens/social_login_buttons.dart';

import '../../../../common_widgets/custom_eleveted_button.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  Future<bool> fetchAllowedDomains(String domain) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('AllowedDomains').doc('domains');
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data[domain] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkDomain(String email) async {
    // Check if the email contains "@"
    if (email.length < 15) {
      return false;
    }
    int atIndex = email.indexOf('@');
    if (atIndex != -1) {
      String domain = email.substring(atIndex + 1);
      // Fluttertoast.showToast(msg: domain);
      bool ans = await fetchAllowedDomains(domain);
      return ans;
    } else {
      Fluttertoast.showToast(msg: "Email is invalid");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
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
                        hinttext: "Enter the Name",
                        labeltext: "Name"),
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
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      if (controller.username.text == "") {
                        Fluttertoast.showToast(
                            msg: "Username field can't be blank");
                      } else if (await checkDomain(
                          controller.email.text.trim())) {
                        SignUpController.instance.createUser(
                            controller.username.text.trim(),
                          controller.email.text.trim(),
                          controller.password.text.trim(),
                          controller.confirmpassword.text.trim(),
                        );
                      } else {
                        Fluttertoast.showToast(msg: "Email is not valid");
                      }
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
                              builder: (BuildContext context) =>
                                  SignInScreen()));
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
      ),
    );
  }
}
