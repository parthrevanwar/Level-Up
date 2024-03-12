import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:mark_it/src/features/authentication/models/user.dart';
import 'package:mark_it/src/features/authentication/screens/working_screens/signin_screen.dart';
import '../../features/HomePage/controllers/admincontroller.dart';
import '../../features/HomePage/screens/semseter_screen/semester_screen.dart';
import '../../features/authentication/screens/working_screens/mail_verification.dart';
import '../user_repo/user_repo.dart';
import 'exceptions/myexceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final userRepo = Get.put(UserRepository());
  final admincontroller = Get.put(AdminController());

  final _firestore = FirebaseFirestore.instance;

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
            ? setadmin()
            : Get.offAll(() => MailVerification());
  }

  setadmin() async {
    await admincontroller.isadmin();
    Get.offAll(() => SemesterScreen());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String confirmpassword, String Username) async {
    try {
      final usercred= await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final emailattributes = await parseEmail(email);
      final UserModel user=UserModel(
        uid: usercred.user?.uid,
        username:Username,
        email:email,
        collage:emailattributes["College"],
        branch:emailattributes["Branch"],
        year:emailattributes["Year"],
        rollno:emailattributes["RollNumber"],
        photourl:null,
      );
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

  Future<Map<String, String>> parseEmail(String email) async {
    String branch = email.substring(0, 3);
    String year = email.substring(3, 7);
    String rollNo = email.substring(7, 10);
    String college = email.split('@')[1].split('.')[0];
    final branchmap = await fetchbranchcodes();
    return {
      'Branch': branchmap![branch],
      'Year': year,
      'RollNumber': rollNo,
      'College': college,
    };
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
      final usercred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final userGoogle = FirebaseAuth.instance.currentUser!;
      final emailattributes = await parseEmail(userGoogle.email!);
      await _firestore.collection('Users').doc(usercred.user!.uid).set({
        "uid": userGoogle.uid,
        "Email": userGoogle.email!,
        "UserName": userGoogle.displayName!,
        "Collage": emailattributes["College"],
        "Branch": emailattributes["Branch"],
        "Year": emailattributes["Year"],
        "RollNumber": emailattributes["RollNumber"],
        "photoURL": userGoogle.photoURL!,
      });
      return usercred;
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
