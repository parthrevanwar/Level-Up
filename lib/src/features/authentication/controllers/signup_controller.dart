import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/authentication/controllers/signin_controller.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

import '../models/user.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();


  final signincontroller = Get.put(SignInController());
  final userRepo=Get.put(UserRepository());

  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final confirmpassword = TextEditingController();


  Future<void> createUser(UserModel user,String email, String password) async {
    await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
    userRepo.createUser(user);
    signincontroller.loginUser(email, password);


  }
}


