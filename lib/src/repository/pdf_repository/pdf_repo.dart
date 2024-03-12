import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../features/HomePage/controllers/branchcontroller.dart';
import '../../features/HomePage/controllers/semseter_controller.dart';
import '../../features/HomePage/controllers/subject_controller.dart';

class PdfRepository extends GetxController {
  static PdfRepository get instance => Get.find();

  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final branchcontroller = Get.put(BranchController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firebasefirestore = FirebaseFirestore.instance;

  Future<String?> uploadFile(
      String fileName, File file, String subjectname, String type) async {
    try {
      final refrence = firebaseStorage.ref().child(
          "StudyMaterial/semester_${semestercontroller.semester}/Subjects/$subjectname/$type/$fileName");
      final uplodetask = await refrence.putFile(file);
      final downlodelink = await refrence.getDownloadURL();
      return downlodelink;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<void> pickFile(String type,String title) async {
    final pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    if (pickedFile != null) {
      try {
        String filename = pickedFile.files.single.name;
        File file = File(pickedFile.files.single.path!);
        final url = await uploadFile(
            filename, file, subjectcontroller.subject.name, type);
        await _firebasefirestore
            .collection("semester")
            .doc(semestercontroller.semester)
            .collection("Subjects")
            .doc(subjectcontroller.subject.id)
            .collection(type)
            .add({
          "Name": title,
          "Reference":"StudyMaterial/semester_${semestercontroller.semester}/Subjects/${subjectcontroller.subject.name}/$type/$filename",
          "Url": url,
        });
        Fluttertoast.showToast(msg: "file upload succesful .");
      } catch (e) {
        Fluttertoast.showToast(msg: "error store upload data");
      }
    } else {
      Fluttertoast.showToast(msg: "No file selected .");
    }
  }
}
