import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mark_it/src/features/authentication/screens/signin_screen.dart';
import 'package:mark_it/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import '../../features/HomePage/homescreen.dart';
import '../../features/authentication/screens/mail_verification.dart';
import '../user_repo/user_repo.dart';
import 'exceptions/myexceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final userRepo=Get.put(UserRepository());

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SignInScreen())
        : user.emailVerified
            ? Get.offAll(() => HomeScreen())
            : Get.offAll(() => MailVerification());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String confirmpassword,user) async {
    if (password == confirmpassword) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        userRepo.createUser(user);

      } on FirebaseAuthException catch (e) {
        final ex = MyExceptions.fromCode(e.code);
        Fluttertoast.showToast(msg: ex.message);
        // Get.snackbar("Error", ex.message);
        throw ex;
      } catch (_) {
        const ex = MyExceptions();
        Fluttertoast.showToast(msg: ex.message);
        // Get.snackbar("Error", ex.message);
        throw ex;
      }
    } else {
      Fluttertoast.showToast(msg: "password did't match, please try again");
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = MyExceptions.fromCode(e.code);
      Fluttertoast.showToast(msg: ex.message);
      // Get.snackbar("Error", ex.message);
      throw ex;
    } catch (_) {
      const ex = MyExceptions();
      Fluttertoast.showToast(msg: ex.message);
      // Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = MyExceptions.fromCode(e.code);
      Fluttertoast.showToast(msg: ex.message);
      // Get.snackbar("Error", ex.message);
      throw ex;
    } catch (_) {
      const ex = MyExceptions();
      Fluttertoast.showToast(msg: ex.message);
      // Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = MyExceptions.fromCode(e.code);
      Fluttertoast.showToast(msg: ex.message);
      // Get.snackbar("Error345", ex.message);
      throw ex;
    } catch (_) {
      const ex = MyExceptions();
      Fluttertoast.showToast(msg: ex.message);
      // Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
