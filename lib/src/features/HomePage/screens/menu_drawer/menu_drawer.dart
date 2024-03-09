import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/authentication/controllers/profile_controller.dart';
import 'package:mark_it/src/features/authentication/models/user.dart';
import 'package:mark_it/src/common_widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/pdf_repository/pdf_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key});


  final profilecontroller = Get.put(ProfileController());

  final pdfcontroller =Get.put(PdfRepository());

  final semsetercontroller = Get.put(SemesterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          children: [

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
