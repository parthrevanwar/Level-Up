import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/links_controller.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_data/add_link.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_data/add_material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/add_data/add_pyq.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/links.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/material.dart';
import 'package:mark_it/src/features/HomePage/screens/subjectscreens/subscreens/pyq.dart';
import '../../../utils/theme/theme.dart';
import '../../controllers/Material_controller.dart';
import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';
import '../../controllers/pyq_controller.dart';
import '../../controllers/subject_controller.dart';
import '../admin_console/add_admin.dart';

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

  List<String> buttonname=["Add Material","Add Link","Add PYQ"];

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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppTheme.colors.DARK_SKYBLUE,
        title: Text(
          subjectcontroller.subject.shortform,
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
        leading: BackButton(),
        bottom: TabBar(
          tabs: const [
            Tab(
              icon: ImageIcon(AssetImage('assets/svgIcons/book.png')),
              text: "Material",
            ),
            Tab(
              icon: ImageIcon(AssetImage('assets/svgIcons/link.png')),
              text: "Links",
            ),
            Tab(
              icon: ImageIcon(AssetImage('assets/svgIcons/pencil.png')),
              text: "Q. Paper",
            ),
          ],
          controller: _tabController,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 4,
          indicatorPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          indicatorColor: Colors.white,
          labelStyle:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          unselectedLabelColor: AppTheme.colors.SKYBLUE,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MaterialScreen(),
          LinksScreen(),
          PYQScreen(),
        ],
      ),
      floatingActionButton: SpeedDial(
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
          if (admincontroller.admin == true &&
              (admincontroller.subjects
                      .contains(subjectcontroller.subject.shortform) ||
                  admincontroller.subjects.contains("all")))
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: AppTheme.colors.DARK_SKYBLUE,
              foregroundColor: Colors.white,
              label: buttonname[_tabController.index],
              labelStyle: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Montserrat',
              ),
              onTap: () {
                switch (_tabController.index) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddMaterial(),
                        ));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddLink(),
                        ));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddPYQ(),
                        ));
                    break;
                }
              },
            ),
        ],
      ),
    );
  }
}
