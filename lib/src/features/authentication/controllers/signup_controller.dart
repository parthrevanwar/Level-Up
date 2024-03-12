import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/authentication/controllers/signin_controller.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:mark_it/src/repository/user_repo/user_repo.dart';

import '../models/user.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();


  final signincontroller = Get.put(SignInController());
  final userRepo=Get.put(UserRepository());
  final _firestore = FirebaseFirestore.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final confirmpassword = TextEditingController();

  Future<Map<String, dynamic>?> fetchbranchcodes() async {
    DocumentReference docRef =
    _firestore.collection('Branch').doc('branchcodes');
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data;
    } else {
      print('Document does not exist');
      return null;
    }
  }


  Future<void> createUser(String username,String email, String password,confirmpassword) async {
    if (password == confirmpassword) {
      final branchmap = await fetchbranchcodes();
      String branch = email.substring(0, 3);
      if(branchmap![branch]==null){
        Fluttertoast.showToast(msg: "invalid email");
        return ;
      } else{
        await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password,confirmpassword,username);
        signincontroller.loginUser(email, password);
      }
    } else {
      Fluttertoast.showToast(msg: "password did't match, please try again");
    }


  }
}


