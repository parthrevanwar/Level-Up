import 'package:circle_list/circle_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/semseter_controller.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';
import 'package:mark_it/src/features/HomePage/models/subject_model.dart';
import 'package:mark_it/src/features/HomePage/screens/menu_drawer/menu_drawer.dart';
import 'package:mark_it/src/features/HomePage/screens/semseter_screen/add_subject.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subject.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';
import '../../../../repository/pdf_repository/firebasestroegaeapi.dart';
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

class _SemesterScreenState extends State<SemesterScreen>with SingleTickerProviderStateMixin {
  final pdfcontroller = Get.put(PdfRepository());
  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());
  final subjectcontroller = Get.put(SubjectController());
  final semestercontroller = Get.put(SemesterController());
  final materialcontroller = Get.put(MaterialController());
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  late ScrollController _scrollController;
  late AnimationController _hideFabAnimController;
  int counter = 0;

  void refresh(int childValue) {
    setState(() {
      counter = childValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
      // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
      // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
      // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppTheme.colors.DARK_SKYBLUE,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
              left: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Semester ${semestercontroller.semester}",
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: MenuDrawer(
          notifyParent: (counter) {
            refresh(counter);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("semester")
              .doc(semestercontroller.semester)
              .collection("Subjects")
              .where(branchcontroller.branch, isEqualTo: true)
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
                    final delrefrence = firebaseStorage
                        .ref()
                        .child(docs[index]["Reference"]);
                    Fluttertoast.showToast(msg: docs[index]["Reference"]);
                    try {
                      await FirebaseStorageApi.deleteFolder(
                          path: docs[index]["Reference"]);
                      // await delrefrence.delete();
                      await FirebaseFirestore.instance
                          .collection("semester")
                          .doc(semestercontroller.semester)
                          .collection("Subjects")
                          .doc(docs[index].id)
                          .delete();
                      Fluttertoast.showToast(
                          msg: "Subject deleted successfully");
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FadeTransition(
        opacity: _hideFabAnimController,
        child: ScaleTransition(
          scale: _hideFabAnimController,
          child: FloatingActionButton.extended(
            backgroundColor: AppTheme.colors.DARK_SKYBLUE,
            elevation: 1,
            isExtended: true,
            label: Text(
              'Switch Sem',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CircleList(
                    showInitialAnimation: true,
                    animationSetting: AnimationSetting(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.fastOutSlowIn),
                    outerCircleColor: Colors.white,
                    children: List.generate(
                      8,
                      (index) => ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        child: MaterialButton(
                          height: 60,
                          minWidth: 60,
                          color: (index + 1) == int.parse(semestercontroller.semester)
                              ? AppTheme.colors.DARK_SKYBLUE
                              : AppTheme.colors.WHITE,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 36,
                                color: AppTheme.colors.BLACK,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            setState(
                              () {
                                int ans=index + 1;
                                semestercontroller.semester = ans.toString();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Visibility(
      //   visible: admincontroller.admin == true ,
      //   child: FloatingActionButton(
      //
      //     child: const Icon(
      //       Icons.add,
      //     ),
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (BuildContext context) => AddSubject()));
      //     },
      //   ),
      // ),
    );
  }
}
