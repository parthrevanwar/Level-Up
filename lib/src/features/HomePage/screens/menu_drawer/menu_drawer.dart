import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mark_it/src/features/HomePage/controllers/branchcontroller.dart';
import 'package:mark_it/src/features/HomePage/screens/admin_console/admin_console.dart';
import 'package:mark_it/src/features/HomePage/screens/announcment_screen/announcement_screen.dart';
import 'package:mark_it/src/features/HomePage/screens/semseter_screen/semester_screen.dart';
import 'package:mark_it/src/features/authentication/controllers/profile_controller.dart';
import 'package:mark_it/src/common_widgets/custom_eleveted_button.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/admincontroller.dart';

int current = 1;

class MenuDrawer extends StatefulWidget {
  MenuDrawer({super.key, required this.notifyParent, this.counter});



  final Function(int) notifyParent;
  final int? counter;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final profilecontroller = Get.put(ProfileController());
  final branchcontroller = Get.put(BranchController());
  final admincontroller = Get.put(AdminController());

  final firebaseuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              firebaseuser!.displayName.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
            accountEmail: Text(
              firebaseuser!.email.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  firebaseuser!.photoURL.toString(),
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: AppTheme.colors.DARK_SKYBLUE,
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              color: (current == 1)
                  ? Color.fromRGBO(128, 128, 128, 0.25)
                  : Colors.white,
            ),
            child: ListTile(
              title: Text(
                "Home",
                style: TextStyle(
                  color: (current == 1)
                      ? AppTheme.colors.DARK_SKYBLUE
                      : AppTheme.colors.STEEL,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              leading: ImageIcon(
                AssetImage("assets/grey icons/browser.png"),
                color:
                (current == 1) ? AppTheme.colors.DARK_SKYBLUE : AppTheme.colors.STEEL,
                size: 22.0,
              ),
              onTap: () {
                current=1;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SemesterScreen(),
                    ));
              },
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              color: (current == 2)
                  ? Color.fromRGBO(128, 128, 128, 0.25)
                  : Colors.white,
            ),
            child: ListTile(
              title: Text(
                "Announcements",
                style: TextStyle(
                  color: (current == 2)
                      ? AppTheme.colors.DARK_SKYBLUE
                      : AppTheme.colors.STEEL,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              leading: Icon(
                FontAwesomeIcons.bullhorn,
                color:
                (current == 2) ? AppTheme.colors.DARK_SKYBLUE : AppTheme.colors.STEEL,
                size: 22.0,
              ),
              onTap: () {
                current=2;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AnnouncementScreen(),
                    ));
              },
            ),
          ),Container(
            decoration: new BoxDecoration(
              color: (current == 4)
                  ? Color.fromRGBO(128, 128, 128, 0.25)
                  : Colors.white,
            ),
            child: ListTile(
              title: Text(
                "Share",
                style: TextStyle(
                  color: (current == 4)
                      ? AppTheme.colors.DARK_SKYBLUE
                      : AppTheme.colors.STEEL,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              leading: ImageIcon(
                AssetImage("assets/grey icons/share-Recovered.png"),
                color:
                (current == 4) ? AppTheme.colors.DARK_SKYBLUE : AppTheme.colors.STEEL,
                size: 22.0,
              ),
              onTap: () async {
                final msgAndLink = await getShareAppUrl();
                // print(msgAndLink);
                Share.share(msgAndLink[0] + " - " + msgAndLink[1],
                    subject:
                    'Checkout the new Sem Breaker App on your Smart Phone.');
              },
            ),
          ),
          (admincontroller.admin)?Container(
            decoration: new BoxDecoration(
              color: (current == 3)
                  ? Color.fromRGBO(128, 128, 128, 0.25)
                  : Colors.white,
            ),
            child: ListTile(
              title: Text(
                "Admin Console",
                style: TextStyle(
                  color: (current == 3)
                      ? AppTheme.colors.DARK_SKYBLUE
                      : AppTheme.colors.STEEL,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              leading: Icon(
                Icons.developer_mode,
                color:
                (current == 3) ? AppTheme.colors.DARK_SKYBLUE : AppTheme.colors.STEEL,
                size: 22.0,
              ),
              onTap: () {
                current=3;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AdminConsole(),
                    ));
              },
            ),
          ):Container(),
          Container(
            decoration: new BoxDecoration(
              color: (current == 5)
                  ? Color.fromRGBO(128, 128, 128, 0.25)
                  : Colors.white,
            ),
            child: ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(
                  color: (current == 5)
                      ? AppTheme.colors.DARK_SKYBLUE
                      : AppTheme.colors.STEEL,
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  fontFamily: 'RobotoMono',
                ),
              ),
              leading: ImageIcon(
                AssetImage("assets/grey icons/logout.png"),
                color:
                (current == 5) ? AppTheme.colors.DARK_SKYBLUE : AppTheme.colors.STEEL,
                size: 22.0,
              ),
              onTap: () {
                current=1;
                AuthenticationRepository.instance.logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<String>> getShareAppUrl() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("playstoreURL").get();
  if (snapshot.docs.isNotEmpty) {
    var data = snapshot.docs.first.data() as Map<String, dynamic>?;
    if (data != null) {
      var msg = data['msg'] ?? "";
      var link = data['link'] ?? "";
      return [msg.toString(), link.toString()];
    } else {
      return ["", ""]; // Return default values or handle the case when data is null
    }
  } else {
    return ["", ""]; // Return default values or handle the case when there are no documents
  }
}