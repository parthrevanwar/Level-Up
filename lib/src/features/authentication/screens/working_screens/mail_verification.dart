import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/authentication/controllers/mail_verification_controller.dart';
import 'package:mark_it/src/features/authentication/screens/working_screens/signin_screen.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';

import '../../../../common_widgets/custom_eleveted_button.dart';
import '../../../utils/theme/theme.dart';
import '../under_development/create_new_password_screen.dart';

class MailVerification extends StatelessWidget {
  MailVerification({super.key});

  final controller = Get.put(MailVerificationController());

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
            Image.asset(
              "assets/images/mailverification.png",
              scale: 3,
            ),
            SizedBox(height: 30),
            Text(
              "Verify your email Address",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "We have just send email verification link on your email .click on the link to verify",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.colors.lightgray,
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "If not autoredirected after verification click on the continue button.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.colors.lightgray,
                  ),
            ),
            SizedBox(height: 30),
            CustomElevetedButtonDark(
                press: () {
                  controller.manuallyCheckEmailVerificationStatus();
                },
                name: "continue"),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {controller.sendVerificationEmail();},
              child: Text(
                "Resend E-mail link",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppTheme.colors.Primary,
                    ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {
                    AuthenticationRepository.instance.logout();
                  },
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,color:AppTheme.colors.Primary ,),
                        SizedBox(width: 5,),
                        Text(
                          "back to login",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppTheme.colors.Primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
