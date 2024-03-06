import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mark_it/src/features/authentication/controllers/mail_verification_controller.dart';
import 'package:mark_it/src/features/authentication/screens/signin_screen.dart';
import 'package:mark_it/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import '../../features/HomePage/homescreen.dart';
import '../../features/authentication/screens/mail_verification.dart';
import 'exceptions/myexceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

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
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const SignInScreen())
          : Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.message);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      Get.snackbar("Error", ex.message);
      print('EXCEPTION-${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignInWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.message);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    } catch (_) {}
  }

  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = MyExceptions.fromCode(e.code);
      Get.snackbar("Error", ex.message);
      throw ex;
    } catch (_) {
      const ex = MyExceptions();
      Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = MyExceptions.fromCode(e.code);
      Get.snackbar("Error", ex.message);
      throw ex;
    } catch (_) {
      const ex = MyExceptions();
      Get.snackbar("Error", ex.message);
      throw ex;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
