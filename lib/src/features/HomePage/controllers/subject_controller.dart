import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController {
  static SubjectController get instance => Get.find();

  final _firebasefirestore = FirebaseFirestore.instance;

  final title = TextEditingController();
  final subtitle = TextEditingController();
  final subjectid = TextEditingController();

  void clearText() {
    title.clear();
    subtitle.clear();
    subjectid.clear();
  }

  Future<void> addsubject(String title,String subtitle,String subjectid,
      String semester) async {
    try {
      await _firebasefirestore.collection("semester").doc(semester)
          .collection("Subject")
          .add({
        "Title": title,
        "SubTitle": subtitle,
        "SubjectId": subjectid,
      });
      Fluttertoast.showToast(msg: "Subject added.");
    } catch (e) {
      Fluttertoast.showToast(msg: "error adding subject,try again");
    }
  }
}


