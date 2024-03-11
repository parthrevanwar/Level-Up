import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/models/pdf_model.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/pdfcard.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pdfviewscreen.dart';
import '../../../../../repository/pdf_repository/pdf_repo.dart';
import '../../../controllers/Material_controller.dart';
import '../../../controllers/branchcontroller.dart';
import '../../../controllers/semseter_controller.dart';
import '../../../controllers/subject_controller.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final materialcontroller = Get.put(MaterialController());
  final pdfrepo = Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final _firebasefirestore = FirebaseFirestore.instance;
  final branchcontroller = Get.put(BranchController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("semester")
            .doc(semestercontroller.semester)
            .collection(branchcontroller.branch)
            .doc(subjectcontroller.subject.id)
            .collection("Material")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var docs = snapshot.data!.docs;
          Fluttertoast.showToast(msg: "${docs.length}");
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return PdfCard(
                title: docs[index]["Name"],
                url: docs[index]["Url"],
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => PdfViewer(
                          url: docs[index]["Url"],
                          title: docs[index]["Name"],
                        ),
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
