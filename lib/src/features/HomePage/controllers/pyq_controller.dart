import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';
import 'package:mark_it/src/features/HomePage/models/subject_model.dart';
import 'package:mark_it/src/repository/pdf_repository/pdf_repo.dart';

import '../models/pdf_model.dart';
import 'branchcontroller.dart';

class PYQController extends GetxController {
  static PYQController get instance => Get.find();

  final pdfrepo= Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firebasefirestore = FirebaseFirestore.instance;
  final branchcontroller = Get.put(BranchController());

  final pdftitle = TextEditingController();

  void addpyq (String title){
    pdfrepo.pickFile( "PYQ",title);
  }


  Future<List<PdfModel>> getpdf() async {
    final result = await _firebasefirestore
        .collection("semester")
        .doc(semestercontroller.semester)
        .collection(branchcontroller.branch)
        .doc(subjectcontroller.subject.id)
        .collection("PYQ").get();
    return result.docs.map((e) => PdfModel.fromSnapshot(e)).toList();
  }
}
