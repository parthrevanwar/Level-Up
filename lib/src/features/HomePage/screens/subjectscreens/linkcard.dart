import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';

import '../../../utils/theme/theme.dart';
import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';

class LinkCard extends StatelessWidget {
  LinkCard(
      {super.key,
      required this.title,
      required this.press,
      required this.delet});

  final title;
  final VoidCallback press;
  final VoidCallback delet;

  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());
  final subjectcontroller =Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(14, 18, 18, 18),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: press,
                  icon: ImageIcon(
                      AssetImage('assets/svgIcons/external Link.png'),
                      color: AppTheme.colors.STEEL,
                      size: 20),
                ),
                admincontroller.admin == true &&
                        (admincontroller.subjects.contains(
                                subjectcontroller.subject.shortform) ||
                            admincontroller.subjects.contains("all"))
                    ? IconButton(
                        onPressed: delet,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                    : Container(),
              ],
            ),
          )),
    );
  }
}
