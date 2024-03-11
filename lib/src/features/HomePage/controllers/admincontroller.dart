import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  bool? admin =false  ;
  bool? superadmin = false  ;

  final newadminname = TextEditingController();
  final newadminemail = TextEditingController();


  Future<void> isadmin() async {
    String? email=FirebaseAuth.instance.currentUser!.email;
    final adminRef = FirebaseFirestore.instance.collection("Admin");
    final userobj = await adminRef.where("Email", isEqualTo: email).get();
    if (userobj.docs.isNotEmpty) {
      final userData = userobj.docs.first.data();
      admin = userData["Admin"];
      superadmin=userData["SuperAdmin"];
      Fluttertoast.showToast(msg: "admin: $admin,superadmin: $superadmin");
    }
  }
  Future<void> addadmin() async {
    try {
      await FirebaseFirestore.instance.collection("Admin").add({
        "Name": newadminname.text,
        "Email": newadminemail.text,
        "Admin": true ,
        "SuperAdmin": false,
      });
      Fluttertoast.showToast(msg: "admin added");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
