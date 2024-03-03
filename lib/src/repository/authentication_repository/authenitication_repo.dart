import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/authentication/screens/signin_screen.dart';
import 'package:mark_it/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import '../../features/HomePage/homescreen.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();
  final _auth=FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  void onReady(){
    firebaseUser= Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    user==null ? Get.offAll(()=>const SignInScreen()) : Get.offAll(()=>const HomeScreen());
  }

  Future<void> createUserWithEmailAndPassword(String email,String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email,password: password);
      firebaseUser.value != null ? Get.offAll(()=>const SignInScreen()) : Get.offAll(()=>const HomeScreen());
    } on FirebaseAuthException catch(e){
      final ex=SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    } catch (_){
      final ex=SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION-${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email,String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email,password: password);
    } on FirebaseAuthException catch(e){
    } catch (_){}
  }

  Future<void> logout() async =>await _auth.signOut();
}