import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

import '../../controllers/admincontroller.dart';

class PdfCard extends StatelessWidget {
  PdfCard({super.key, required this.title, required this.press, required this.url, required this.delet});

  final title;
  final url;
  final VoidCallback press;
  final VoidCallback delet;

  final admincontroller = Get.put(AdminController());

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
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                ),
                admincontroller.admin! ==true ? IconButton(onPressed: delet, icon: Icon(Icons.delete,color: Colors.red,)):Container(),
              ],
            ),
            Divider(thickness: 2,color: AppTheme.colors.border,),
          ],
        ),
      ),
    );
  }
}
