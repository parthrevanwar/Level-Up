import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';

class LinkController extends GetxController {
  static LinkController get instance => Get.find();

  final _firebasefirestore = FirebaseFirestore.instance;
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());

  final title = TextEditingController();
  final link = TextEditingController();

  void clearText() {
    title.clear();
    title.clear();
    link.clear();
  }

  Future<void> addlink() async {
    try {
      await _firebasefirestore
          .collection("semester")
          .doc(semestercontroller.semester)
          .collection("Subject")
          .doc(subjectcontroller.subject.id)
          .collection("Links")
          .add({
        "Title": title.text,
        "Name": link.text,
      });
      Fluttertoast.showToast(msg: "Link added.");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
