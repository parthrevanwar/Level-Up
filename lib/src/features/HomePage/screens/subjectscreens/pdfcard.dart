import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mark_it/src/features/HomePage/controllers/subject_controller.dart';
import 'package:mark_it/src/features/utils/theme/theme.dart';

import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';

class PdfCard extends StatelessWidget {
  PdfCard(
      {super.key,
      required this.title,
      required this.press,
      required this.url,
      required this.delet});

  final title;
  final url;
  final VoidCallback press;
  final VoidCallback delet;

  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());
  final subjectcontroller = Get.put(SubjectController());

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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: IconButton(
                  onPressed: press,
                  icon: ImageIcon(
                    AssetImage('assets/svgIcons/preview.png'),
                    color: AppTheme.colors.STEEL,
                    size: 25,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: ImageIcon(AssetImage('assets/svgIcons/download.png'),
                    color: AppTheme.colors.STEEL, size: 20),
              ),
              admincontroller.admin == true &&
                      (admincontroller.subjects
                          .contains(subjectcontroller.subject.shortform)||admincontroller.subjects
                          .contains("all"))
                  ? IconButton(
                      onPressed: delet,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                  : Container(),
            ],
          )),
    );
  }
}
//
// class PdfCard extends StatelessWidget {
//   PdfCard({super.key, required this.title, required this.press, required this.url, required this.delet});
//
//   final title;
//   final url;
//   final VoidCallback press;
//   final VoidCallback delet;
//
//   final admincontroller = Get.put(AdminController());
//   final branchcontroller = Get.put(BranchController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 SvgPicture.asset(
//                   "assets/icons/book.svg",
//                   width: 40,
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 const Icon(
//                   Icons.keyboard_arrow_right,
//                   size: 40,
//                 ),
//                 admincontroller.admin && branchcontroller.adminon  ==true ? IconButton(onPressed: delet, icon: Icon(Icons.delete,color: Colors.red,)):Container(),
//               ],
//             ),
//             Divider(thickness: 2,color: AppTheme.colors.border,),
//           ],
//         ),
//       ),
//     );
//   }
// }
