import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard({super.key, required this.title, required this.subtitle, required this.press, required this.delet});

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
                SvgPicture.asset(
                  "assets/icons/book.svg",
                  width: 40,
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
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                ),
                admincontroller.admin! ==true && branchcontroller.adminon ?IconButton(onPressed: delet, icon: Icon(Icons.delete,color: Colors.red,)):Container(),
              ],
            ),
            Divider(thickness: 2,color: AppTheme.colors.border,),
          ],
        ),
      ),
    );
  }
}
