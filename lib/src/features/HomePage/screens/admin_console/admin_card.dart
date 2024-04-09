import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/theme/theme.dart';
import '../../controllers/admincontroller.dart';
import '../../controllers/branchcontroller.dart';

class AdminCard extends StatefulWidget {
  AdminCard(
      {super.key,
      required this.Name,
      required this.email,
      required this.delet,
      required this.subjects});

  final Name;
  final email;
  final VoidCallback delet;
  final subjects;

  @override
  State<AdminCard> createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  final admincontroller = Get.put(AdminController());
  final branchcontroller = Get.put(BranchController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.Name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(
                          color: AppTheme.colors.STEEL,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Subjects: ${widget.subjects.join(', ')}",
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
              admincontroller.superadmin == true
                  ? IconButton(
                      onPressed: widget.delet,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                  : Container(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(width: 60,),
              Expanded(
                child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          width: 2,
                          color: AppTheme.colors.DARK_SKYBLUE,
                        )
                      )),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Add Subject",
                      style: TextStyle(
                        color: AppTheme.colors.DARK_SKYBLUE,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: ShapeDecoration(
                      color: AppTheme.colors.DARK_SKYBLUE,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Remove Subject",
                      style: TextStyle(
                        color: Colors.white,

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: AppTheme.colors.lightgray,
          ),
        ],
      ),
    );
  }
}
//
// class _AdminCardState extends State<AdminCard> {
//   final admincontroller = Get.put(AdminController());
//   final branchcontroller = Get.put(BranchController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.person),
//               const SizedBox(
//                 width: 20,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.Name,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 18,
//                       ),
//                     ),
//                     Text(
//                       widget.email,
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               const Icon(
//                 Icons.keyboard_arrow_right,
//                 size: 40,
//               ),
//               admincontroller.superadmin==true && branchcontroller.adminon? IconButton(
//                   onPressed: widget.delet,
//                   icon: Icon(
//                     Icons.delete,
//                     color: Colors.red,
//                   )):Container(),
//             ],
//           ),
//           Divider(
//             thickness: 2,
//             color: AppTheme.colors.border,
//           ),
//         ],
//       ),
//     );
//   }
// }
