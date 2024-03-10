import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/authentication/controllers/profile_controller.dart';
import 'package:mark_it/src/features/authentication/models/user.dart';
import 'package:mark_it/src/common_widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/pdf_repository/pdf_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

class MenuDrawer extends StatefulWidget {
  MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {

  final profilecontroller = Get.put(ProfileController());

  final firebaseuser=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: AppTheme.colors.lightgray,
              child: Image.network(firebaseuser!.photoURL.toString()),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(firebaseuser!.displayName.toString(),
              style: TextStyle(fontSize: 35),
            ),
            Text(firebaseuser!.email.toString(),
              style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.colors.lightgray
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Spacer(),
            CustomElevetedButtonDark(
                press: () {
                  AuthenticationRepository.instance.logout();
                },
                name: "Logout"),
          ],
        ),
      ),
    );
  }
}
