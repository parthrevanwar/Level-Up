import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';
import 'package:mark_it/src/features/HomePage/models/pdf_model.dart';
import 'package:mark_it/src/repository/pdf_repository/pdf_repo.dart';

import 'branchcontroller.dart';

class MaterialController extends GetxController {
  static MaterialController get instance => Get.find();

  final pdftitle = TextEditingController();

  final pdfrepo= Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firebasefirestore = FirebaseFirestore.instance;
  final branchcontroller = Get.put(BranchController());

  void addmaterial (String title){
    pdfrepo.pickFile("Material",title);
  }

  Future<List<PdfModel>> getpdf() async {
      final result = await _firebasefirestore
          .collection("semester")
          .doc(semestercontroller.semester)
          .collection("Subjects")
          .doc(subjectcontroller.subject.id)
          .collection("Material").get();
      return result.docs.map((e) => PdfModel.fromSnapshot(e)).toList();
  }
}
