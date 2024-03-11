import 'package:flutter/material.dart';
import 'package:mark_it/src/features/HomePage/screens/menu_drawer/menu_drawer.dart';

import '../../../utils/theme/theme.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.white,
        title: Text("Announcements"),
        shape: Border(
            bottom: BorderSide(
              color: AppTheme.colors.lightgray,
              width: 2,
            )),
      ),
      drawer: MenuDrawer(notifyParent: (int ignoreit){},),
    );
  }
}
