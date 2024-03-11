import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/branchcontroller.dart';
import 'package:mark_it/src/features/HomePage/models/subject_model.dart';

class SubjectController extends GetxController {
  static SubjectController get instance => Get.find();

  final _firebasefirestore = FirebaseFirestore.instance;
  final branchcontroller = Get.put(BranchController());

  late SubjectModel subject ;

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
      String reference="StudyMaterial/semseter_$semester/${branchcontroller.branch}/$subtitle";
      await _firebasefirestore.collection("semester").doc(semester)
          .collection(branchcontroller.branch)
          .add({
        "ShortForm": title,
        "Name": subtitle,
        "SubjectId": subjectid,
        "Reference": reference,
      });
      Fluttertoast.showToast(msg: "Subject added.");
    } catch (e) {
      Fluttertoast.showToast(msg: "error adding subject,try again");
    }
  }
}


