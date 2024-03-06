import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/authentication/controllers/profile_controller.dart';
import 'package:mark_it/src/features/authentication/models/user.dart';
import 'package:mark_it/src/features/common%20widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final profilecontroller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          children: [
            FutureBuilder(
              future: profilecontroller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user= snapshot.data as UserModel;
                    return Column(
                      children: [
                        Spacer(),
                        SizedBox(
                          height: 60,
                          child: Text(user.username),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                          child: Text(user.email.toString()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                          child: Text(user.id.toString()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    return Container(child: Text(snapshot.error.toString()),);
                  }
                  else{
                    return Container(child: Text("something went wrong"),);
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            CustomElevetedButtonDark(
                press: () {
                  AuthenticationRepository.instance.logout();
                },
                name: "Logout"),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
