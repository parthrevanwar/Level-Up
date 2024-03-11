import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/admincontroller.dart';
import '../menu_drawer/menu_drawer.dart';
import 'add_admin.dart';
import 'admin_card.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole({super.key});

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {

  final admincontroller = Get.put(AdminController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.white,
        title: Text("Admin Console"),
        shape: Border(
            bottom: BorderSide(
              color: AppTheme.colors.lightgray,
              width: 2,
            )),
      ),
      drawer: MenuDrawer(notifyParent: (int ignoreit){},),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Admin")
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
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return AdminCard(
                delet: () async {
                  try{
                    await FirebaseFirestore.instance
                        .collection("Admin")
                        .doc(docs[index].id).delete();
                    Fluttertoast.showToast(msg: "admin removed successfully");
                  }catch (e){
                    Fluttertoast.showToast(msg: e.toString());
                  }

                },
                Name: docs[index]["Name"],
                email: docs[index]["Email"],);
                // return PdfCard(
                //   title: docs[index]["Name"],
                //   url: docs[index]["Email"],
                //   press: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (BuildContext context) => PdfViewer(
                //             url: docs[index]["Url"],
                //             title: docs[index]["Name"],
                //           ),
                //         ));
                //   },
                //   delet: () async {
                //     final delrefrence = firebaseStorage.ref().child(docs[index]["Reference"]);
                //     try{
                //       await delrefrence.delete();
                //       await FirebaseFirestore.instance
                //           .collection("semester")
                //           .doc(semestercontroller.semester)
                //           .collection(branchcontroller.branch)
                //           .doc(subjectcontroller.subject.id)
                //           .collection("Material").doc(docs[index].id).delete();
                //       Fluttertoast.showToast(msg: "file deleted successfully");
                //
                //     }catch (e){
                //       Fluttertoast.showToast(msg: e.toString());
                //     }
                //   },
                // );
              },
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: admincontroller.admin==true && admincontroller.superadmin==true,
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddAdmin()));
          },
        ),
      ),
    );
  }
}
