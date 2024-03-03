import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phonenumber = TextEditingController();

  void registerUser (String email, String password){
      AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}