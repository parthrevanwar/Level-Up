import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';
import 'package:mark_it/src/features/HomePage/models/subject_model.dart';
import 'package:mark_it/src/features/HomePage/screens/menu_drawer/menu_drawer.dart';
import 'package:mark_it/src/features/HomePage/screens/semseter_screen/add_subject.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subject.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';
import '../../../../repository/pdf_repository/pdf_repo.dart';
import '../../controllers/Material_controller.dart';
import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';
import 'subject_card.dart';

class SemesterScreen extends StatefulWidget {
  SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {

  final pdfcontroller = Get.put(PdfRepository());
  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());
  final subjectcontroller = Get.put(SubjectController());
  final semestercontroller = Get.put(SemesterController());
  final materialcontroller = Get.put(MaterialController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  int counter = 0;

  void refresh(int childValue) {
    setState(() {
      counter = childValue;
    });
  }

  @override
  void initState() {
    admincontroller.isadmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.white,
        title: Text("Semester ${semestercontroller.semester}"),
        shape: Border(
            bottom: BorderSide(
          color: AppTheme.colors.lightgray,
          width: 2,
        )),
      ),
      drawer: Drawer(
        child: MenuDrawer(
          notifyParent: (counter) {
            refresh(counter);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: DropdownButton(
                    value: semestercontroller.semester,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: semestercontroller.items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        semestercontroller.semester = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("semester")
                  .doc(semestercontroller.semester)
                  .collection(branchcontroller.branch)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("connection error...");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...");
                }
                var docs = snapshot.data!.docs;
                Fluttertoast.showToast(msg: "${docs.length}");
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return SubjectCard(
                      title: docs[index]["ShortForm"],
                      subtitle: docs[index]["Name"],
                      press: () {
                        subjectcontroller.subject =
                            SubjectModel.fromSnapshot(docs[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SubjectScreen(),
                            ));
                      },
                      delet: () async {
                        final delrefrence = firebaseStorage.ref().child(docs[index]["Reference"]);
                        Fluttertoast.showToast(msg: docs[index]["Reference"]);
                        try{
                          await delrefrence.delete();
                          await FirebaseFirestore.instance
                              .collection("semester")
                              .doc(semestercontroller.semester)
                              .collection(branchcontroller.branch)
                              .doc(docs[index].id).delete();
                          Fluttertoast.showToast(msg: "file deleted successfully");

                        }catch (e){
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: admincontroller.admin==true,
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddSubject()));
          },
        ),
      ),
    );
  }
}
