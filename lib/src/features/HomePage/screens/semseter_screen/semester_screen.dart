import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'components/subject_card.dart';

class SemesterScreen extends StatefulWidget {
  SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  final pdfcontroller = Get.put(PdfRepository());
  final semestercontroller = Get.put(SemesterController());
  final subjectcontroller = Get.put(SubjectController());

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
        child: MenuDrawer(),
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
                  .doc("${semestercontroller.semester}")
                  .collection("Subject")
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
