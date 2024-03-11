import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../repository/pdf_repository/pdf_repo.dart';
import '../../../controllers/Material_controller.dart';
import '../../../controllers/admincontroller.dart';
import '../../../controllers/branchcontroller.dart';
import '../../../controllers/links_controller.dart';
import '../../../controllers/semseter_controller.dart';
import '../../../controllers/subject_controller.dart';

class LinksScreen extends StatefulWidget {
  LinksScreen({super.key});

  @override
  State<LinksScreen> createState() => _LinksScreenState();
}

class _LinksScreenState extends State<LinksScreen> {
  final linkcontroller = Get.put(LinkController());
  final materialcontroller = Get.put(MaterialController());
  final pdfrepo = Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final branchcontroller = Get.put(BranchController());
  final admincontroller = Get.put(AdminController());

  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    linkcontroller.getlinks();
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
            .collection("Links")
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
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Container(
                  height: 60,
                  child: Card(
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        docs[index]["Title"],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      trailing:
                      admincontroller.admin! ==true ?
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          try{
                            await FirebaseFirestore.instance
                                .collection("semester")
                                .doc(semestercontroller.semester)
                                .collection(branchcontroller.branch)
                                .doc(subjectcontroller.subject.id)
                                .collection("Links").doc(docs[index].id).delete();
                            Fluttertoast.showToast(msg: "Link deleted successfully");
                          }catch (e){
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        },
                      ):
                      IconButton(
                        icon: const Icon(Icons.link),
                        onPressed: () {
                          final Uri uri = Uri(
                              scheme: "https", host: docs[index]["Link"]);
                          setState(() {
                            _launched = _launchInBrowser(uri);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
