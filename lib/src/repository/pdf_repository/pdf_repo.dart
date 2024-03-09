import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PdfRepository extends GetxController {
  static PdfRepository get instance => Get.find();

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firebasefirestire = FirebaseFirestore.instance;

  Future<String?> uploadFile(String fileName, File file) async {
    try{
      final refrence =
      firebaseStorage.ref().child("StudyMaterial/$fileName.pdf");
      final uplodetask = await refrence.putFile(file);
      final downlodelink = await refrence.getDownloadURL();
      return downlodelink;
    }catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<void> pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    if (pickedFile != null ) {
      try {
        String filename=pickedFile.files.single.name;
        File file=File(pickedFile.files.single.path!);
        final url = await uploadFile(
            filename,file
        );
        await _firebasefirestire.collection("StudyMaterial").add({
          "Name":filename,
          "Url":url,
        });
        Fluttertoast.showToast(msg: "file upload succesful .");
      }catch(e){
        Fluttertoast.showToast(msg: "error store upload data");
      }
    } else {
      Fluttertoast.showToast(msg: "No file selected .");
    }
  }
}
