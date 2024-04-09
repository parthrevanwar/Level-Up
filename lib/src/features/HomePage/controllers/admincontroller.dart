import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  late bool admin;
  late bool superadmin;
  late List<String> subjects;

  final newadminname = TextEditingController();
  final newadminemail = TextEditingController();
  final newadminsubjects = TextEditingController();

  @override
  void onClose() {
    newadminname.dispose();
    newadminemail.dispose();
    newadminsubjects.dispose();
    super.onClose();
  }

  Future<void> isadmin() async {
    String? email = FirebaseAuth.instance.currentUser!.email;
    final adminRef = FirebaseFirestore.instance.collection("Admin");

    try {
      final userobj = await adminRef.where("Email", isEqualTo: email).get();

      if (userobj.docs.isNotEmpty) {
        final userData = userobj.docs.first.data();
        admin = userData["Admin"];
        superadmin = userData["SuperAdmin"];
        subjects = List<String>.from(userData["Subjects"] ?? []);

        Fluttertoast.showToast(
            msg: "admin: $admin, superadmin: $superadmin"
        );
      } else {
        admin = false;
        superadmin = false;
        subjects = [];
      }
    } catch(e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> addadmin() async {
    try {
      String name = newadminname.text.trim();
      String email = newadminemail.text.trim();
      List<String> inputSubjects =
      newadminsubjects.text.trim().split(',').map((s) => s.trim()).toList();

      await FirebaseFirestore.instance.collection("Admin").add({
        "Name": name,
        "Email": email,
        "Admin": true,
        "SuperAdmin": false,
        "Subjects": inputSubjects, // Store subjects as an array of strings
      });

      Fluttertoast.showToast(msg: "Admin added");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}