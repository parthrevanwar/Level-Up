import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';
import '../models/user.dart';


class MailVerificationController extends GetxController{
  static MailVerificationController get instance => Get.find();

  late Timer _timer;


  @override
  void onInit(){
    super.onInit();
    sendVerificationEmail();
    // setTimeForAutoRedirct();
  }

  Future<void> sendVerificationEmail() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
    }catch(e){
      // Get.snackbar("Oh Snap", e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }

  }

  // void setTimeForAutoRedirct(){
  // _timer= Timer.periodic(Duration(seconds: 1), (timer) {
  //   FirebaseAuth.instance.currentUser?.reload();
  //   final user=FirebaseAuth.instance.currentUser;
  //   if(user!.emailVerified){
  //     _timer.cancel();
  //     AuthenticationRepository.instance.setInitialScreen(user);
  //   }
  // });
  // }

  void manuallyCheckEmailVerificationStatus(){
    FirebaseAuth.instance.currentUser?.reload();
    final user=FirebaseAuth.instance.currentUser;
    if(user!.emailVerified){
      FirebaseAuth.instance.currentUser?.reload();
      final user=FirebaseAuth.instance.currentUser;
    }
  }

}