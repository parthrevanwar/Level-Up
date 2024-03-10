import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';
import 'package:mark_it/src/features/HomePage/models/subject_model.dart';
import 'package:mark_it/src/repository/pdf_repository/pdf_repo.dart';

class PYQController extends GetxController {
  static PYQController get instance => Get.find();

  final pdfrepo= Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firebasefirestore = FirebaseFirestore.instance;

  void addpyq (){
    pdfrepo.pickFile( "PYQ");
  }
  List<Map<String, dynamic>> pyqpdfdata=[];

  Future<void> getpdf() async {
    try {
      final result = await _firebasefirestore
          .collection("semester")
          .doc(semestercontroller.semester)
          .collection("Subject")
          .doc(subjectcontroller.subject.id)
          .collection("PYQ").get();
      pyqpdfdata =result.docs.map((e) => e.data()).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: "error fetching pdf");
    }
  }
}
