import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/links_controller.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_data/add_link.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_data/add_material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_data/add_pyq.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/links.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pyq.dart';
import '../../controllers/Material_controller.dart';
import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';
import '../../controllers/pyq_controller.dart';
import '../../controllers/subject_controller.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});


  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen>
    with SingleTickerProviderStateMixin {
  final subjectcontroller = Get.put(SubjectController());
  final materialcontroller = Get.put(MaterialController());
  final pyqcontroller = Get.put(PYQController());
  final linkcontroller = Get.put(LinkController());
  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          materialcontroller.getpdf();
          pyqcontroller.getpdf();
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectcontroller.subject.name,
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
        leading: BackButton(),
        backgroundColor: Colors.white,
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text(
                "Material",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Tab(
              child: Text(
                "Links",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Tab(
              child: Text(
                "PYQ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
          indicatorColor: Color.fromARGB(255, 32, 159, 166),
          controller: _tabController,
          labelColor: Color.fromARGB(255, 32, 159, 166),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MaterialScreen(
          ),
          LinksScreen(
          ),
          PYQScreen(
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: admincontroller.admin == true && branchcontroller.adminon,
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            switch(_tabController.index){
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddMaterial(),
                    ));
                break;
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddLink(),
                    ));
                break;
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddPYQ(),
                    ));
                break;
            }
          },
        ),
      ),
    );
  }
}
