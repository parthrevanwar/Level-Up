import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';

import '../models/link_model.dart';
import 'branchcontroller.dart';

class LinkController extends GetxController {
  static LinkController get instance => Get.find();

  final _firebasefirestore = FirebaseFirestore.instance;
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final branchcontroller = Get.put(BranchController());

  final title = TextEditingController();
  final link = TextEditingController();

  void clearText() {
    title.clear();
    link.clear();
  }

  Future<void> addlink() async {
    try {
      await _firebasefirestore
          .collection("semester")
          .doc(semestercontroller.semester)
          .collection("Subjects")
          .doc(subjectcontroller.subject.id)
          .collection("Links")
          .add({
        "Title": title.text,
        "Link": link.text,
      });
      Fluttertoast.showToast(msg: "Link added.");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<LinkModel>> getlinks() async {
    final result = await _firebasefirestore
        .collection("semester")
        .doc(semestercontroller.semester)
        .collection(branchcontroller.branch)
        .doc(subjectcontroller.subject.id)
        .collection("Links").get();
    return result.docs.map((e) => LinkModel.fromSnapshot(e)).toList();
  }
}
