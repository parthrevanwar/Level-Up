import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';
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
  final branchcontroller = Get.put(BranchController());

  int counter = 0;

  void refresh(int childValue) {
    setState(() {
      counter = childValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Console"),
        ),
        drawer: MenuDrawer(
          notifyParent: (counter) {
            refresh(counter);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Admin").snapshots(),
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
                      if (docs[index]["SuperAdmin"] == true) {
                        Fluttertoast.showToast(msg: "Operation not allowed");
                      } else {
                        try {
                          await FirebaseFirestore.instance
                              .collection("Admin")
                              .doc(docs[index].id)
                              .delete();
                          Fluttertoast.showToast(
                              msg: "admin removed successfully");
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      }
                    },
                    Name: docs[index]["Name"],
                    email: docs[index]["Email"],
                    subjects: docs[index]["Subjects"],
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: Visibility(
          visible: admincontroller.superadmin == true,
          child: SpeedDial(
            icon: Icons.edit,
            activeIcon: Icons.close,
            backgroundColor: AppTheme.colors.DARK_SKYBLUE,
            foregroundColor: Colors.white,
            activeForegroundColor: Colors.white,
            visible: true,
            closeManually: false,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                //speed dial child
                child: Icon(Icons.accessibility),
                backgroundColor: AppTheme.colors.DARK_SKYBLUE,
                foregroundColor: Colors.white,
                label: 'Add Admin',
                labelStyle: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Montserrat',
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddAdmin()));
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.book),
                backgroundColor: AppTheme.colors.DARK_SKYBLUE,
                foregroundColor: Colors.white,
                label: 'Add Subject',
                labelStyle: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Montserrat',
                ),
                onTap: () {},
              ),
            ],
          ),
        )
        // floatingActionButton: Visibility(
        //   visible: admincontroller.superadmin == true,
        //   child: FloatingActionButton(
        //     backgroundColor: AppTheme.colors.DARK_SKYBLUE,
        //     child: const Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (BuildContext context) => AddAdmin()));
        //     },
        //   ),
        // ),
        );
  }
}
