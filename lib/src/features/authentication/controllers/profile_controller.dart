import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

import '../models/user.dart';


class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();

  final _authRepo= Get.put(AuthenticationRepository());
  final _userRepo= Get.put(UserRepository());

  getUserData(){
    final email=_authRepo.firebaseUser.value?.email;
    if(email!=null){
      return _userRepo.getUserDetails(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
  }
}