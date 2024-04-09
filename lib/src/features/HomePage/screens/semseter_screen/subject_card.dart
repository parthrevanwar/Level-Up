import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.press,
      required this.delet});

  final title;
  final subtitle;

  final VoidCallback press;
  final VoidCallback delet;

  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/Computer.png',
                  height: 32,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            color: AppTheme.colors.STEEL,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 36,
                ),
                admincontroller.superadmin == true
                    ? IconButton(
                        onPressed: delet,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                    : Container(),
              ],
            ),
            const SizedBox(height: 10,),
            Divider(
              thickness: 1,
              color: AppTheme.colors.border,
            ),
          ],
        ),
      ),
    );
  }
}
