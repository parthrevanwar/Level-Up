import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/links_controller.dart';
import 'package:mark_it/src/features/HomePage/models/subject_model.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_link.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/links.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pyq.dart';
import 'package:mark_it/src/repository/pdf_repository/pdf_repo.dart';

import '../../controllers/Material_controller.dart';
import '../../controllers/pyq_controller.dart';
import '../../controllers/subject_controller.dart';
// import 'package:mark_it/src/repository/subject_repository/subject_repo.dart';

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

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          switch(_tabController.index){
            case 0:
              materialcontroller.addmaterial();
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
              pyqcontroller.addpyq();
              break;
          }
        },
      ),
    );
  }
}
