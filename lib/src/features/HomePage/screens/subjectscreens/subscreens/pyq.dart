import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pdfviewscreen.dart';
import '../../../../../repository/pdf_repository/pdf_repo.dart';
import '../../../controllers/Material_controller.dart';
import '../../../controllers/branchcontroller.dart';
import '../../../controllers/pyq_controller.dart';
import '../../../controllers/semseter_controller.dart';
import '../../../controllers/subject_controller.dart';
import '../../../models/pdf_model.dart';
import '../pdfcard.dart';

class PYQScreen extends StatefulWidget {
  PYQScreen({super.key});

  @override
  State<PYQScreen> createState() => _PYQScreenState();
}

class _PYQScreenState extends State<PYQScreen> {
  final pyqcontroller = Get.put(PYQController());
  final materialcontroller = Get.put(MaterialController());
  final pdfrepo = Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final branchcontroller = Get.put(BranchController());

  @override
  void initState() {
    pyqcontroller.getpdf();
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
            .collection("Subjects")
            .doc(subjectcontroller.subject.id)
            .collection("PYQ")
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
                delet: () async {
                  final delrefrence =
                      firebaseStorage.ref().child(docs[index]["Reference"]);
                  try {
                    await delrefrence.delete();
                    await FirebaseFirestore.instance
                        .collection("semester")
                        .doc(semestercontroller.semester)
                        .collection("Subjects")
                        .doc(subjectcontroller.subject.id)
                        .collection("PYQ")
                        .doc(docs[index].id)
                        .delete();
                    Fluttertoast.showToast(msg: "file deleted successfully");
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
