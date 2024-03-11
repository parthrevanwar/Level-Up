import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/theme/theme.dart';
import '../../controllers/admincontroller.dart';

class AdminCard extends StatefulWidget {
  AdminCard(
      {super.key,
      required this.Name,
      required this.email,
      required this.delet});

  final Name;
  final email;
  final VoidCallback delet;

  @override
  State<AdminCard> createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  final admincontroller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.Name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.email,
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
              admincontroller.superadmin==true ? IconButton(
                  onPressed: widget.delet,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )):Container(),
            ],
          ),
          Divider(
            thickness: 2,
            color: AppTheme.colors.border,
          ),
        ],
      ),
    );
  }
}
