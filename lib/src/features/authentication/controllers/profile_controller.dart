import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

import '../models/user.dart';


class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();

  final _authRepo= Get.put(AuthenticationRepository());
  final _userRepo= Get.put(UserRepository());

   late UserModel currUser;

  getUserData(){
    final email=_authRepo.firebaseUser.value?.email;
    if(email!=null){
      return _userRepo.getUserDetails(email);
    }else{
      Fluttertoast.showToast(msg: "Login to continue");
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<void> isdataarrived() async {
    String? email=FirebaseAuth.instance.currentUser!.email;
    final adminRef = FirebaseFirestore.instance.collection("Admin");
    try{
      final userobj = await adminRef.where("Email", isEqualTo: email).get();
      final userData = userobj.docs.first;
      currUser =UserModel.fromSnapshot(userData);
    }catch(e){
      Fluttertoast.showToast(msg: "error loading user");
    }

  }


}