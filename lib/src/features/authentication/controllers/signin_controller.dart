import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

import '../models/user.dart';


class SignInController extends GetxController{
  static SignInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser (String email, String password){
    final auth=AuthenticationRepository.instance;
    auth.loginUserWithEmailAndPassword(email, password);
    auth.setInitialScreen(auth.firebaseUser as User?);
  }
}